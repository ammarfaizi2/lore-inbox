Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317395AbSFRMjG>; Tue, 18 Jun 2002 08:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317397AbSFRMjF>; Tue, 18 Jun 2002 08:39:05 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:15884 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S317395AbSFRMjF>; Tue, 18 Jun 2002 08:39:05 -0400
Date: Tue, 18 Jun 2002 14:42:07 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: "Hans E. Kristiansen" <hans@tropic.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.22 problems with compile.h
In-Reply-To: <009401c216b4$22458160$252ca8c0@sdfg>
Message-ID: <Pine.LNX.4.21.0206181436570.442-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Hans E. Kristiansen wrote:

> I really need some help with compiling version 2.5.22
> 
> >From a clean install, I can compile, but I get an error with compile.h (Do
> not know how to make compile.h). If I compile again, I get a working kernel

same here - see below.

> (bzImage), "depmod -ae -F xx " works like a charm. But, when I reboot with
> the new kernel, I can not load any modules. None, they all have symbol
> problems.

There are two patches from Kai Germaschewski in the "2.5.22 broke
modversions" thread which solved this issue for me.

> To compile a kernel, I use "make dep clean bzImage modules modules_install",

replacing this by separate "make dep; make clean; make bzImage; make
modules; make modules_install" invokations solved the compile.h problem
for me.

HTH
Martin

