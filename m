Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTJAIEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbTJAIEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:04:35 -0400
Received: from mail.tactel.se ([195.22.66.197]:19933 "EHLO mail.tactel.se")
	by vger.kernel.org with ESMTP id S261970AbTJAIEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:04:22 -0400
To: Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: Radeon framebuffer problems i 2.6.0-test6
Message-ID: <1064995393.3f7a8a411bf1f@mail.tactel.se>
Date: Wed, 01 Oct 2003 10:03:13 +0200 (CEST)
From: Pontus Fuchs <pontus.fuchs@tactel.se>
Cc: linux-kernel@vger.kernel.org, ajoshi@shell.unixbox.com
References: <7gisna11e1.fsf@serena.fsr.ku.dk> <16250.4701.976132.141380@wombat.chubb.wattle.id.au>
In-Reply-To: <16250.4701.976132.141380@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
X-Originating-IP: 213.143.39.32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Quoting Peter Chubb <peter@chubb.wattle.id.au>:
> Try this patch that's been floating around for a while.
> 
> Ani, can you please push this patch to Linus?  It fixes the Radeon
> problems for a lot of people.

In addition I need the following patch for radeonfb to work on my Asus L5.
See http://bugs.xfree86.org/show_bug.cgi?id=561 for more info.

--- radeonfb.c.orig	2003-09-20 11:47:53.000000000 +0200
+++ radeonfb.c	2003-10-01 09:38:23.000000000 +0200
@@ -1099,7 +1099,7 @@
 	printk("radeonfb: detected DFP panel size from BIOS: %dx%d\n",
 		rinfo->panel_xres, rinfo->panel_yres);
 
-	for(i=0; i<20; i++) {
+	for(i=0; i<21; i++) {
 		tmp0 = rinfo->bios_seg + readw(tmp+64+i*2);
 		if (tmp0 == 0)
 			break;

Pontus Fuchs

