Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281280AbRKLGcu>; Mon, 12 Nov 2001 01:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281278AbRKLGck>; Mon, 12 Nov 2001 01:32:40 -0500
Received: from [212.3.242.3] ([212.3.242.3]:62479 "HELO mail.i4gate.net")
	by vger.kernel.org with SMTP id <S281276AbRKLGce>;
	Mon, 12 Nov 2001 01:32:34 -0500
Message-Id: <5.1.0.14.2.20011112072307.00a80410@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 12 Nov 2001 07:32:15 +0100
To: linux-kernel@vger.kernel.org
From: DevilKin <devilkin@gmx.net>
Subject: USB problems on 2.4.15-pre2?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I recently (yesterday) upgraded my kernel from 2.4.10 to 2.4.15-pre2 (i 
needed to recompile anyway to get USB, and it seemed that the VM troubles 
were over). I must say that I'm pleased with this kernel, operates very 
smooth on my machine. I even got better responce times (that I thought I 
wouldn't notice on a 1.4ghz...).

Anyway, I'm straying...

USB is compiled entirely as modules, no kmod support, hotswap activated.
USB Bridge is a VIA bridge. (as I'm not behind the PC i don't know the 
typenumber)

I have had mount locking up when attempting to mount my /dev/sda1 which 
refers to an USB mass-storage device (actually, it's my digicam, but it 
acts as if it is an USB storage device).

When I plug the cam on the USB cable, it is recognized as a massstorage 
device and the appropriate module is loaded (storage-usb if i'm correct) It 
is registered in the /proc/bus/usb filesystem. When attempting to mount it, 
the mount hangs indefinitely, and the cam compactflash access led keeps on 
blinking, as if it can't read the FS on the cam (which is vfat).

Every subsequent mount of this device hangs too. The mounts are unkillable 
(not even with -SIGKILL as root).

This causes 2 problems when shutting down the system:
- system hangs, waiting for mounts to get killed
- an oops (which, unfortunately, isn't registered in syslog & stuff because 
they are dead already - I'll copy it by hand someday)


The strange thing is that the usb mounting/unmounting works perfectly if I 
compile everything in the kernel (no modules for USB, that is).

Is this a known problem/bug?
I'll reply on this tonight (when behind pc) with more details.

Thanks,

DK

(no need to CC me, I'm on the list)

