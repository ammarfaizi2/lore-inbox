Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268944AbUJPWgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268944AbUJPWgw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 18:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268937AbUJPWgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 18:36:52 -0400
Received: from web52901.mail.yahoo.com ([206.190.39.178]:48811 "HELO
	web52901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268944AbUJPWgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 18:36:35 -0400
Message-ID: <20041016223635.41769.qmail@web52901.mail.yahoo.com>
Date: Sat, 16 Oct 2004 23:36:35 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: [OOPS] Linux 2.6.8.1 with PL2303
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6.8.1-SMP on a UP machine, devfs, gcc-3.4.2

I received this error when unplugging my PL2303 USB
serial converter from my USB 2.0 hub. (Not that the
device worked when I tried to use it anyway.)

usb 5-5.4: PL-2303 converter now attached to ttyUSB0
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to
serial adaptor driver v0.11
PL-2303 ttyUSB0: pl2303_open - failed submitting
interrupt urb, error -28
PL-2303 ttyUSB0: PL-2303 converter now disconnected
from ttyUSB0
$ usb 5-5.4: USB disconnect, address 3
Unable to handle kernel NULL pointer dereference at
virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: pl2303 usbserial snd_seq_oss
snd_seq_midi snd_emu10k1_synth snd_emux_synth
snd_seq_virmidi snd_seq_midi_event snd_seq_midi_emul
snd_seq videodev mga deflate zlib_deflate zlib_inflate
twofish serpent aes_i586 blowfish des
sha256 crypto_null af_key md5 ipv6 snd_rtctimer
binfmt_misc w83781d eeprom i2c_sensor i2c_i801
i2c_core ide_cd cdrom psmouse pcspkr button processor
nfs nfsd exportfs lockd sunrpc ehci_hcd eth1394
ohci_hcd ohci1394 ieee1394 8139too mii crc32
emu10k1_gp gameport snd_emu10k1 snd_rawmidi
snd_seq_device snd_ac97_codec snd_pcm snd_timer
snd_page_alloc snd_util_mem snd_hwdep snd soundcore
uhci_hcd usbcore i8xx_tco intel_agp agpgart joydev
evdev ext3 jbd
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010202   (2.6.8.1)
EIP is at 0x0
eax: d3769801   ebx: dace2290   ecx: 00000000   edx:
d3769838
esi: d3769800   edi: dace2280   ebp: cfd71024   esp:
de8c3e7c
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 540, threadinfo=de8c3000
task=dee83310)
Stack: e161df78 d3769838 00000083 dace2280 dace2280
e15fd2a0 cfd71000 e08d910a
       dace2280 dace2280 d051cdd0 dace2290 e15fd2c0
c01f6a66 dace2290 dace22b8
       dace2290 cfd710d0 c01f6cf5 dace2290 dace2290
dace2290 cfd710d0 c01f5a89
Call Trace:
 [<e161df78>] usb_serial_disconnect+0x38/0x90
[usbserial]
 [<e08d910a>] usb_unbind_interface+0x6a/0x70 [usbcore]
 [<c01f6a66>] device_release_driver+0x66/0x70
 [<c01f6cf5>] bus_remove_device+0x65/0xb0
 [<c01f5a89>] device_del+0x59/0xc0
 [<e08e02f8>] usb_disable_device+0x98/0x110 [usbcore]
 [<e08db353>] usb_disconnect+0xb3/0x160 [usbcore]
 [<e08dc322>] hub_port_connect_change+0x242/0x400
[usbcore]
 [<e08dc6b6>] hub_events+0x1d6/0x3d0 [usbcore]
 [<c011ad70>] autoremove_wake_function+0x0/0x60
 [<e08dc8f5>] hub_thread+0x45/0x120 [usbcore]
 [<c011ad70>] autoremove_wake_function+0x0/0x60
 [<c011ad70>] autoremove_wake_function+0x0/0x60
 [<e08dc8b0>] hub_thread+0x0/0x120 [usbcore]
 [<c0103f35>] kernel_thread_helper+0x5/0x10
Code:  Bad EIP value.



	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - all new features - even more fun!  http://uk.messenger.yahoo.com
