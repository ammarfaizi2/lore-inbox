Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbUBWFcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 00:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUBWFcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 00:32:10 -0500
Received: from everest.2mbit.com ([24.123.221.2]:20150 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261809AbUBWFcE (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 00:32:04 -0500
Message-ID: <40399012.1050205@greatcn.org>
Date: Mon, 23 Feb 2004 13:30:58 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
Organization: GreatCN.org & The Summit Open Source Develoment Group
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Coywolf Qi Hunt <coywolf@greatcn.org>, Linux-Kernel@vger.kernel.org,
       tao@acc.umu.se, Riley@Williams.Name, davej@codemonkey.org.uk,
       alan@lxorguk.ukuu.org.uk, root@chaos.analogic.com, torvalds@osdl.org
References: <403114D9.2060402@lovecn.org> <40318FB0.6060109@lovecn.org> <4036D2EB.1090709@greatcn.org> <4036DA90.2030709@zytor.com>
In-Reply-To: <4036DA90.2030709@zytor.com>
X-Scan-Signature: 606d05678d99939d828f76c30af4f056
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: Re: [2.0.40 2.2.25 2.4.25] Fix boot GDT limit 0x800 to 0x7ff in setup.S
 or not
Content-Type: multipart/mixed;
 boundary="------------020106070308080301030507"
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 3.1 (built Tue Oct 14 21:11:59 EST 2003)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020106070308080301030507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:

> Coywolf Qi Hunt wrote:
> 
>>
>> Please fix 0x8000 to 0x800 in 2.4, and 0x800 to 0x7ff in 2.0~2.4, ok?
>> This is my last appeal.
>>
> 
> Submit a patch.
> 
>     -hpa


(A patch enclosed for fix 0x800 to 0x7ff for 2.4.25)

-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

--------------020106070308080301030507
Content-Type: text/plain;
 name="patch-cy0402231"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-cy0402231"

--- arch/i386/boot/setup.S.orig	2003-11-29 02:26:20.000000000 +0800
+++ arch/i386/boot/setup.S	2004-02-23 01:15:42.000000000 +0800
@@ -1093,7 +1093,7 @@
 	.word	0				# idt limit = 0
 	.word	0, 0				# idt base = 0L
 gdt_48:
-	.word	0x8000				# gdt limit=2048,
+	.word	0x7ff				# gdt limit=2047,
 						#  256 GDT entries
 
 	.word	0, 0				# gdt base (filled in later)

--------------020106070308080301030507--

