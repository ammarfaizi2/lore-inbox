Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267702AbUHUTn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267702AbUHUTn3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 15:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267703AbUHUTn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 15:43:29 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:7803 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267702AbUHUTn1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 15:43:27 -0400
Date: Sat, 21 Aug 2004 23:44:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Lei Yang <leiyang@nec-labs.com>
Cc: Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling kernel modules
Message-ID: <20040821214402.GA7266@mars.ravnborg.org>
Mail-Followup-To: Lei Yang <leiyang@nec-labs.com>,
	Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <4127A15C.1010905@nec-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4127A15C.1010905@nec-labs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 03:24:12PM -0400, Lei Yang wrote:
> Hi all,
> 
> I was trying to compile a kernel module with kbuild. The module 'test.c' 
> include a header file 'fred.h' and there is a "#include <stdio.h>" in 
> 'fred.h'.
> 
> Makefile looks like:
> 
> ------------------------------------------------------------------------
> ifneq ($(KERNELRELEASE),)
> obj-m       := test.o
> 
> else
> KDIR        := /usr/src/linux
> PWD         := $(shell pwd)
> 
> default:
> 	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> 	
> 
> clean:
For 2.6.7 (or 2.6.6) you do not need to specify your own clean: rule.

> But upon compiling, there would be errors like this:
> In file included from /home/lei/test.c:49:
> /home/lei/fred.h:4:19: stdio.h: No such file or directory
The kernel does not provide you with a stdio.h header, so therefore you
cannot find it neither use functionality from it.

	Sam
