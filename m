Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289973AbSAOPf3>; Tue, 15 Jan 2002 10:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289974AbSAOPfU>; Tue, 15 Jan 2002 10:35:20 -0500
Received: from waste.org ([209.173.204.2]:65230 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S289973AbSAOPfC>;
	Tue, 15 Jan 2002 10:35:02 -0500
Date: Tue, 15 Jan 2002 09:34:37 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Rob Landley <landley@trommello.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away? 
In-Reply-To: <5641.1011094503@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0201150924130.25491-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Keith Owens wrote:

> On Mon, 14 Jan 2002 09:19:01 -0500,
> Rob Landley <landley@trommello.org> wrote:
> >How much of the build process for the initramfs will be integrated with the
> >kernel build?  Since the kernel won't boot without a matching initramfs, I
> >take it that some kind of initramfs will be a kernel build target now?
> >
> >There's been a lot of talk about having the source for a mini-libc (uclibc,
> >dietlibc, some combo) in the kernel tree, and other people saying we should
> >just grab the binary for build purposes.  The most obvious model I can think
> >of for klibc staying seperate from the kernel is the user-space
> >pcmcia/cardbus hotplug stuff, but that DID get integrated into the kernel.
> >
> >The klibc source/binary debate still seems to be ongoing, but apart from
> >that, will the build process for initramfs be part of the kernel build or not?
>
> I am in two minds about this (but I am at one with my duality).  Part
> of me says that users will want to tweak the initramfs process and they
> may want to use different versions of klibc, so klibc and building
> initramfs should be outside the kernel build.  Another part says that
> users have to build initramfs before doing the install so initramfs and
> klibc should be part of kbuild.
>
> It will probably end up with klibc as part of the kernel tarball
> supported by kbuild.  Generating initramfs will be done by a script,
> kbuild will supply a sample but users can copy and change the sample to
> suit their own requirements.

Better yet, we should do away with all install targets beyond assembling
the bootable images and provide sample install scripts in /scripts. Most
of it is already at odds with the distro's install and the remainder
becomes a maintenance issue with initramfs. Distro folks are going to be
working on initramfs-libc for their boot disks anyway and will undoubted
want to tweak such stuff greatly. Let's include Viro's
minimal-userspace-boot.c in scripts along with a
build-minimal-initramfs.sh and leave it at that.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

