Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131457AbRDBWjK>; Mon, 2 Apr 2001 18:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131429AbRDBWjB>; Mon, 2 Apr 2001 18:39:01 -0400
Received: from jalon.able.es ([212.97.163.2]:55017 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131424AbRDBWix>;
	Mon, 2 Apr 2001 18:38:53 -0400
Date: Tue, 3 Apr 2001 00:38:04 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "J . A . Magallon" <jamagallon@able.es>,
   Oliver Xymoron <oxymoron@waste.org>, David Lang <dlang@diginsite.com>,
   Manfred Spraul <manfred@colorfullife.com>,
   "Albert D . Cahalan" <acahalan@cs.uml.edu>, lm@bitmover.com,
   linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
Message-ID: <20010403003804.I17148@werewolf.able.es>
In-Reply-To: <Pine.LNX.3.96.1010401181724.28121i-100000@mandrakesoft.mandrakesoft.com> <Pine.LNX.4.30.0104021436110.24812-100000@waste.org> <20010402234045.C17148@werewolf.able.es> <3AC8F881.F20A19A6@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3AC8F881.F20A19A6@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Apr 03, 2001 at 00:09:05 +0200
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.03 Jeff Garzik wrote:
> "J . A . Magallon" wrote:
> > Could <installkernel> make part of the kernel scripts, or in one other
> > standard software package, like modutils, so its versions are controlled
> 
> There is value in putting it into the Linux kernel source tree, in
> linux/scripts dir.  But most vendors can and should take this script as
> a sample, and customize it for their distro.  The Linux-Mandrake
> installkernel script definitely gets touched every so often, and
> decisions it makes, like updating lilo.conf or grub/menu.lst, or
> autodetecting the boot loader, are definitely not to be applied for all
> cases.
>

I think that should be split in two, one thing is building and install a kernel
and one other is add the entry in your bootloader config ('update-bootloader',
for example, that looks into /boot and adds missing entries).

> FWIW here is our /sbin/installkernel command line usage help text, to
> give a glimpse of what it does and can do:

I know, run Cooker.

> 
> There will never be an official place to put this stuff, because that's
> a distro policy decision.  A quick search just now reveals no reference
> to /boot in the i386 Makefiles, and only a quick reference in the README
> file.

linux/Makefile, #INSTALL_PATH=/boot

> 
> > And you can add something like /proc/signature/map, /proc/signature/config,
> > etc to md5-check if a certain file fits running kernel.
> 

I usually think about /proc like the way to do a 'cat' instead of a 'syscall',
in this case to ask kernel for various md5 sigs,
but of course you can always write a user app that queries kernel and prints
result for your scripting pleasure...

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3 #2 SMP Fri Mar 30 15:42:05 CEST 2001 i686

