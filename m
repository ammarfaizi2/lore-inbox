Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTGHOZj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 10:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTGHOZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 10:25:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261823AbTGHOZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 10:25:37 -0400
Date: Tue, 8 Jul 2003 10:40:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jamie Lokier <jamie@shareable.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: syscall __NR_mmap2
In-Reply-To: <20030708140546.GA15612@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.53.0307081033190.267@chaos>
References: <Pine.LNX.4.53.0307071655470.22074@chaos>
 <20030708003656.GC12127@mail.jlokier.co.uk> <Pine.LNX.4.53.0307080749160.24488@chaos>
 <20030708140546.GA15612@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Jamie Lokier wrote:

> Richard B. Johnson wrote:
> > > The offset argument to mmap2 is divided by PAGE_SIZE.
> > > That is the whole point of mmap2 :)
> >
> > Okay. Do you know where that's documented? Nothing in linux/Documentation,
> > and nothing in any headers. Do you have to read the code to find out?
> >
> > So, the address is now the offset in PAGES, not bytes. Seems logical,
> > but there is no clue in any documentation.
>
> I found this great command which really helps.  Only 1337 kernel
> gnurus know about it, now u can be 1 2 :)
>
> $ man mmap2
> [...]
>        The  function mmap2 operates in exactly the same way as mmap(2), except
>        that the final argument specifies the offset into the file in units  of
>        the  system  page  size  (instead of bytes).
>
> -- Jamie
>

Yeah? So the Linux kernel now requires a specific vendor distribution?
Since when?

So, to get the proper documentation of the Linux Kernel, I now
need to purchase a vendor's distribution??? I think not. I think
the sys-calls need to be documented and I think that I have established
proof of that supposition.

Script started on Tue Jul  8 10:35:05 2003
# man mmap2
No manual entry for mmap2
# mmap
# man map

MMAP(2)             Linux Programmer's Manual             MMAP(2)

NAME
       mmap, munmap - map or unmap files or devices into memory

SYNOPSIS
       #include <sys/types.h>
       #include <sys/mman.h>

       caddr_t  mmap(caddr_t  addr,  size_t  len,  int prot , int
       flags, int fd, off_t offset );
       int munmap(caddr_t addr, size_t len);

DESCRIPTION
       WARNING: This is a BSD man page.  Linux 0.99.11 can't  map
       files, and can't do other things documented here.

       The  mmap  function  causes the pages starting at addr and
       continuing for at most len bytes to  be  mapped  from  the
       object  described  by  fd, starting at byte offset offset.
       If offset or len is not a multiple of  the  pagesize,  the
       mapped region may extend past the specified range.

line 1
#
#
# exit
exit

Script done on Tue Jul  8 10:35:29 2003

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

