Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293504AbSB1RX4>; Thu, 28 Feb 2002 12:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293626AbSB1RVV>; Thu, 28 Feb 2002 12:21:21 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:12416
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S293527AbSB1RTL>; Thu, 28 Feb 2002 12:19:11 -0500
Date: Thu, 28 Feb 2002 09:18:55 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200202281718.g1SHItT14948@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.5-dj2
In-Reply-To: <20020226223406.A26905@suse.de>
In-Reply-To: <20020226223406.A26905@suse.de>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I need to use the patch below to get isofs.o to compile properly when
I don't have CONFIG_ZISOFS set.  Without this patch neither branch was
being executed in that case.

Cheers,
Wayne

--- linux-2.5.5-dj2/fs/isofs/Makefile.orig	Thu Feb 28 09:10:30 2002
+++ linux-2.5.5-dj2/fs/isofs/Makefile	Thu Feb 28 08:44:10 2002
@@ -11,9 +11,7 @@
 
 ifeq ( $(CONFIG_ZISOFS), y )
 	obj-y  := compress.o namei.o inode.o dir.o util.o rock.o
-endif
-
-ifeq ( $(CONFIG_ZISOFS), n )
+else
 	obj-y  := namei.o inode.o dir.o util.o rock.o
 endif
 

