Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVALScW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVALScW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVALScW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:32:22 -0500
Received: from host245-95.pool217223.interbusiness.it ([217.223.95.245]:21382
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261196AbVALSb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:31:58 -0500
Subject: OOPS in kernel 2.6.10 with quickcam
From: Sasa Ostrouska <sasa.ostrouska@volja.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 12 Jan 2005 19:30:25 +0100
Message-Id: <1105554625.8730.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi I have that message in my dmesg. If somebody is interested in that 
can contact me by e-mail to provide more informations.

I use Slackware current with custom build kernel 2.6.10
On a Sony Vaio PCG-GRT816S laptop.

Best Regards
Sasa Ostrouska

quickcam: QuickCam USB camera found (driver version QuickCam USB $Date:
2004/07/29 18:12:39 $)
quickcam: Kernel:2.6.10 bus:2 class:FF subclass:FF vendor:046D
product:0850
quickcam: Sensor VV6410 detected
quickcam: Registered device: /dev/video0
usbcore: registered new driver quickcam
ohci_hcd 0000:00:03.0: leak ed f70f80c0 (#2) state 2
Unable to handle kernel paging request at virtual address 000379d4
 printing eip:
f8cd7366
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: quickcam videodev audio snd_usb_audio snd_usb_lib
snd_rawmidi snd_seq_device nls_iso8859_1 nls_cp437 vfat fat nls_base
snd_pcm_oss snd_mixer_oss uhci_hcd parport_pc parport rtc sis_agp shpchp
pci_hotplug usb_storage usbhid snd_intel8x0m usbmouse snd_intel8x0
snd_ac97_codec snd_pcm snd_timer snd snd_page_alloc eth1394 ohci_hcd
ehci_hcd usbcore sis900 ohci1394 ieee1394 nvidia agpgart psmouse
CPU:    0
EIP:    0060:[<f8cd7366>]    Tainted: P      VLI
EFLAGS: 00210206   (2.6.10)
EIP is at usb_unlink_urb+0x16/0x50 [usbcore]
eax: d0c77480   ebx: d447a000   ecx: 00000002   edx: 00037914
esi: d0c77480   edi: c18eaf80   ebp: d30ab830   esp: d447af64
ds: 007b   es: 007b   ss: 0068
Process xawtv (pid: 12808, threadinfo=d447a000 task=d4c56a80)
Stack: f8f35047 00000000 f2b8e234 f8f37187 00000000 db23b800 f2b8e000
00000000
       f8f37868 f2b8e000 f8f37abd d95d7d80 c01556d8 d2dbf054 d95d7d80
00000000
       d5c6f980 d447a000 c0153f1f c0148db7 00000004 00000000 0810068c
c0102f5f
Call Trace:
 [<f8f35047>] qc_unlink_urb_sync+0x17/0x40 [quickcam]
 [<f8f37187>] qc_isoc_stop+0x37/0x100 [quickcam]
 [<f8f37868>] qc_capt_exit+0x8/0x30 [quickcam]
 [<f8f37abd>] qc_v4l_close+0x4d/0x60 [quickcam]
 [<c01556d8>] __fput+0x108/0x120
 [<c0153f1f>] filp_close+0x4f/0x80
 [<c0148db7>] sys_munmap+0x47/0x70
 [<c0102f5f>] syscall_call+0x7/0xb
Code: e9 b5 fe ff ff b8 ed ff ff ff e9 4b ff ff ff 8d b6 00 00 00 00 85
c0 ba ea ff ff ff 74 23 f6 40 28 10 74 31 8b 50 1c 85 d2 74 11 <8b> 92
c0 00 00 00 85 d2 74 07 8b 4a 24 85 c9 75 08 ba ed ff ff

root@rc-vaio:/home/sasa/qc-usb-0.6.2#



