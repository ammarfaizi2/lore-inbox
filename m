Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278605AbRJSTBF>; Fri, 19 Oct 2001 15:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278606AbRJSTA5>; Fri, 19 Oct 2001 15:00:57 -0400
Received: from slate.cyg.net ([207.107.12.100]:53771 "EHLO slate.cyg.net")
	by vger.kernel.org with ESMTP id <S278605AbRJSTAj>;
	Fri, 19 Oct 2001 15:00:39 -0400
Subject: Re: USB stability - possibly printer related
From: Dan Siemon <dan@coverfire.com>
To: Stanislav Meduna <stano@meduna.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110141544.f9EFiGN01608@meduna.org>
In-Reply-To: <200110141544.f9EFiGN01608@meduna.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 19 Oct 2001 15:01:05 -0400
Message-Id: <1003518067.16964.22.camel@cr156960-a>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-10-14 at 11:44, Stanislav Meduna wrote:
> I had quite bad crashes on my fresh Mandrake 8.1 installation,
> one of them was so bad that it brought the filesystem into
> a FUBAR state - I had to reinstall. I strongly suspect the
> USB part of the kernel to be responsible for this.

I too have had problems exactly like you describe. RedHat 7.1. I start
getting oopes from the printer module and the system will not shut down.
Once rebooted the primary file system is totally hosed. fsck could not
make heads or tails out of it. This has happened twice. I have not had
time to risk killing my system again but it appears to be either related
to postscript printing or the lm_sensors modules. Do you by chance use
lm_sensors?

> My hardware:
> Abit BP6 motherboard, 2 x Celeron, 512 MB RAM, IBM DJNA-371350
> disk on the classic controller, IBM IC35L040AVER07-0 disk on the
> HPT 366 controller, root USB hub on the 440BX chipset,
> "noname" USB hub, HP PSC 750 printer/scanner/copier connected
> to the hub, no other switched-on USB devices at the time
> of my experiments (otherwise I have Compaq iPAQ PocketPC
> and HP 315 digital camera; the camera works quite OK under
> Linux with usb-storage).

My hardware:
FIC AD11 motherboard.
AMD 1.4 Athlon
512 SDRAM
40GB Western Digital
NVIDIA GeForce 2 (XFree driver not NVIDIA binary ones)
HP 648C USB printer

The only other USB device I use is a Logitech mouse.

> Unfortunately the problems are not 100% reproducible - sometimes
> it works, sometimes it does not. Some datapoints collected so far:

I am pretty sure I can make it happen again but I don't have the time to
reinstall my system right now...

> - The most frequent symptom is a lockup - I send something
>   to the printer, it prints a few lines and then the machine
>   locks up - no mouse reaction etc. SysRq does work, but
>   despite sync - unmount - boot sequence I get some fs problems
>   on the subsequent reboot.

Although I do not get lockups the printer symptoms are the same. Partial
output then tons of oopes spilled to the console.

> - I have problems with both Mandrake's kernel (heavily patched
>   2.4.8) and vanilla 2.4.12

Vanilla 2.4.10. I have not had this happen on 2.4.12 but I have really
been avoiding anything I thought might cause this again.

> - It does not matter whether I use uhci or usb-uhci

I use usb-uhci

> - The worst crash had another symptoms shortly before - a few Oopsen
>   in processes completely unrelated to printing (unfortunately
>   the Oops data were lost after the fs exitus :-() and messages
>   stating that some processes cannot be started.

In my case whatever programs were running appears to continue to run
fine. Starting new processes did not work.

> - I got a corruption of the files that were surely _not_
>   opened for writing.

Here too. Many system libs were corrupted. When fsck tried to repair the
file system it spewed all kinds of errors about libs.

> - At least one another person on a local mailing list got
>   very similar problem - loaded USB modules, got a lockup and lost
>   sd_mod and /usr/bin/kdeinit - this time not with a printer, but
>   using usb-storage (which needs sd_mod)

I do not use usb-storage.

	Dan

