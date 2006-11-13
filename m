Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754230AbWKMJXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbWKMJXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbWKMJXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:23:37 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:56720 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1754230AbWKMJXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:23:36 -0500
Date: Mon, 13 Nov 2006 10:23:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Amit Choudhary <amit2030@gmail.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] implement-system-call-mini-HOWTO.txt
In-Reply-To: <20061112221437.3572c275.amit2030@gmail.com>
Message-ID: <Pine.LNX.4.61.0611131013000.26222@yvahk01.tjqt.qr>
References: <20061112221437.3572c275.amit2030@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 12 2006 22:14, Amit Choudhary wrote:
>+*How is it invoked?
>+--A library routine issues a trap to the OS by executing INT 0x80 assembly instruction.
>+--The system call number is passed through the EAX register.
>+--The arguments are passed through registers  EBX, ECX, etc.

A nice short description, however, not all of the world runs x86 and may 
not know E?X. Just mention that you will describe the process based on 
x86.

>+*The Makefile in dir "mycall" will have only one line:
>+
>+#####Makefile Start#####
>+obj-y := mycall.o
>+#####Makefile End#######

I am tempted to use  obj-y += mycall.o

Generally, one does not need a new directory for a new syscall, or a new 
source file. You can edit kernel/sys.c if you like.

>+--Line 3:
>+	_syscall1(long, mycall, int, i)
>+	This is needed for system calls with 1 argument. It is explained in detail
>+        below.

This was deprecated in favor of syscall().

>+#include<stdio.h>
>+#include "testmycall.h"
>+
>+main()
>+{
>+        printf("%d\n", mycall(15));
>+}

Care to use ANSI C?


	-`J'
-- 
