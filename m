Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267480AbTBIXNy>; Sun, 9 Feb 2003 18:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267472AbTBIXNy>; Sun, 9 Feb 2003 18:13:54 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:30600 "EHLO
	humilis.humilis.net") by vger.kernel.org with ESMTP
	id <S267470AbTBIXNx>; Sun, 9 Feb 2003 18:13:53 -0500
Date: Mon, 10 Feb 2003 00:21:54 +0100
From: Ookhoi <ookhoi@humilis.net>
To: elmer@ylenurme.ee
Cc: mingo@elte.hu, rusty@rustcorp.com.au
Subject: [PATCH] linux-2.5.59/drivers/net/aironet4500_core.c
Message-ID: <20030210002154.N19693@humilis>
Reply-To: ookhoi@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Uptime: 19:47:27 up 13 days,  7:48, 22 users,  load average: 1.03, 0.93, 0.86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I need this patch to compile 2.5.59 with aironet support.

It seems that a patch from Ingo broke this driver early october 2002.

drivers/built-in.o(.text+0x3d19a): In function `awc_private_init':
: undefined reference to `awc_work'
make: *** [.tmp_vmlinux1] Error 1

I pulled 2.5 from bk to see if the patch was in already, and it is not.

Can you please apply this patch?


--- linux-2.5.59/drivers/net/aironet4500_core.c.orig	2003-02-09 23:54:02.000000000 +0100
+++ linux-2.5.59/drivers/net/aironet4500_core.c	2003-02-09 23:54:19.000000000 +0100
@@ -2210,7 +2210,7 @@
 
 
 void
-awc_bh(struct net_device *dev){
+awc_work(struct net_device *dev){
 
         struct awc_private * priv = (struct awc_private *)dev->priv;
       	int  active_interrupts;
