Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263357AbRFYKKS>; Mon, 25 Jun 2001 06:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbRFYKKI>; Mon, 25 Jun 2001 06:10:08 -0400
Received: from iris.kkt.bme.hu ([152.66.114.1]:64782 "HELO iris.kkt.bme.hu")
	by vger.kernel.org with SMTP id <S263357AbRFYKJ6>;
	Mon, 25 Jun 2001 06:09:58 -0400
Date: Mon, 25 Jun 2001 12:09:55 +0200 (CEST)
From: PALFFY Daniel <dpalffy@kkt.bme.hu>
To: John Nilsson <pzycrow@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Some experience of linux on a Laptop
In-Reply-To: <F175UFyfL1QMaCAP6Ki00001f92@hotmail.com>
Message-ID: <Pine.LNX.4.21.0106251139330.1324-100000@iris.kkt.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2001, John Nilsson wrote:

> I have a Toshiba Portégé 3010CT laptop. That is:
> 266MHz Pentium-MMX
> 4GB HD with 512kb cache (which linux reduces to 0kb)
> 32 Mb EDO RAM

I have the same machine with 64 MB ram, and it's quite well supported with
linux. I do most of my daily work on it (except for large builds). I've
really tried to use all the hardware in it, and everything is usable. The
only minor problems are:

- hibernation (yeah, unfinished ACPI work, but the machine is said to have
 a compliant ACPI implementation)
- sound playback and recording (opl3sa2) doesn't seem to work at the same
 time (some DMA problem, there was a patch on the list around the 2.4.3
 time but it was included somewhat differently into the ac tree, i'll try
 the original patch to see if it works)
- ToPIC97 freezes with the yenta driver, i had to put it into ToPIC95
 compatibility mode in the bios. I haven't tried the pcmcia-cs driver, but
 they finally claim to have the correct specs. This is as of 2.4.3-ac3,
 maybe it is already fixed.
- the ide driver is missing, but someone already requested the specs
 ( http://linux.toshiba-dme.co.jp/linux/eng/develop.php3 ), maybe it will
 be available soon. But i don't think it would make much difference with a
 slow old notebook drive... And linux is still much faster than m$.
- After resuming from APM suspend, sometimes 'hda lost interrupt', and the
 only escape is a hard reboot... Should try different apm settings?

And the positives: toshoboe seems to stabilize, usb and X are fine, and
my 3Com Megahertz 3CCFEM556 works flawlessly.

I'll try to debug some of the problems, and send more usable info...

--
Dani
			...and Linux for all.


