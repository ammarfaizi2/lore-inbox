Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSJ3Ip2>; Wed, 30 Oct 2002 03:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264627AbSJ3Ip2>; Wed, 30 Oct 2002 03:45:28 -0500
Received: from codepoet.org ([166.70.99.138]:3229 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S264625AbSJ3Ip1>;
	Wed, 30 Oct 2002 03:45:27 -0500
Date: Wed, 30 Oct 2002 01:51:49 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Dave Cinege <dcinege@psychosis.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Message-ID: <20021030085149.GA7919@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Dave Cinege <dcinege@psychosis.com>, Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org
References: <200210272017.56147.landley@trommello.org> <200210300229.44865.dcinege@psychosis.com> <3DBF8CD5.1030306@pobox.com> <200210300322.17933.dcinege@psychosis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210300322.17933.dcinege@psychosis.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 30, 2002 at 03:22:17AM -0500, Dave Cinege wrote:
> On Wednesday 30 October 2002 2:40, Jeff Garzik wrote:
> 
> > untar - cpio is better.
> 
> CPIO is commonly used and supported by NO ONE. (rpm, whoppee)
> Kernels even come tar'ed. KISS....

Both formats are simple.  But cpio is simpler.

> > initrd - 99% moved out of the kernel
> 
> Great...you just killed the high level embedded linux market, and
> the ability to play boot games from GRUB. (Network, etc)
> Initrd is a good **OPTION* to have to fall back on...

Umm.  No.  See initramfs below.  initrds have always been an
evil abomination.  They do things terribly wrong and eliminating
them will _save_ space in embedded linux system.  When busybox is
compiled without the special-case initrd workarounds, it does get
a bit smaller...

> > do_mounts - moved out of the kernel completely
> 
> And he's willing to completely purge initrd and do_mounts NOW???
> 
> > initramfs - should be ready for Linus in the next day or so.
> 
> Fire away with the 100K+ bloated POS. I'm backwards compatible,
> could easily add 'linked kernel image' support, and only increase
> the current code by 20K.

Perhaps you have misunderstood.  initramfs is simply an initrd
infrastructure that is done right.  You don't need to use klibc
in your initramfs if you don't want to.  Its just a piece of
normal unhosed-up userspace.  Populate it as you see fit.

> Do you have any serious sysadmin, clustering, or emebedded system
> IMPLEMENTATION experience? 

Yes he has plenty of experience.  He also has good taste.  IMHO
the embedded world (as well as everyone else) wants initramfs --
it is a major improvement.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
