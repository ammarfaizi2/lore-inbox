Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313916AbSDPVMW>; Tue, 16 Apr 2002 17:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313917AbSDPVMV>; Tue, 16 Apr 2002 17:12:21 -0400
Received: from nydalah028.sn.umu.se ([130.239.118.227]:28848 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S313916AbSDPVMU>; Tue, 16 Apr 2002 17:12:20 -0400
Message-ID: <00dc01c1e58b$668dd2f0$0201a8c0@homer>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "E M Recio" <polywog@navpoint.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204160921060.472-100000@polywog.navpoint.com>
Subject: Re: AMD Athlon + VIA Crashing On Disk I/O
Date: Tue, 16 Apr 2002 23:12:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "E M Recio" <polywog@navpoint.com>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, April 16, 2002 3:28 PM
Subject: AMD Athlon + VIA Crashing On Disk I/O


> Hiya,
>
> I have an AMD Athlon 1.2 with a VIA 8259A Chipset (see bottom). If I
> compile the kernel with the Athlon option it crashes all the time. In
> fact, I can't even get Redhat 7.2 installed without a core dump when it
> tries to mount the filesystem. With the later kernels, it doesn't core
> dump, but just freezes.
>
> IE: If I have ide-scsi module loaded, and I try to access the floppy
> drive, it locks up the machine (regardless of whether cputype is Athlon
> or K6.)
>
> IE: Updatedb locks up the machine.
>
> I get (when FSCK):
>
> spurious 8259A IRQ7


This is not the VIA chipset, it's the "8259A interrupt controller".

> Does anyone know if there's a bug fix for this chipset? My board is
> made from FIC (crappy, instructions don't even matchup). I used to be
> able to fix it by changing the CPU type to K6 but that doesn't work now
> with the later kernels (2.4.15 and up.)

First check out what kind of chipset you really have;
lspci -xs 0:0
should do the thing. Post the results.

In the meantime, you can try to compile for
"Pentium-Pro/Celeron/Pentium-II", and check your BIOS settings one more time
(set stuff to "safe" values). Also, do you have a really recent kernel, such
as 2.4.18? There were some changes in the Athlon/VIA "quirks" department a
while ago, but after 2.4.15 (i think).

 _____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden

