Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWFPQxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWFPQxF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 12:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWFPQxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 12:53:04 -0400
Received: from palrel13.hp.com ([156.153.255.238]:4320 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1751498AbWFPQxD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 12:53:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH} Enable OProfile on Pentium D
Date: Fri, 16 Jun 2006 09:53:02 -0700
Message-ID: <6C21311CEE34E049B74CC0EF339464B96A169D@cacexc12.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH} Enable OProfile on Pentium D
Thread-Index: AcaRZVSmDQ4iAJ32SWu1dmixqYyuig==
From: "Santos, Jose Renato G" <joserenato.santos@hp.com>
To: <linux-kernel@vger.kernel.org>
Cc: <alan@lxorguk.ukuu.org.uk>, <levon@movementarian.org>
X-OriginalArrivalTime: 16 Jun 2006 16:53:03.0195 (UTC) FILETIME=[551742B0:01C69165]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

OProfile does not recognize Pentium D (Intel cpu model 6 for p4 family) 
This prevents Oprofile from using hw performance counters on those CPUs
This patch enables Oprofile on those CPUs.

Please cc me on your response as I do not subscribe to the list
Thanks

Signed-off-by: Jose Renato Santos <jsantos@hpl.hp.com>

---------------------------

diff -aur linux-2.6.16-orig/arch/i386/oprofile/nmi_int.c
linux-2.6.16/arch/i386/oprofile/nmi_int.c
--- linux-2.6.16-orig/arch/i386/oprofile/nmi_int.c	2006-06-16
09:35:38.000000000 -0700
+++ linux-2.6.16/arch/i386/oprofile/nmi_int.c	2006-06-15
17:03:42.000000000 -0700
@@ -301,7 +301,7 @@
 {
 	__u8 cpu_model = boot_cpu_data.x86_model;
 
-	if (cpu_model > 4)
+	if ((cpu_model > 6) || (cpu_model == 5))
 		return 0;
 
 #ifndef CONFIG_SMP

