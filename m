Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWDQWBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWDQWBb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWDQWBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:01:30 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:11453 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1751122AbWDQWBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:01:30 -0400
From: CIJOML <cijoml@volny.cz>
To: linux-dvb@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Kernel OOPSes when playing DVBstream and USB dongle is unplugged. Also oopses when kaffeine is killed after first OOPS
Date: Tue, 18 Apr 2006 00:00:49 +0200
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604180000.49602.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Team,

sending dmesg output:

usb 4-2: new high speed USB device using ehci_hcd and address 4
usb 4-2: configuration #1 chosen from 1 choice
dvb-usb: found a 'WideView WT-220U PenType Receiver (Typhoon/Freecom)' in cold 
state, will try to load a firmware
dvb-usb: downloading firmware from file 'dvb-usb-wt220u-02.fw'
usbcore: registered new driver dvb_usb_dtt200u
usb 4-2: USB disconnect, address 4
dvb-usb: generic DVB-USB module successfully deinitialized and disconnected.
usb 4-2: new high speed USB device using ehci_hcd and address 5
usb 4-2: configuration #1 chosen from 1 choice
dvb-usb: found a 'WideView WT-220U PenType Receiver (Typhoon/Freecom)' in warm 
state.
dvb-usb: will use the device's hardware PID filter (table count: 15).
DVB: registering new adapter (WideView WT-220U PenType Receiver 
(Typhoon/Freecom)).
DVB: registering frontend 0 (WideView USB DVB-T)...
input: IR-receiver inside an USB DVB receiver as /class/input/input6
dvb-usb: schedule remote query interval to 300 msecs.
dvb-usb: WideView WT-220U PenType Receiver (Typhoon/Freecom) successfully 
initialized and connected.
dvb-usb: recv bulk message failed: -110
dvb-usb: bulk message failed: -71 (1/0)
usb 4-2: USB disconnect, address 5
dvb-usb: bulk message failed: -22 (1/1)
dvb-usb: WideView WT-220U PenType Receiver (Typhoon/Freecom) successfully 
deinitialized and disconnected.
Unable to handle kernel NULL pointer dereference at virtual address 00000038
 printing eip:
