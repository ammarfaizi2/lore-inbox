Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSJHQDT>; Tue, 8 Oct 2002 12:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261293AbSJHQDT>; Tue, 8 Oct 2002 12:03:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35051 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261292AbSJHQDS>; Tue, 8 Oct 2002 12:03:18 -0400
Date: Tue, 8 Oct 2002 18:08:53 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
       Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.41-ac1 
In-Reply-To: <Pine.LNX.4.44.0210081044360.32256-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.NEB.4.44.0210081804260.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, Kai Germaschewski wrote:

>...
> To restore the previous state, just do
>
> obj-y += ... ../kernel/trampoline.o
>...

There seems to be a bug in kbuild that makes your suggestion impossible:

<--  snip  -->

...
make -f arch/i386/mach-voyager/Makefile
   ld -m elf_i386  -r -o arch/i386/mach-voyager/built-in.o
arch/i386/mach-voyager/setup.o arch/i386/mach-voyager/voyager_basic.o
arch/i386/mach-voyager/voyager_thread.o
arch/i386/mach-voyager/voyager_smp.o arch/i386/mach-voyager/voyager_cat.o
arch/i386/mach-voyager/../kernel/trampoline.o
ld: cannot open arch/i386/mach-voyager/../kernel/trampoline.o: No such
file or directory
make[1]: *** [arch/i386/mach-voyager/built-in.o] Error 1
make: *** [arch/i386/mach-voyager] Error 2

 <--  snip  -->

> --Kai

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


