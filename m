Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbUBWOC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 09:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUBWOCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 09:02:55 -0500
Received: from everest.2mbit.com ([24.123.221.2]:63688 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261867AbUBWOCv (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 09:02:51 -0500
Message-ID: <403A07D8.5050704@greatcn.org>
Date: Mon, 23 Feb 2004 22:02:00 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
Organization: GreatCN.org & The Summit Open Source Develoment Group
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: tao@acc.umu.se, alan@lxorguk.ukuu.org.uk
CC: Linux-Kernel@vger.kernel.org
References: <403114D9.2060402@lovecn.org>
In-Reply-To: <403114D9.2060402@lovecn.org>
X-Scan-Signature: 7b1bcffb8e935917f4dd3178f61920aa
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [PATCH] Fix GDT limit in setup.S for 2.0 and 2.2
Content-Type: multipart/mixed;
 boundary="------------000300080207070806060906"
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 3.1 (built Tue Oct 14 21:11:59 EST 2003)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000300080207070806060906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I posted this problem days ago. Just now I check FreeBSD code and find 
theirs code goes no this problem. Please take my patches for 2.0 and 2.2
2.4 patch have been already sent to Anvin.

(patches for 2.0 and 2.2 enclosed)


	Coywolf


-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

--------------000300080207070806060906
Content-Type: text/plain;
 name="patch-cy0402233-2.0.39"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-cy0402233-2.0.39"

--- setup.S.orig	1999-06-14 01:21:00.000000000 +0800
+++ setup.S	2004-02-23 21:36:42.000000000 +0800
@@ -744,7 +744,7 @@
 	.word	0,0			! idt base=0L
 
 gdt_48:
-	.word	0x800		! gdt limit=2048, 256 GDT entries
+	.word	0x7ff		! gdt limit=2047, 256 GDT entries
 	.word	512+gdt,0x9	! gdt base = 0X9xxxx
 
 !

--------------000300080207070806060906
Content-Type: text/plain;
 name="patch-cy0402234-2.2.25"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-cy0402234-2.2.25"

--- setup.S.orig	2001-11-03 00:39:06.000000000 +0800
+++ setup.S	2004-02-23 21:42:22.000000000 +0800
@@ -907,7 +907,7 @@
 	.word	0,0			! idt base=0L
 
 gdt_48:
-	.word	0x800		! gdt limit=2048, 256 GDT entries
+	.word	0x7ff		! gdt limit=2047, 256 GDT entries
 	.word	0, 0		! gdt base (filled in later)
 
 !

--------------000300080207070806060906--
