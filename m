Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVL3WYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVL3WYM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVL3WYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:24:12 -0500
Received: from wscnet.wsc.cz ([212.80.64.118]:29061 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751106AbVL3WYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:24:11 -0500
Message-ID: <43B5B37F.4040508@liberouter.org>
Date: Fri, 30 Dec 2005 23:23:59 +0100
From: Jiri Slaby <slaby@liberouter.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Mathias Klein <ma_klein@gmx.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: oops in kernel 2.6.15-rc7
References: <20051230194435.GA7088@sidney>
In-Reply-To: <20051230194435.GA7088@sidney>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathias Klein napsal(a):
> Hello,
> 
> i recently got another oops. As suggested by Pekka Enberg I've enabled
> CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC.
> 
> If you need more informations please let me know.
> 
> ------------------------------------------------------------------------
> 
> Dec 30 20:12:11 sidney kernel: [31895.552562] Unable to handle kernel NULL pointer dereference at virtual address 00000020
> Dec 30 20:12:11 sidney kernel: [31895.552699]  printing eip:
> Dec 30 20:12:11 sidney kernel: [31895.552914] c0136b90
> Dec 30 20:12:11 sidney kernel: [31895.552933] *pde = 00000000
> Dec 30 20:12:11 sidney kernel: [31895.553014] Oops: 0000 [#1]
> Dec 30 20:12:11 sidney kernel: [31895.553065] PREEMPT 
> Dec 30 20:12:11 sidney kernel: [31895.553147] Modules linked in: sd_mod usb_storage scsi_mod md5 ipv6 lp capi kernelcapi capifs nls_iso8859_15 nls_cp437 vfat fat parport_pc parport joydev evdev nvidiafb 8139too mii rivafb crc32 tuner tvaudio msp3400 bttv video_buf firmware_class snd_ens1370 gameport i2c_algo_bit snd_rawmidi snd_seq_device snd_bt87x v4l2_common btcx_risc tveeprom videodev snd_pcm snd_ak4531_codec snd_timer snd_page_alloc snd soundcore i2c_viapro i2c_core uhci_hcd usbcore ide_cd cdrom
> Dec 30 20:12:11 sidney kernel: [31895.554927] CPU:    0
> Dec 30 20:12:11 sidney kernel: [31895.554933] EIP:    0060:[mempool_free+4/104]    Not tainted VLI
> Dec 30 20:12:11 sidney kernel: [31895.554942] EFLAGS: 00010282   (2.6.15-rc7.sidney.11) 
[snip]
> Dec 30 20:12:11 sidney kernel: [31895.559540]  [pdflush+31/33] pdflush+0x1f/0x21
> Dec 30 20:12:11 sidney kernel: [31895.559665]  [kthread+110/156] kthread+0x6e/0x9c
> Dec 30 20:12:11 sidney kernel: [31895.559797]  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
> Dec 30 20:12:11 sidney kernel: [31895.559922] Code: 7e 14 00 75 05 e8 46 d2 16 00 89 d8 89 fa e8 8b 32 ff ff 8b 45 dc e9 6f ff ff ff 31 db 8d 65 f4 89 d8 5b 5e 5f c9 c3 55 89 e5 57 <56> 8b 7d 08 53 8b 5d 0c 8b 43 10 39 43 14 7d 43 89 d8 e8 89 da 
mm, strange, could you post .config, gcc version and one more question, what is
.sidney.11?

thanks,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