fcc17d5c
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: dvb_usb_dtt200u dvb_usb dvb_core i2c_core dvb_pll 
snd_pcm_oss snd_mixer_oss ppp_deflate zlib_deflate bsd_comp ppp_async 
crc_ccitt ppp_generic slhc hci_usb bnep rfcomm hidp l2cap bluetooth hostap_cs 
hostap ieee80211_crypt parport_pc parport snd_intel8x0m 8250_pci 8250 
serial_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd 
snd_page_alloc ehci_hcd usbhid uhci_hcd 8139too mii nls_iso8859_2 ntfs ide_cd 
cdrom rtc
CPU:    0
EIP:    0060:[<fcc17d5c>]    Not tainted VLI
EFLAGS: 00210246   (2.6.16.2 #5)
EIP is at dvb_dvr_poll+0x49/0x6a [dvb_core]
eax: 00000030   ebx: 00000000   ecx: 00000106   edx: 00000002
esi: 00000000   edi: ec1ff300   ebp: eb3feb00   esp: ebebbf54
ds: 007b   es: 007b   ss: 0068
Process kaffeine (pid: 5041, threadinfo=ebeba000 task=ed21e030)
Stack: <0>ec1ff300 00000020 eb3feb08 c015dcff ec1ff300 00000000 0826b060 
eb3feb00
       00000000 00000000 00000001 00000000 c015d117 e89dd000 00000000 0826b058
       00000000 b6491ff4 ebeba000 c015e0df 0826b058 00000001 ebebbfb0 00000000
Call Trace:
 [<c015dcff>] do_sys_poll+0x17a/0x317
 [<c015d117>] __pollwait+0x0/0x9a
 [<c015e0df>] sys_poll+0x42/0x47
 [<c0102a85>] syscall_call+0x7/0xb
Code: fc 68 a0 09 c2 fc e8 e2 0e 50 c3 58 5a 8d 43 30 85 f6 74 0c 85 c0 74 08 
56 50 57 ff 16 83 c4 0c b9 06 01 00 00 f6 47 18 03 75 1b <8b> 43 38 83 f8 01 
19 c9 f7 d1 83 e1 4b 8b 43 2c 89 ca 83 ca 43
 <1>Unable to handle kernel paging request at virtual address fcb2104c
 printing eip:
fcc17673
*pde = 01b12067
*pte = 00000000
Oops: 0000 [#2]
PREEMPT
Modules linked in: dvb_usb_dtt200u dvb_usb dvb_core i2c_core dvb_pll 
snd_pcm_oss snd_mixer_oss ppp_deflate zlib_deflate bsd_comp ppp_async 
crc_ccitt ppp_generic slhc hci_usb bnep rfcomm hidp l2cap bluetooth hostap_cs 
hostap ieee80211_crypt parport_pc parport snd_intel8x0m 8250_pci 8250 
serial_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd 
snd_page_alloc ehci_hcd usbhid uhci_hcd 8139too mii nls_iso8859_2 ntfs ide_cd 
cdrom rtc
CPU:    0
EIP:    0060:[<fcc17673>]    Not tainted VLI
EFLAGS: 00210246   (2.6.16.2 #5)
EIP is at dvb_demux_poll+0x29/0x56 [dvb_core]
eax: fcb21064   ebx: fcb21000   ecx: ffffffea   edx: 00000000
esi: ed388cc0   edi: ea42c728   ebp: ea42c720   esp: ec3bff58
ds: 007b   es: 007b   ss: 0068
Process kaffeine (pid: 5038, threadinfo=ec3be000 task=ec23d030)
Stack: <0>ed388cc0 00000020 c015dcff ed388cc0 00000000 0826c258 ea42c720 
00000000
       00000000 00000001 00000000 c015d117 e89eb000 00000000 0826c250 000003e8
       b6491ff4 ec3be000 c015e0df 0826c250 00000001 ec3bffb0 00000000 00000000
Call Trace:
 [<c015dcff>] do_sys_poll+0x17a/0x317
 [<c015d117>] __pollwait+0x0/0x9a
 [<c015e0df>] sys_poll+0x42/0x47
 [<c0102a85>] syscall_call+0x7/0xb
Code: 14 c3 56 53 8b 74 24 0c 8b 54 24 10 8b 5e 74 b9 ea ff ff ff 85 db 74 3b 
8d 43 64 85 d2 74 0c 85 c0 74 08 52 50 56 ff 12 83 c4 0c <8b> 43 4c 83 e8 03 
31 c9 83 f8 02 77 1b 8b 43 6c 83 f8 01 19 c9
 <1>Unable to handle kernel paging request at virtual address fcb210f4
 printing eip:
fcc18cd5
*pde = 01b12067
*pte = 00000000
Oops: 0000 [#3]
PREEMPT
Modules linked in: dvb_usb_dtt200u dvb_usb dvb_core i2c_core dvb_pll 
snd_pcm_oss snd_mixer_oss ppp_deflate zlib_deflate bsd_comp ppp_async 
crc_ccitt ppp_generic slhc hci_usb bnep rfcomm hidp l2cap bluetooth hostap_cs 
hostap ieee80211_crypt parport_pc parport snd_intel8x0m 8250_pci 8250 
serial_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd 
snd_page_alloc ehci_hcd usbhid uhci_hcd 8139too mii nls_iso8859_2 ntfs ide_cd 
cdrom rtc
CPU:    0
EIP:    0060:[<fcc18cd5>]    Not tainted VLI
EFLAGS: 00210282   (2.6.16.2 #5)
EIP is at dvb_demux_release+0xa/0x102 [dvb_core]
eax: eb905600   ebx: fcb210a4   ecx: f7b28d30   edx: eb905600
esi: eb905600   edi: f7b29478   ebp: f7b28d30   esp: eba63f50
ds: 007b   es: 007b   ss: 0068
Process kaffeine (pid: 5036, threadinfo=eba62000 task=c1bff560)
Stack: <0>00000008 eb905600 f7b29478 c014e481 f7b29478 eb905600 c18b41c0 
eb905600
       00000000 c1b6d200 eb905600 c014c044 eb905600 c1b6d200 eb905600 c1b6d200
       00000011 eba62000 c1b6d200 c014c9f8 eb905600 c1b6d200 00000011 0841c924
Call Trace:
 [<c014e481>] __fput+0x80/0x14c
 [<c014c044>] filp_close+0x4e/0x57
 [<c014c9f8>] sys_close+0x69/0x96
 [<c0102a85>] syscall_call+0x7/0xb
Code: 89 c2 83 c4 10 eb 05 ba ea ff ff ff 8b 0c 24 ff 41 3c 0f 8e 59 02 00 00 
89 d0 5f 5d 5b 5e 5f 5d c3 57 56 53 8b 44 24 14 8b 58 74 <8b> 7b 50 ff 4f 3c 
0f 88 47 02 00 00 31 c0 ba 00 fe ff ff 85 c0
 <1>Unable to handle kernel NULL pointer dereference at virtual address 
0000000c
 printing eip:
fcc1cba4
*pde = 00000000
Oops: 0000 [#4]
PREEMPT
Modules linked in: dvb_usb_dtt200u dvb_usb dvb_core i2c_core dvb_pll 
snd_pcm_oss snd_mixer_oss ppp_deflate zlib_deflate bsd_comp ppp_async 
crc_ccitt ppp_generic slhc hci_usb bnep rfcomm hidp l2cap bluetooth hostap_cs 
hostap ieee80211_crypt parport_pc parport snd_intel8x0m 8250_pci 8250 
serial_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd 
snd_page_alloc ehci_hcd usbhid uhci_hcd 8139too mii nls_iso8859_2 ntfs ide_cd 
cdrom rtc

Here I do killall kaffeine and got next oops:

CPU:    0
EIP:    0060:[<fcc1cba4>]    Not tainted VLI
EFLAGS: 00010286   (2.6.16.2 #5)
EIP is at dvb_frontend_release+0x11/0x4f [dvb_core]
eax: 00000000   ebx: eb905240   ecx: f7b19098   edx: eb905240
esi: eb905240   edi: f7b2964c   ebp: f7b19098   esp: ebee3e34
ds: 007b   es: 007b   ss: 0068
Process kaffeine (pid: 5051, threadinfo=ebee2000 task=ec23da90)
Stack: <0>00000008 eb905240 f7b2964c c014e481 f7b2964c eb905240 c18b41c0 
eb905240
       00000000 c1b6d200 c1b6d208 c014c044 eb905240 c1b6d200 eb905240 c1b6d200
       c1b6d200 0000003c 00000eeb c0118fe6 eb905240 c1b6d200 00000001 00000000
Call Trace:
 [<c014e481>] __fput+0x80/0x14c
 [<c014c044>] filp_close+0x4e/0x57
 [<c0118fe6>] put_files_struct+0x66/0xa3
 [<c0119e79>] do_exit+0x1ba/0x6fc
 [<c011a441>] sys_exit_group+0x0/0x11
 [<c0121f7e>] get_signal_to_deliver+0x3df/0x405
 [<c0102443>] do_notify_resume+0x8a/0x5a3
 [<c015d117>] __pollwait+0x0/0x9a
 [<c015d7b7>] core_sys_select+0x23b/0x248
 [<c015dab9>] sys_select+0x9a/0x166
 [<c014e070>] sys_read+0x3b/0x64
 [<c0102b16>] work_notifysig+0x13/0x19
Code: 01 00 00 b8 43 00 00 00 39 93 68 01 00 00 ba 00 00 00 00 0f 44 c2 5b 5e 
5f c3 57 56 53 8b 7c 24 10 8b 5c 24 14 8b 43 74 8b 40 28 <8b> 70 0c 83 3d 98 
84 c2 fc 00 74 11 68 94 01 c2 fc 68 0d 11 c2
 <1>Fixing recursive fault but reboot is needed!
