Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUF0T5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUF0T5x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 15:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUF0T5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 15:57:53 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:62648 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S262114AbUF0T5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 15:57:47 -0400
Subject: Re: 2.6.7-mm3 USB ehci IRQ problem
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040627114211.0353bc66.akpm@osdl.org>
References: <1088337721.7932.10.camel@paragon.slim>
	 <20040627114211.0353bc66.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-TdBjnT9lSD5ZruCF86CK"
Message-Id: <1088366898.7896.5.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 27 Jun 2004 22:08:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TdBjnT9lSD5ZruCF86CK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-06-27 at 20:42, Andrew Morton wrote:
> Jurgen Kramer <gtm.kramer@inter.nl.net> wrote:
> >
> > With 2.6.7-mm3 I am missing my USB 2.0 memory stick. It doesn't show up
> >  in the usb device listing. But when I unplug it I get:
> > 
> >  irq 23: nobody cared!
> >   [<c0108106>] __report_bad_irq+0x2a/0x8b
> >   [<c01081f0>] note_interrupt+0x6f/0x9f
> >   [<c0108473>] do_IRQ+0x10c/0x10e
> >   [<c0106850>] common_interrupt+0x18/0x20
> >  handlers:
> >  [<f9d0f65c>] (snd_emu10k1_interrupt+0x0/0x3c4 [snd_emu10k1])
> >  Disabling IRQ #23
> 
> Could you please do a `patch -p1 -R' of
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm3/broken-out/bk-acpi.patch
> ?
Unfortunately no improvement. Unplugging the non-working USB stick still
gives:

ACPI: PCI interrupt 0000:02:0b.0[A] -> GSI 23 (level, low) -> IRQ 23
irq 23: nobody cared!
 [<c0108106>] __report_bad_irq+0x2a/0x8b
 [<c01081f0>] note_interrupt+0x6f/0x9f
 [<c0108473>] do_IRQ+0x10c/0x10e
 [<c0106850>] common_interrupt+0x18/0x20
 [<c010401e>] default_idle+0x0/0x2c
 [<c0104047>] default_idle+0x29/0x2c
 [<c01040b0>] cpu_idle+0x33/0x3c
 [<c031684b>] start_kernel+0x1a0/0x1dd
 [<c0316309>] unknown_bootoption+0x0/0x149
handlers:
[<f8a8d65c>] (snd_emu10k1_interrupt+0x0/0x3c4 [snd_emu10k1])
Disabling IRQ #23

Full dmesg attached.

Jurgen



--=-TdBjnT9lSD5ZruCF86CK
Content-Disposition: attachment; filename=dmesg-267-mm3-revertacpi-brokenusb.gz
Content-Type: application/x-gzip; name=dmesg-267-mm3-revertacpi-brokenusb.gz
Content-Transfer-Encoding: base64

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


--=-TdBjnT9lSD5ZruCF86CK--

