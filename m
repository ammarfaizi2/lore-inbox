Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268084AbUJLWnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268084AbUJLWnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 18:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUJLWnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 18:43:19 -0400
Received: from mx1.nersc.gov ([128.55.6.21]:60874 "EHLO mx1.nersc.gov")
	by vger.kernel.org with ESMTP id S268051AbUJLWlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 18:41:49 -0400
Message-ID: <416C5DA8.3050004@lbl.gov>
Date: Tue, 12 Oct 2004 15:41:44 -0700
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: linux-2.6.9-rc4 oops/IRQ9 problem..
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this when I plugged my Orinoco into a PCcard slot on my Sony laptop

irq 9: nobody cared!
  [<c010809a>] __report_bad_irq+0x2a/0x90
  [<c0108190>] note_interrupt+0x70/0xb0
  [<c01083b3>] do_IRQ+0xf3/0x120
  [<c010622c>] common_interrupt+0x18/0x20
  [<c0108020>] handle_IRQ_event+0x20/0x70
  [<c0108343>] do_IRQ+0x83/0x120
  [<c010622c>] common_interrupt+0x18/0x20
  [<c012102e>] __do_softirq+0x2e/0x90
  [<c01210b7>] do_softirq+0x27/0x30
  [<c010839a>] do_IRQ+0xda/0x120
  [<c010622c>] common_interrupt+0x18/0x20
handlers:
[<c01d50ac>] (acpi_irq+0x0/0x16)
[<d88645e0>] (usb_hcd_irq+0x0/0x70 [usbcore])
[<d88645e0>] (usb_hcd_irq+0x0/0x70 [usbcore])
[<d895b8d0>] (ohci_irq_handler+0x0/0x730 [ohci1394])
[<dc9d18e0>] (yenta_interrupt+0x0/0x40 [yenta_socket])
[<dcc2e820>] (snd_intel8x0_interrupt+0x0/0x210 [snd_intel8x0])
Disabling IRQ #9

irq9 is everything on this machine..  so disabling it kills the machine.

