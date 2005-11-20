Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVKTPD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVKTPD7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 10:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVKTPD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 10:03:59 -0500
Received: from mail.gmx.de ([213.165.64.20]:28306 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751242AbVKTPD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 10:03:59 -0500
X-Authenticated: #438326
From: Michael Geithe <warpy@gmx.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: cinergyT2 oops (was Re: Linux 2.6.15-rc2)
Date: Sun, 20 Nov 2005 16:04:03 +0100
User-Agent: KMail/1.8.3
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511201420.55062.warpy@gmx.de> <20051120145241.GA18234@mipter.zuzino.mipt.ru>
In-Reply-To: <20051120145241.GA18234@mipter.zuzino.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511201604.03548.warpy@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 20 November 2005 15:52, you wrote:

> Can you reproduce it with clean kernel?

the same with clean kernel.

usb 3-4.1: new high speed USB device using ehci_hcd and address 7
DVB: registering new adapter (TerraTec/qanu USB2.0 Highspeed DVB-T Receiver).
Unable to handle kernel paging request at virtual address 0452fc00
 printing eip:
f8feaf01
*pde = 00000000
Oops: 0002 [#1]
SMP 
Modules linked in: cinergyT2 dvb_core w83627hf hwmon_vid eeprom i2c_isa 
snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
snd_seq_midi_emul snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event 
snd_seq usbhid usb_storage ehci_hcd ohci_hcd ohci1394 ieee1394 snd_emu10k1 
snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_ac97_bus 
snd_page_alloc snd_util_mem snd_hwdep snd soundcore e1000 i2c_i801 intel_agp 
usbcore
CPU:    1
EIP:    0060:[<f8feaf01>]    Not tainted VLI
EFLAGS: 00010206   (2.6.15-rc2) 
EIP is at cinergyt2_register_rc+0xc8/0xde [cinergyT2]
eax: 6f635f32   ebx: f7ac83dc   ecx: c180ef60   edx: 0000006f
esi: f6669000   edi: f7ac8000   ebp: f7ac8234   esp: f6611ea8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 10497, threadinfo=f6611000 task=f7b79030)
Stack: f7ac83dc 00000040 f8feb9c4 c197e0f0 f7be5c04 f7ac8000 f7ac8208 00000000 
       f8feb19c f7ac8000 00000003 00000001 f508aa00 f8fece80 ffffffed f8de8ce0 
       f8dcf0a0 f8fecea0 f508aa14 00000000 c0243768 00000000 f7bd4400 c040c200 
Call Trace:
 [<f8feb19c>] cinergyt2_probe+0x19c/0x2f3 [cinergyT2]
 [<f8dcf0a0>] usb_probe_interface+0x6f/0x9a [usbcore]
 [<c0243768>] driver_probe_device+0x36/0xa0
 [<c0243886>] __driver_attach+0x4d/0x4f
 [<c0242f96>] bus_for_each_dev+0x42/0x57
 [<c024389e>] driver_attach+0x16/0x1a
 [<c0243839>] __driver_attach+0x0/0x4f
 [<c024338f>] bus_add_driver+0x7b/0xb9
 [<f8dcf198>] usb_register+0x51/0xb4 [usbcore]
 [<f8fc1011>] cinergyt2_init+0x11/0x58 [cinergyT2]
 [<c012c6cc>] kthread_stop_sem+0x70/0xa8
 [<c0132d9a>] sys_init_module+0x154/0x1ea
 [<c0102b33>] sysenter_past_esp+0x54/0x75
Code: 00 00 00 00 00 00 8d 87 34 04 00 00 e8 11 74 13 c7 31 d2 c7 46 18 02 00 
10 00 c7 46 04 c0 bb fe f8 89 5e 08 8b 04 95 48 b6 fe f8 <f0> 0f ab 46 1c 83 
c2 03 eb ef 83 c4 14 b8 f4 ff ff ff 5b 5e 5f 

Thanks,
M. Geithe
-
