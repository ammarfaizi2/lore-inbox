Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280714AbRKBQCv>; Fri, 2 Nov 2001 11:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280712AbRKBQCp>; Fri, 2 Nov 2001 11:02:45 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:48891 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S280714AbRKBQC0>;
	Fri, 2 Nov 2001 11:02:26 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: ECS k7s5a audio sound SiS 735 - 7012
In-Reply-To: <20011031033018.A1917@babylon.d2dc.net>
	<E15ysyg-0003Gw-00@the-village.bc.nu>
From: John Fremlin <jtf24@cam.ac.uk>
In-Reply-To: <E15ysyg-0003Gw-00@the-village.bc.nu>
Date: 02 Nov 2001 15:48:16 +0000
Message-ID: <86itct6unz.fsf_-_@cam.ac.uk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > The only problems I have seen with this board are that I can't find
> > drivers for the sound (no big loss), lmsensors does not seem to be able
> 
> [ALSA has one I believe]

I couldn't see one. Do you know what name it would have or where I can
get the datasheet for it?

The ECS K75S5A motherboard is built around a SiS735 chipset with
integrated sound, called a SiS7012 by SiS. According to
http://www.sis.com/support/driver/audio.htm one MS-Windows driver
covers the chipsets SiS635, SiS735, SiS633, and SiS733.

There allegedly exist non-free Linux drivers from OSS called the
SiS7012. 

The PCI dump for the sound part is

/proc/pci:
  Bus  0, device   2, function  7:
    Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev 160).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=52.Max Lat=11.
      I/O at 0xdc00 [0xdcff].
      I/O at 0xd800 [0xd83f].


/sbin/lspci  -v:
00:02.7 Class 0401: 1039:7012 (rev a0)
        Subsystem: 1019:0a14
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at dc00 [size=256]
        I/O ports at d800 [size=64]
        Capabilities: [48] Power Management version 2

[...]

-- 

	http://ape.n3.net

