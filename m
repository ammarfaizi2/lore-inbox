Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbUKDVUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbUKDVUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUKDVUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:20:32 -0500
Received: from mirador.placard.fr.eu.org ([81.56.186.204]:55557 "EHLO
	mail.placard.fr.eu.org") by vger.kernel.org with ESMTP
	id S262407AbUKDVUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:20:05 -0500
To: Stelian Pop <stelian@popies.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: meye bug? (was: meye driver update)
Mail-Copies-To: never
X-Face: ,MPrV]g0IX5D7rgJol{*%.pQltD?!TFg(`c8(2pkt-F0SLh(g3mIFYU1GYf]C/GuUTbr;cZ5y;3ALK%.OL8A.^.PW14e/,X-B?Nv}2a9\u-j0sSa
References: <20041104111231.GF3472@crusoe.alcove-fr>
From: Roland Mas <roland.mas@free.fr>
Date: Thu, 04 Nov 2004 22:19:59 +0100
In-Reply-To: <20041104111231.GF3472@crusoe.alcove-fr> (Stelian Pop's message
 of "Thu, 4 Nov 2004 12:12:31 +0100")
Message-ID: <87zn1xjoqo.fsf@mirexpress.internal.placard.fr.eu.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop, 2004-11-04 12:12:31 +0100 :

> Hi,
>
> Please find attached a collection of patches updating the meye driver
> to the latest version.

  I'd like to take the opportunity to report a bug with meye.  I've
ran various 2.6.* kernels on this recently acquired laptop, including
2.6.10-rc1 with your patches, all that with a Debian system on it
(Sarge/testing).  I figured the simplest way to test the meye driver,
and to grab a shot from it, would be to use "motioneye -j foo.jpeg".
Everytime I run that, though, the motioneye process gets stuck into an
apparently endless loop.  top shows it alternatively at states R and
D, I can't kill it (even -9), and the kernel repeatedly complains
"meye: need to reset HIC!".  Repeatedly, as in about twice a second
until reboot.  Oh, and no picture ever comes out, either :-)

  Bits of info you may want:

- lspci says:
0000:00:0b.0 Multimedia controller: Kawasaki Steel Corporation KL5A72002 Motion JPEG (rev 01)

- Sony Vaio model PCG 141C,  a member of the C1VE series;

- motioneye 1.2-3 from Sarge;

- dmesg says:
[...]
PCI: Enabling device 0000:00:09.0 (0006 -> 0007)
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 9 (level, low) -> IRQ 9
sonypi: Sony Programmable I/O Controller Driver v1.23.
sonypi: detected type1 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
sonypi: enabled at irq=11, port1=0x10c0, port2=0x10c4
sonypi: device allocated minor is 63
Sony VAIO Jog Dial installed.
Linux video capture interface: v1.00
meye: using 2 buffers with 600k (1200k total) for capture
PCI: Enabling device 0000:00:0b.0 (0010 -> 0012)
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 9 (level, low) -> IRQ 9
meye: Motion Eye Camera Driver v1.10.
meye: mchip KL5A72002 rev. 1, base fc104800, irq 9
Linux Kernel Card Services
[...]

  Is there anything else I can provide?

  Thanks,

Roland.
-- 
Roland Mas

How does an octopus go into battle?
Fully-armed.
