Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289001AbSAOLfi>; Tue, 15 Jan 2002 06:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289013AbSAOLf2>; Tue, 15 Jan 2002 06:35:28 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:12548 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S289001AbSAOLfP>;
	Tue, 15 Jan 2002 06:35:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rob Landley <landley@trommello.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away? 
In-Reply-To: Your message of "Mon, 14 Jan 2002 09:19:01 CDT."
             <20020114222101.ZPUW15906.femail44.sdc1.sfba.home.com@there> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Jan 2002 22:35:03 +1100
Message-ID: <5641.1011094503@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002 09:19:01 -0500, 
Rob Landley <landley@trommello.org> wrote:
>How much of the build process for the initramfs will be integrated with the 
>kernel build?  Since the kernel won't boot without a matching initramfs, I 
>take it that some kind of initramfs will be a kernel build target now?
>
>There's been a lot of talk about having the source for a mini-libc (uclibc, 
>dietlibc, some combo) in the kernel tree, and other people saying we should 
>just grab the binary for build purposes.  The most obvious model I can think 
>of for klibc staying seperate from the kernel is the user-space 
>pcmcia/cardbus hotplug stuff, but that DID get integrated into the kernel.
>
>The klibc source/binary debate still seems to be ongoing, but apart from 
>that, will the build process for initramfs be part of the kernel build or not?

I am in two minds about this (but I am at one with my duality).  Part
of me says that users will want to tweak the initramfs process and they
may want to use different versions of klibc, so klibc and building
initramfs should be outside the kernel build.  Another part says that
users have to build initramfs before doing the install so initramfs and
klibc should be part of kbuild.

It will probably end up with klibc as part of the kernel tarball
supported by kbuild.  Generating initramfs will be done by a script,
kbuild will supply a sample but users can copy and change the sample to
suit their own requirements.

