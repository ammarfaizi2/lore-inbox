Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWIOKKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWIOKKe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 06:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWIOKKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 06:10:34 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:22420 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750836AbWIOKKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 06:10:33 -0400
Date: Fri, 15 Sep 2006 12:10:14 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Madhav Bhamidipati <madhavb@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question on compiling a kernel Module
In-Reply-To: <50b2ce660609150302s4f3de2afwf573b40f02a8d111@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0609151206440.26659@yvahk01.tjqt.qr>
References: <50b2ce660609150302s4f3de2afwf573b40f02a8d111@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> module/
> module/sub-module1
> module/sub-module2
> module/include
> module/objs/


obj-m += my.o
my-objs := sub1/foo.o sub1/bar.o sub2/abc.o sub2/xyz.o
EXTRA_CFLAGS += -I$(src)/include


Should be straightforward.

> module folder has a Makefile, it may or may not have *.c files, it
> invokes sub-* Makefiles
> which build respective objects, these objects need to go into objs
> folder, finally makefile in 'objs'
> builds the module.ko linking all sub-module *.o.
>
> I could not find much information for my requirement in the file
> linux/Documentation/kbuild/makefiles.txt
>
> any information with an example for my requirement is greatly
> appreciated. Also let me know
> how do I expose module/include in sub-module/ c files, looks like
> -I../include is not working


Jan Engelhardt
-- 
