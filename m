Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131049AbRA0LJl>; Sat, 27 Jan 2001 06:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131977AbRA0LJb>; Sat, 27 Jan 2001 06:09:31 -0500
Received: from s4m053.dialup.RWTH-Aachen.DE ([137.226.8.53]:19716 "EHLO
	orbiter.ath.cx") by vger.kernel.org with ESMTP id <S131049AbRA0LJW>;
	Sat, 27 Jan 2001 06:09:22 -0500
From: Peter Kaczuba <pepe@pool.informatik.rwth-aachen.de>
Date: Sat, 27 Jan 2001 12:06:57 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0ac12
Message-ID: <20010127120657.A975@orbiter.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-01-27 1:46:12 "Sergey Kubushin" <ksi@cyberbills.com> wrote:
> Modules still don't load:
>
>=== Cut ===
>ide-mod.o: Can't handle sections of type 32131
>ide-probe-mod.o: Can't handle sections of type 256950710
>ide-disk.o: Can't handle sections of type 688840897
>ext2.o: Can't handle sections of type 69429248
>=== Cut ===
>
>Section types are exactly the same in ac9,10,11,12.
>
>Is it supposed to be this way? Does anybody care? Or may be I'm the only
>one who uses modules?

You are not alone out there! :-)
I have the same problems using a modular kernel, it is the same
configuration as yours (kernel 2.4.0-ac12, modutils 2.4.2,
binutils-2.10.1.0.4, gcc-2.95.2). 2.4.0-ac4 works, up from 2.4.0-ac8 do
not (others not tested).
I get these errors at boot time:

VFS: Mounted root (romfs filesystem) read only.
kmod: runaway modprobe loop assumed and stopped
kmod: runaway modprobe loop assumed and stopped
insmod: /lib/modules/2.4.0-ac12/kernel/net/unix/unix.o: can't handle
sections of type 255 /lib/modules/2.4.0-ac12/kernel/net/unix/unix.o
kmod: runaway modprobe loop assumed and stopped
insmod: /lib/modules/2.4.0-ac12/kernel/net/unix/unix.o: insmod net-pf-1
failed

Hope this helps.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
