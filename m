Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbWBNUzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbWBNUzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 15:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161096AbWBNUzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 15:55:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32172 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161090AbWBNUzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 15:55:44 -0500
Date: Tue, 14 Feb 2006 12:53:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: roland@redhat.com, drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Bogus objdump output from kernel object files?
Message-Id: <20060214125344.6248a60f.akpm@osdl.org>
In-Reply-To: <200602140458_MC3-1-B85E-D2BA@compuserve.com>
References: <200602140458_MC3-1-B85E-D2BA@compuserve.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> On Sun, 12 Feb 2006 at 01:40:46 -0800, Andrew Morton wrote:
> 
>  > btw, is something up with `make foo.lst'?  It hasn't worked for me for
>  some
>  > time.
>  > 
>  > bix:/usr/src/25> make mm/vmscan.lst
>  >   MKLST   mm/vmscan.lst
> 
>  Just doing 'objdump -d -r -l -j .text mm/vmscan.o' gives:
> 
>  mm/vmscan.o:     file format elf32-i386
> 
>  Disassembly of section .text:
> 
>  00000000 <shrink_slab>:
>  kswapd_init():
>  ^^^^^^^^^^^^^^
>  This is actually at offset 0 in .init.text
> 
>  mm/vmscan.c:176
>         0:       55                      push   %ebp
>  shrink_slab():
>  ^^^^^^^^^^^^^^
>  OK, back to the right location.

Looks like it's a binutils problem.

	http://sources.redhat.com/bugzilla/show_bug.cgi?id=2338

HJ said he'd try to get this fixed for the next binutils release.
