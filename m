Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSEYH2P>; Sat, 25 May 2002 03:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSEYH2O>; Sat, 25 May 2002 03:28:14 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:37390 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S313867AbSEYH2O>; Sat, 25 May 2002 03:28:14 -0400
Date: Sat, 25 May 2002 09:28:11 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Miles Lane <miles@megapathdsl.net>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.18 -- build failure -- suspend.c:1052: dereferencing pointer
 to incomplete type
In-Reply-To: <3CEF2DAA.8030902@megapathdsl.net>
Message-ID: <Pine.LNX.4.33.0205250926340.1977-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2002, Miles Lane wrote:

> I have included the error, the output of ver_linux and
> snippets of .config.

I have not yet analyzed why I don't get this failunre, but does the 
following patch fix it for you?

Tim


--- linux-2.5.18/kernel/suspend.c	Sat May 25 09:25:30 2002
+++ linux-2.5.18/kernel/suspend.c	Sat May 25 09:25:44 2002
@@ -66,6 +66,7 @@
 #include <linux/swap.h>
 #include <linux/pm.h>
 #include <linux/device.h>
+#include <linux/sched.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>

