Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270066AbTGUMbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269994AbTGUM2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:28:51 -0400
Received: from pop.gmx.de ([213.165.64.20]:32720 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270047AbTGUMZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:25:55 -0400
Message-ID: <3F1BDF5A.8010209@gmx.de>
Date: Mon, 21 Jul 2003 14:40:58 +0200
From: Alexander Rau <al.rau@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ericvb@debian.org
Subject: Re: 2.6.0-test1 fails at insmoding orinoco_cs
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Had the same problems. Check if you enabled ISA support in your kernel
config. Solved my problems. Otherwise check out the pcmcia-cs docs at
pcmcia.sf.net. There's a description of configuration parameters in the
troubleshooting section of the user-howto, especially on irq and io mem
problems...

Regards, Al


> I just gave a try to 2.6.0-test1, all is fine except there's an IRQ
> conflict occuring when modprobing my wireless card's driver:
>
> Jul 19 20:53:37 femto kernel: Linux Kernel Card Services 3.1.22
> Jul 19 20:53:37 femto kernel: options: [pci] [cardbus] [pm]
> Jul 19 20:53:37 femto kernel: PCI: Found IRQ 11 for device 0000:00:0b.0
> Jul 19 20:53:37 femto kernel: Yenta IRQ list 06b0, PCI irq11
> Jul 19 20:53:37 femto kernel: Socket status: 30000411
> Jul 19 20:53:37 femto kernel: PCI: Found IRQ 11 for device 0000:00:0b.1
> Jul 19 20:53:37 femto kernel: Yenta IRQ list 06b0, PCI irq11
> Jul 19 20:53:37 femto kernel: Socket status: 30000087
> Jul 19 20:53:38 femto kernel: cs: memory probe 0x0c0000-0x0fffff: 
> excluding 0xc0000-0xcbfff 0xf0000-0xfffff
> Jul 19 20:53:38 femto kernel: orinoco_cs: RequestIRQ: Resource in use
>
> It's the same driver I used with 2.4.21 and it worked fine. Is this a
> bug ? I'm not a kernel guru... If you need help to debug, lemme know.
>
> Please CC me on reply. 



