Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288218AbSACGqo>; Thu, 3 Jan 2002 01:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288225AbSACGqe>; Thu, 3 Jan 2002 01:46:34 -0500
Received: from marine.sonic.net ([208.201.224.37]:35454 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S288218AbSACGqY>;
	Thu, 3 Jan 2002 01:46:24 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 2 Jan 2002 22:46:19 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020103064619.GD28621@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102170833.A17655@thyrsus.com> <E16Lu2i-0005nd-00@the-village.bc.nu> <20020102172448.A18153@thyrsus.com> <3C339219.4040808@free.fr> <20020103144904.A644@zapff.research.canon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020103144904.A644@zapff.research.canon.com.au>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 02:49:04PM +1100, Cameron Simpson wrote:
> 	- opening a publicly readable file in /proc to get some info,
> 	  which will run some kernel code (which can presumably be trusted;
> 	  if you don't trust your kernel you have a serious problem)

Some unnecessary kernel code.  Which, because it's unnecessary, won't
necessarily be checked for correctness.

>     versus
> 
> 	- running a setuid binary (however audited) to get the info; said
> 	  binary may have bugs, security holes, race conditions etc; it may be
> 	  hacked post boot (no so easy to do to the live kernel image), etc

vs

- running a single app as root upon boot.

> Further, binaries which grovel in /dev/kmem tend to have to be kept in sync
> with the kernel; in-kernel code is fundamentally in sync.

Bull.  There have been several drivers that simply can not compile because
they are out of sync, in the 2.4 kernel

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
