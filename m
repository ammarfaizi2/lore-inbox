Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVK1Lea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVK1Lea (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 06:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVK1Lea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 06:34:30 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:45704 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1751241AbVK1Le3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 06:34:29 -0500
Date: Mon, 28 Nov 2005 12:34:17 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Jochen Hein <jochen@jochen.org>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Message-ID: <20051128113417.GA21211@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Jochen Hein <jochen@jochen.org>, linux-dvb-maintainer@linuxtv.org,
	linux-kernel@vger.kernel.org
References: <87r791i35k.fsf@echidna.jochen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r791i35k.fsf@echidna.jochen.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.214.133
Subject: Re: [linux-dvb-maintainer] [linux.kernel] [2.6.15-rc2] cinergyT2: Unable to handle kernel paging request at virtual address ec6c10ec
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 09:32:07AM +0100, Jochen Hein wrote:
> 
> Sorry, I've forgotten to CC: you.

I believe this is the input API change issue fixed in -git already.
Please try 2.6.15-rc2-git6 or wait for -rc3.

Johannes

> Subject: [2.6.15-rc2] cinergyT2: Unable to handle kernel paging request at
> 	virtual address ec6c10ec
> Date: Sun, 27 Nov 2005 22:42:31 +0100
> From: Jochen Hein <jochen@jochen.org>
> X-Mailing-List: linux-kernel@vger.kernel.org
> Organization: linux.* mail to news gateway
> 
> 
> These are the syslog messages:
> 
> Nov 27 20:39:15 hermes kernel: DVB: registering new adapter (TerraTec/qanu USB2.0 Highspeed DVB-T Receiver).
> Nov 27 20:39:15 hermes kernel: Unable to handle kernel paging request at virtual address ec6c10ec
> Nov 27 20:39:15 hermes kernel:  printing eip:
> Nov 27 20:39:15 hermes kernel: e1a20f1a
> Nov 27 20:39:15 hermes kernel: *pde = 00000000
> Nov 27 20:39:15 hermes kernel: Oops: 0002 [#1]
> Nov 27 20:39:15 hermes kernel: PREEMPT
> Nov 27 20:39:15 hermes kernel: Modules linked in: cinergyT2 dvb_core binfmt_misc pcmcia firmware_class nfsd exportfs lockd sunrpc dummy tun ppp_async ppp_generic slhc vfat fat evdev snd_intel8x0 snd_intel8x0m snd_ac97_codec snd_ac97_bus irtty_sir snd_pcm_oss uhci_hcd ehci_hcd sir_dev snd_mixer_oss e100 snd_pcm yenta_socket rsrc_nonstatic pcmcia_core usbcore irda snd_timer snd soundcore snd_page_alloc
> Nov 27 20:39:15 hermes kernel: CPU:    0
> Nov 27 20:39:15 hermes kernel: EIP:    0060:[pg0+559197978/1068663808]    Not tainted VLI
> Nov 27 20:39:15 hermes kernel: EFLAGS: 00010206   (2.6.15-rc2)
> Nov 27 20:39:15 hermes kernel: EIP is at cinergyt2_register_rc+0xcb/0xe1 [cinergyT2]
> Nov 27 20:39:15 hermes kernel: eax: 6f635f32   ebx: de7fb8c4   ecx: 00000000   edx: 0000006f
> Nov 27 20:39:15 hermes kernel: esi: de7fa4ec   edi: de7fb504   ebp: cf775e74   esp: cf775e54
> Nov 27 20:39:15 hermes kernel: ds: 007b   es: 007b   ss: 0068
> Nov 27 20:39:15 hermes kernel: Process modprobe (pid: 3289, threadinfo=cf775000 task=de1ce030)
> Nov 27 20:39:15 hermes kernel: Stack: de7fb8c4 00000040 e1a219fc c15c124c df2dca58 de7fb504 de7fb700 00000000
> Nov 27 20:39:15 hermes kernel:        cf775ea8 e1a2119c de7fb504 00000003 c01e15a0 de7fb72c c14df380 c14dace8
> Nov 27 20:39:15 hermes kernel:        da35b2c0 cf775eb0 de06f720 e1a22ec0 ffffffed cf775ebc e18ac0a8 e1a22ee0
> Nov 27 20:39:15 hermes kernel: Call Trace:
> Nov 27 20:39:15 hermes kernel:  [show_stack+122/144] show_stack+0x7a/0x90
> Nov 27 20:39:15 hermes kernel:  [show_registers+339/439] show_registers+0x153/0x1b7
> Nov 27 20:39:15 hermes kernel:  [die+228/386] die+0xe4/0x182
> Nov 27 20:39:15 hermes kernel:  [do_page_fault+710/1435] do_page_fault+0x2c6/0x59b
> Nov 27 20:39:15 hermes kernel:  [error_code+79/84] error_code+0x4f/0x54
> Nov 27 20:39:15 hermes kernel:  [pg0+559198620/1068663808] cinergyt2_probe+0x182/0x2dd [cinergyT2]
> Nov 27 20:39:15 hermes kernel:  [pg0+557670568/1068663808] usb_probe_interface+0x6f/0x9a [usbcore]
> Nov 27 20:39:15 hermes kernel:  [driver_probe_device+51/154] driver_probe_device+0x33/0x9a
> Nov 27 20:39:15 hermes kernel:  [__driver_attach+88/90] __driver_attach+0x58/0x5a
> Nov 27 20:39:15 hermes kernel:  [bus_for_each_dev+74/95] bus_for_each_dev+0x4a/0x5f
> Nov 27 20:39:15 hermes kernel:  [driver_attach+25/29] driver_attach+0x19/0x1d
> Nov 27 20:39:15 hermes kernel:  [bus_add_driver+120/179] bus_add_driver+0x78/0xb3
> Nov 27 20:39:15 hermes kernel:  [driver_register+52/59] driver_register+0x34/0x3b
> Nov 27 20:39:15 hermes kernel:  [pg0+557670814/1068663808] usb_register+0x52/0xb3 [usbcore]
> Nov 27 20:39:15 hermes kernel:  [pg0+558333971/1068663808] cinergyt2_init+0x13/0x59 [cinergyT2]
> Nov 27 20:39:15 hermes kernel:  [sys_init_module+373/554] sys_init_module+0x175/0x22a
> Nov 27 20:39:15 hermes kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Nov 27 20:39:15 hermes kernel: Code: 00 00 00 00 00 00 8d 87 18 04 00 00 e8 0b 76 70 de 31 d2 c7 46 18 02 00 10 00 c7 46 04 00 1c a2 e1 89 5e 08 8b 04 95 68 16 a2 e1 <0f> ab 46 1c 83 c2 03 eb f0 83 c4 14 b8 f4 ff ff ff 5b 5e 5f 5d
> Nov 27 20:39:33 hermes kernel:  <6>ACPI: PCI interrupt for device 0000:00:1f.6 disabled
> 
> Jochen
> 
> -- 
> #include <~/.signature>: permission denied
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

> 
> 
> -- 
> #include <~/.signature>: permission denied

> _______________________________________________
> linux-dvb-maintainer mailing list
> linux-dvb-maintainer@linuxtv.org
> http://www.linuxtv.org/cgi-bin/mailman/listinfo/linux-dvb-maintainer

