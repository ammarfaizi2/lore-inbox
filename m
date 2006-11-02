Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751887AbWKBS15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbWKBS15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 13:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbWKBS15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 13:27:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751887AbWKBS14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 13:27:56 -0500
Date: Thu, 2 Nov 2006 10:27:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Damien Wyart <damien.wyart@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       James@superbug.demon.co.uk, Takashi Iwai <tiwai@suse.de>,
       Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA message with 2.6.19-rc4-mm2 (not -mm1)
Message-Id: <20061102102736.441da786.akpm@osdl.org>
In-Reply-To: <20061102102607.GA2176@localhost.localdomain>
References: <20061102102607.GA2176@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006 11:26:07 +0100
Damien Wyart <damien.wyart@free.fr> wrote:

> I notice these messages when 2.6.19-rc4-mm2 boots (also with rc3-mm1)
> but 2.6.19-rc4-mm1 did NOT display them. Related to the driver tree ?
> Full dmesg and lspci attached. Can provide more details if needed.
> 
> Nov  2 11:06:49 brouette kernel: Advanced Linux Sound Architecture Driver Version 1.0.13 (Sun Oct 22 08:56:16 2006 UTC).
> Nov  2 11:06:49 brouette kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 21 (level, low) -> IRQ 21
> Nov  2 11:06:49 brouette kernel: kobject_add failed for card0 with -EEXIST, don't try to register things with the same name in the same directory.
> Nov  2 11:06:49 brouette kernel:  [<c02b810e>] kobject_add+0x114/0x192
> Nov  2 11:06:49 brouette kernel: input: AT Translated Set 2 keyboard as /class/input/input0
> Nov  2 11:06:49 brouette kernel:  [<c02bb516>] vsnprintf+0x2ef/0x5f8
> Nov  2 11:06:49 brouette kernel:  [<c03131a8>] device_add+0x99/0x446
> Nov  2 11:06:49 brouette kernel:  [<c03135e0>] device_create+0x7b/0x9c
> Nov  2 11:06:49 brouette kernel:  [<c037bc6d>] snd_card_register+0x36/0x2f6
> Nov  2 11:06:49 brouette kernel:  [<c03807f7>] snd_hwdep_new+0x8d/0xc3
> Nov  2 11:06:49 brouette kernel: usb 2-1: new device found, idVendor=056d, idProduct=0002
> Nov  2 11:06:49 brouette kernel: usb 2-1: new device strings: Mfr=4, Product=14, SerialNumber=0
> Nov  2 11:06:49 brouette kernel: usb 2-1: Product: EIZO USB HID Monitor
> Nov  2 11:06:49 brouette kernel: usb 2-1: Manufacturer: EIZO
> Nov  2 11:06:49 brouette kernel: usb 2-1: configuration #1 chosen from 1 choice
> Nov  2 11:06:49 brouette kernel:  [<c03c0c0f>] snd_emux_init_hwdep+0x8f/0x9f
> Nov  2 11:06:49 brouette kernel:  [<c03be44d>] snd_emu10k1_sample_new+0x0/0x1a3
> Nov  2 11:06:49 brouette kernel:  [<c03be990>] snd_emux_register+0xda/0x11e
> Nov  2 11:06:49 brouette kernel:  [<c03be800>] sf_sample_new+0x0/0x1f
> Nov  2 11:06:49 brouette kernel:  [<c03be81f>] sf_sample_free+0x0/0x8
> Nov  2 11:06:49 brouette kernel:  [<c03bda90>] snd_emu10k1_synth_new_device+0xdc/0x14c
> Nov  2 11:06:49 brouette kernel:  [<c03a098d>] init_device+0x28/0x8e
> Nov  2 11:06:49 brouette kernel:  [<c03a0ad7>] find_driver+0x6f/0x115
> Nov  2 11:06:49 brouette kernel:  [<c0418040>] mutex_lock+0xb/0x1c
> Nov  2 11:06:49 brouette kernel:  [<c03a1050>] snd_seq_device_register_driver+0x9b/0x11b
> Nov  2 11:06:49 brouette kernel:  [<c01004b1>] init+0x10d/0x306
> Nov  2 11:06:49 brouette kernel:  [<c0102b96>] ret_from_fork+0x6/0x1c
> Nov  2 11:06:49 brouette kernel:  [<c01003a4>] init+0x0/0x306
> Nov  2 11:06:49 brouette kernel:  [<c01003a4>] init+0x0/0x306
> Nov  2 11:06:49 brouette kernel:  [<c010389b>] kernel_thread_helper+0x7/0x1c
> Nov  2 11:06:49 brouette kernel:  =======================
> Nov  2 11:06:49 brouette kernel: ALSA device list:
> Nov  2 11:06:49 brouette kernel:   #0: SB Live [Unknown] (rev.10, serial:0x80671102) at 0xdf20, irq 21

This could be an existing alsa bug which is now being detected by new
error-checking code.  OTOH, the kobject_add() checking has been in there
for a while, so it could be a new alsa bug too.

But it's an alsa bug.

