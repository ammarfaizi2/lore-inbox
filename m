Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289097AbSANWVO>; Mon, 14 Jan 2002 17:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289094AbSANWVI>; Mon, 14 Jan 2002 17:21:08 -0500
Received: from femail44.sdc1.sfba.home.com ([24.254.60.38]:12728 "EHLO
	femail44.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S289097AbSANWVD>; Mon, 14 Jan 2002 17:21:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alexander Viro <viro@math.psu.edu>, "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Hardwired drivers are going away?
Date: Mon, 14 Jan 2002 09:19:01 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
        Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0201141337580.224-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0201141337580.224-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020114222101.ZPUW15906.femail44.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 January 2002 02:09 pm, Alexander Viro wrote:

> But it still leaves you with tristate - instead of yes/module/no it's
> yes/yes, but don't put it on initramfs/no.  However, dependencies become
> simpler - all you need is "I want this, that and that on initramfs" and
> the rest can be found by depmod (i.e. configurator doesn't have to deal
> with "FOO goes on initramfs (== old Y), so BAR and BAZ must go there
> (== can't be M)").

This is something I've wondered about and would like to ask for clarification 
on: the relationship between the initramfs image and the kernel, build 
process-wise.

How much of the build process for the initramfs will be integrated with the 
kernel build?  Since the kernel won't boot without a matching initramfs, I 
take it that some kind of initramfs will be a kernel build target now?

There's been a lot of talk about having the source for a mini-libc (uclibc, 
dietlibc, some combo) in the kernel tree, and other people saying we should 
just grab the binary for build purposes.  The most obvious model I can think 
of for klibc staying seperate from the kernel is the user-space 
pcmcia/cardbus hotplug stuff, but that DID get integrated into the kernel.

The klibc source/binary debate still seems to be ongoing, but apart from 
that, will the build process for initramfs be part of the kernel build or not?

Rob.
