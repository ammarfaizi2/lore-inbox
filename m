Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129799AbQLELsG>; Tue, 5 Dec 2000 06:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbQLELr4>; Tue, 5 Dec 2000 06:47:56 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:60165 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129799AbQLELrn>; Tue, 5 Dec 2000 06:47:43 -0500
Date: Tue, 5 Dec 2000 06:17:39 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problems with Athlon CPU [long]
In-Reply-To: <Pine.LNX.4.30.0012051135361.1881-200000@lt.wsisiz.edu.pl>
Message-ID: <Pine.LNX.4.30.0012050613240.620-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Lukasz Trabinski wrote:

>Date: Tue, 5 Dec 2000 11:48:17 +0100 (CET)
>From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
>To: Alan Cox <alan@lxorguk.ukuu.org.uk>
>Cc: Ilinux-kernel@vger.kernel.org, mharris@opensourceadvocate.org
>Content-Type: MULTIPART/MIXED;
>    BOUNDARY="-842827824-2134249921-976013207=:1881"
>Subject: Re: Problems with Athlon CPU [long]
>
>On Tue, 5 Dec 2000, Alan Cox wrote:
>>
>> Then I can only conclude your system is broken in some way since it works
>> for everyone else
>
>Very strange, on K6-II and Pentium III/II with the same version o
>As Attchmnt i sending a full session with the compiler - tested with
>pre-patch-2.2.18-24
>Maybe my machine is broken, problems with mainboard? (signal 11)

Yes:

>/usr/bin/kgcc -D__KERNEL__ -I/usr/src/linux/include -Wall
>-Wstrict-prototypes
>-O2 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe
>-fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2
>-malign-functions=2
>-DCPU=686   -c -o scsi_error.o scsi_error.c
>/usr/bin/kgcc -D__KERNEL__ -I/usr/src/linux/include -Wall
>-Wstrict-prototypes
>-O2 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe
>-fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2
>-malign-functions=2
>-DCPU=686   -c -o scsi_obsolete.o scsi_obsolete.c
>/usr/bin/kgcc -D__KERNEL__ -I/usr/src/linux/include -Wall
>-Wstrict-prototypes
>-O2 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe
>-fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2
>-malign-functions=2
>-DCPU=686   -c -o scsi_queue.o scsi_queue.c
>kgcc: Internal compiler error: program cpp got fatal signal 11
>make[3]: *** [scsi_queue.o] Error 1
>make[3]: Leaving directory `/usr/src/linux/drivers/scsi'
>make[2]: *** [first_rule] Error 2
>make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
>make[1]: *** [_subdir_scsi] Error 2
>make[1]: Leaving directory `/usr/src/linux/drivers'
>make: *** [_dir_drivers] Error 2

Sig11 generally indicates bad RAM or overheating or some faulty
hardware.  This is an FAQ. Read the lkml FAQ.

>> glibc is not linked with the kernel
>
>I know about it, but the compiler does.

Not sure what you mean however no part of the linux kernel ever
uses glibc at all. It is not possible to do so in fact.

Some of the programs like menuconfig do, but that isn't the
kernel, and doesn't apply...

Your hardware is likely faulty, especially if it conks out in a
different spot each time.



----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

Emacs is my operating system, and Linux its device driver.
  -- Bake Timmons

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
