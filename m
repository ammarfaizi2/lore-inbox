Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264277AbUFGFW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbUFGFW5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 01:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbUFGFW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 01:22:57 -0400
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:12420
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S264277AbUFGFWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 01:22:55 -0400
Message-ID: <40C3FBAD.7070108@freemail.hu>
Date: Mon, 07 Jun 2004 07:22:53 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031114
X-Accept-Language: hu, en-US
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: DEC 2104x driver confusion with 2.6.5+
References: <40C37C99.1050103@freemail.hu>
In-Reply-To: <40C37C99.1050103@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Boszormenyi írta:
> The second problem is that "de2104x.ko" recognizes the cards
> but autosense does not work, either, and one of the card
> shares its interrupt (IRQ 11) with the onboard USB host.
> The host is flooded with interrupts on IRQ 11 after I load
> de2104x and after some minutes, the kernel disables this IRQ, 
> occasionally I got a lockup, too.

I forgot to send this, too.

Jun  6 17:49:48 localhost kernel: irq 11: nobody cared! (screaming 
interrupt?)
Jun  6 17:49:48 localhost kernel: Call Trace:
Jun  6 17:49:48 localhost kernel:  [<c0106ee5>] __report_bad_irq+0x2b/0x67
Jun  6 17:49:48 localhost kernel:  [<c0106f7d>] note_interrupt+0x43/0x66
Jun  6 17:49:48 localhost kernel:  [<c0107143>] do_IRQ+0x109/0x169
Jun  6 17:49:48 localhost kernel:  [<c0287338>] common_interrupt+0x18/0x20
Jun  6 17:49:48 localhost kernel:  [<c011c254>] __do_softirq+0x2c/0x73
Jun  6 17:49:48 localhost kernel:  [<c0107708>] do_softirq+0x46/0x4d
Jun  6 17:49:48 localhost kernel:  =======================
Jun  6 17:49:48 localhost kernel:  [<c0107197>] do_IRQ+0x15d/0x169
Jun  6 17:49:48 localhost kernel:  [<c0287338>] common_interrupt+0x18/0x20
Jun  6 17:49:48 localhost kernel:  [<d091599f>] de_set_rx_mode+0xb/0xd 
[de2104x]
Jun  6 17:49:48 localhost kernel:  [<d0916339>] de_init_hw+0x68/0x6e 
[de2104x]
Jun  6 17:49:48 localhost kernel:  [<d09165e2>] de_open+0x60/0xdd [de2104x]
Jun  6 17:49:48 localhost kernel:  [<c023b589>] dev_open+0x5f/0xc6
Jun  6 17:49:48 localhost kernel:  [<c023c582>] dev_change_flags+0x45/0xe7
Jun  6 17:49:48 localhost kernel:  [<c026e437>] devinet_ioctl+0x296/0x50c
Jun  6 17:49:48 localhost kernel:  [<c026ff3f>] inet_ioctl+0x47/0x73
Jun  6 17:49:48 localhost kernel:  [<c023557d>] sock_ioctl+0x25e/0x274
Jun  6 17:49:48 localhost kernel:  [<c0150576>] sys_ioctl+0x207/0x23d
Jun  6 17:49:48 localhost kernel:  [<c0287147>] syscall_call+0x7/0xb
Jun  6 17:49:48 localhost kernel:
Jun  6 17:49:48 localhost kernel: handlers:
Jun  6 17:49:48 localhost kernel: [<c021995d>] (usb_hcd_irq+0x0/0x4b)
Jun  6 17:49:48 localhost kernel: Disabling IRQ #11

Best regards,
Zoltán Böszörményi


