Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbSJHPoh>; Tue, 8 Oct 2002 11:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261186AbSJHPoh>; Tue, 8 Oct 2002 11:44:37 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:2951 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261191AbSJHPog>; Tue, 8 Oct 2002 11:44:36 -0400
Date: Tue, 8 Oct 2002 10:49:50 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Adrian Bunk <bunk@fs.tum.de>
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
       Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.41-ac1 
In-Reply-To: <Pine.NEB.4.44.0210081732250.8340-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0210081044360.32256-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, Adrian Bunk wrote:

> On Tue, 8 Oct 2002, James Bottomley wrote:
> 
> > bunk@fs.tum.de said:
> > > make[1]: *** No rule to make target `arch/i386/mach-voyager/
> > > trampoline.o', needed by `arch/i386/mach-voyager/built-in.o'.  Stop.
> > > make: *** [arch/i386/mach-voyager] Error 2
> >
> > That one's pulled in from ../kernel by the vpath in mach-voyager (or should
> > be).  It builds for me, so it could be the version of make you are using?
> 
> Ah, then Kai's changes to the build system in 2.5.41 broke it.
> 
> Kai, what's the recommended way to get this working again?

Well, don't use vpath in the kernel Makefiles ;)

To restore the previous state, just do

obj-y += ... ../kernel/trampoline.o

However, why don't you just set CONFIG_X86_SMP when CONFIG_VOYAGER is 
selected, which would be cleaner anyway?

Compiling the same file from different subdirs depending on .config is 
surely a recipe for confusion.

--Kai


