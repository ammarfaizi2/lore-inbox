Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269404AbRHaVtv>; Fri, 31 Aug 2001 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269417AbRHaVtm>; Fri, 31 Aug 2001 17:49:42 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:36291 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S269404AbRHaVtb>; Fri, 31 Aug 2001 17:49:31 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDE0DB@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: lilo vs other OS bootloaders was: FreeBSD makes progress
Date: Fri, 31 Aug 2001 14:49:04 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, sounds like enhancing LILO to load modules beyond the kernel is
unworkable.

Just for discussion's sake, I would like to point out that other OSs do have
loaders that can load boot drivers, and they can use this to increase the
modularity of their kernel. FreeBSD's and Win2k's bootloaders are examples.
Win2K even abstracts all SMP/UP code into a module (the HAL) and loads this
at boot, thus using the same kernel for both.

So of course I realize this wouldn't happen any time soon, but has any
discussion taken place regarding enhancing the bootloader (grub? Steal
FreeBSD's?) to load modular drivers very early, and possibly abstracting
SMP/UP from the kernel proper? Wouldn't this be a better solution than
initrd?

Just curious -- Andy


> From: Russell Coker [mailto:russell@coker.com.au]
> > It would be really cool if lilo or grub could pull this 
> trick, too. Without
> > it, we're left with compiling ACPI into the kernel, or 
> doing some initrd
> > trick, both of which have disadvantages.
> 
> LILO is architecturally incapable of doing such things 
> without a huge degree 
> of hacking.  LILO has no support for .b files that set state. 
>  Having a .b 
> file that loads one of two other files depending on what it 
> detects would be 
> possible (but a gross hack).
> 
> Then if LILO determined that ACPI hardware was present how 
> would it tell the 
> kernel to load a module?
> 
> Having a statically linked program on an initrd which will 
> run "modprobe 
> acpi" if it detects appropriate hardware is very easy to do 
> for an install or 
> rescue disk.
> 
> For a running system the scripts that make the initrd image 
> can check for the 
> presence of ACPI to determine whether the ACPI module belongs 
> in the initrd.
