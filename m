Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262277AbSJEJkx>; Sat, 5 Oct 2002 05:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262278AbSJEJkx>; Sat, 5 Oct 2002 05:40:53 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54247 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262277AbSJEJkw>; Sat, 5 Oct 2002 05:40:52 -0400
Date: Sat, 5 Oct 2002 11:46:23 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: "frode@freenix.no" <frode@freenix.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 (several issues): kernel BUG! at slab.c:1292, imm/ppa
 IOMegaZIP drivers modules ".o" not found, XFS won't link, depmod complains
 on
In-Reply-To: <3D9E23E2.8000400@freenix.no>
Message-ID: <Pine.NEB.4.44.0210051141530.17935-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002, frode@freenix.no wrote:

> I just downloaded the linux-2.5.40 tarball.
>
> The kernel was built and tested on a box running Debian Unstable (refreshed today).
> I had four (five if you include ALSA breaking make menuconfig) issues.
>
>      - the kernel wouldn't link with XFS enabled due to some
>        unreferenced symbols ("run_task_queue", etc).

AFAIR fixed in Linus' BK tree.

>      - configuring for the SCSI IOMega Parallel port drivers as modules,
>        make modules_install fails as the 'imm.o' and 'ppa.o' files
>        are missing. (i just 'touch'ed these files to get
>        "make modules_install" to continue)
>
>      - make modules_install runs depmod which fails with
> depmod: cannot read ELF header from /lib/modules/2.5.40/kernel/drivers/scsi/imm.o
> depmod: cannot read ELF header from /lib/modules/2.5.40/kernel/drivers/scsi/ppa.o

The problem that was causing it is that "make modules" didn't stop when
the compilation of imm.c and ppa.c failed. The bug in the build system and
the compilation of these two files are fixed in Linus' BK tree.

> depmod: *** Unresolved symbols in
> /lib/modules/2.5.40/kernel/drivers/usb/input/usbkbd.o
> depmod: 	usb_kbd_free_buffers
>...

Already fixed in Linus' BK tree.


Please wait for 2.5.41 and check whether any problems will be present in
this kernel.


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

