Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311964AbSCQIUD>; Sun, 17 Mar 2002 03:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311965AbSCQITx>; Sun, 17 Mar 2002 03:19:53 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:57536 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311964AbSCQITs>; Sun, 17 Mar 2002 03:19:48 -0500
Date: Sun, 17 Mar 2002 10:02:57 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Subject: [PATCH] Natsemi Geode GXn Extended MMX
In-Reply-To: <Pine.LNX.4.44.0203170926300.6387-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0203171001470.6387-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here it is without the PM stuff, also i seemed to have diffed it wrong 
last time.

	Zwane

--- linux-2.4.19-pre2-ac/arch/i386/kernel/setup.c.orig	Sun Mar 17 10:14:20 2002
+++ linux-2.4.19-pre2-ac/arch/i386/kernel/setup.c	Sun Mar 17 10:32:52 2002
@@ -1509,6 +1509,9 @@
 
 		/* GXm supports extended cpuid levels 'ala' AMD */
 		if (c->cpuid_level == 2) {
+			/* Enable Natsemi MMX extensions */
+			setCx86(CX86_CCR7, getCx86(CX86_CCR7) | 1);
+
 			get_model_name(c);  /* get CPU marketing name */
 			/*
 	 		 *	The 5510/5520 companion chips have a funky PIT

