Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWFULOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWFULOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWFULOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:14:35 -0400
Received: from bambus1.net.skarpam.net ([83.142.194.78]:37330 "EHLO
	orbiter.attika.ath.cx") by vger.kernel.org with ESMTP
	id S1751502AbWFULOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:14:34 -0400
Date: Wed, 21 Jun 2006 13:14:30 +0200
From: Piotr Kaczuba <pepe@attika.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: [x86_64] PC speaker doesn't work
Message-ID: <20060621111430.GA5753@attika.ath.cx>
References: <20060619171544.GA4363@attika.ath.cx>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20060619171544.GA4363@attika.ath.cx>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It turned out that the following change is needed when the speaker is
compiled as a module.

Piotr Kaczuba


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pcspkr.diff"

diff -u -r linux.old/arch/x86_64/kernel/setup.c linux/arch/x86_64/kernel/setup.c
--- linux.old/arch/x86_64/kernel/setup.c	2006-06-21 13:01:39.671274579 +0200
+++ linux/arch/x86_64/kernel/setup.c	2006-06-21 12:46:59.805517772 +0200
@@ -1440,7 +1440,7 @@
 	.show =	show_cpuinfo,
 };
 
-#ifdef CONFIG_INPUT_PCSPKR
+#if defined(CONFIG_INPUT_PCSPKR) || defined(CONFIG_INPUT_PCSPKR_MODULE)
 #include <linux/platform_device.h>
 static __init int add_pcspkr(void)
 {

--5vNYLRcllDrimb99--
