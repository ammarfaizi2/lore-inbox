Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283786AbRLWG2a>; Sun, 23 Dec 2001 01:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283795AbRLWG2S>; Sun, 23 Dec 2001 01:28:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23126 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S283786AbRLWG2I>; Sun, 23 Dec 2001 01:28:08 -0500
To: dcinege@psychosis.com
Cc: otto.wyss@bluewin.ch,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <3C1D060B.9475C9F8@bluewin.ch>
	<E16HwC0-0001k4-00@schizo.psychosis.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Dec 2001 23:26:14 -0700
In-Reply-To: <E16HwC0-0001k4-00@schizo.psychosis.com>
Message-ID: <m1vgeyqwop.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Cinege <dcinege@psychosis.com> writes:

> On Sunday 16 December 2001 15:37, Otto Wyss wrote:
> 
> > modules) are combined into a single file. The boot loader (i.e. lilo)
> 
> LILO follows an outdated, broken concept and should once and for all
> be layed to rest, preferably with a stake through it's heart. 

The way LILO does things is perfectly valid.  Not flexible, not dynamic
but valid.

 
> > simply loads this file and starts the first stream (the kernel).
> 
> The point to all these 'streams' escapes me. The proper way to implement
> this has all ready been done. It's called the Multi Boot Standard
> as implemented in GRUB bootloader. http://www.gnu.org/software/grub/

GRUB is a good proof of concept bootloader but I wouldn't call it
a good way to implement things.  As for the Multi Boot Specification
it is hardly a standard, and it got a lot of details wrong.  A big
one is who is supposed to do the BIOS calls.

It should be o.k. for a bootloader to be static, but still useful on multiple
machines for years.  What comes out of GRUB does not encourage a
static bootloader.  But the development of GRUB is slow enough that it
is practically static...
 
> GRUB is similar to syslinux in that is can read directly from the the FS,
> but unlike syslinux supports just about all of them instead of just FAT.
> 
> Basically what Grub does is loads the kernel modules from disk
> into memory, and 'tells' the kernel the memory location to load
> them from, very similar to how an initrd file is loaded. The problem
> is Linux, is not MBS compilant and doesn't know to look for and load
> the modules. 

So tell me how you make an MBS compliant alpha kernel again?

Eric
