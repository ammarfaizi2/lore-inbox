Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263867AbSITWGZ>; Fri, 20 Sep 2002 18:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263874AbSITWGY>; Fri, 20 Sep 2002 18:06:24 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:36738 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S263867AbSITWGX>; Fri, 20 Sep 2002 18:06:23 -0400
Date: Fri, 20 Sep 2002 19:11:15 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Russ Lewis <spamhole-2001-07-16@deming-os.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: is any virtual address space reserved?
In-Reply-To: <3D8B8E5B.FBEF44B3@deming-os.org>
Message-ID: <Pine.LNX.4.44L.0209201909430.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, Russ Lewis wrote:

> Is any of a userland application's virtual address space reserved?
> Certainly, some memory is used at startup: the code is loaded into some
> of the virtual space, as well as the stack.  There needs to always be
> enough space for the stack to grow as necessary.  But is any of the
> space actually marked off as "reserved"?  If we just mmap'ed the same
> file over and over again, could we fill the 4Gb address space with
> identical mappings, or would we run out?

There are a number of issues here:

1) userspace has 3 GB space, kernel has the other 1 GB

2) if you want to mmap a file over and over again, you'll
   need to have the code that maps the file and the glibc
   mmap(3) stuff mapped into your address space ;)

3) your process will want to have a stack somewhere

4) address 0 is reserved to trap NULL pointer dereferences
   both in kernel and user space

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

