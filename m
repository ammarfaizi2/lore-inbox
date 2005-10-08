Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbVJHAbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbVJHAbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 20:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbVJHAbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 20:31:09 -0400
Received: from host245-95.pool217223.interbusiness.it ([217.223.95.245]:7405
	"EHLO rc-vaio.rcdiostrouska.com") by vger.kernel.org with ESMTP
	id S1161022AbVJHAbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 20:31:08 -0400
Subject: oops in 2.6.14-rc3
From: Sasa Ostrouska <sasa.ostrouska@volja.net>
Reply-To: sasa.ostrouska@volja.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 08 Oct 2005 02:32:31 +0200
Message-Id: <1128731551.8004.2.camel@rc-vaio.rcdiostrouska.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ppl, 

	After some playing with my new slackware 10.2 and 
kernel 2.6.14-rc3 I noted this oops when shutting down the machine.
Can somebody tell me why ?

Oct  8 02:20:33 rc-vaio kernel: Unable to handle kernel paging request
at virtual address f8c19706
Oct  8 02:20:33 rc-vaio kernel:  printing eip:
Oct  8 02:20:33 rc-vaio kernel: c01eac19
Oct  8 02:20:33 rc-vaio kernel: *pde = 37f83067
Oct  8 02:20:33 rc-vaio kernel: Oops: 0000 [#1]
Oct  8 02:20:33 rc-vaio kernel: PREEMPT
Oct  8 02:20:33 rc-vaio kernel: Modules linked in: nls_iso8859_1
nls_cp437 vfat fat nls_base nvidia snd_pcm_oss snd_mixer_oss ipv6
uhci_hcd joydev parport_pc parport psmouse pcspkr rtc sis_agp shpchp
pci_hotplug i2c_sis96x i2c_core usbhid usb_storage usbmouse snd_intel8x0
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd snd_page_alloc
ohci_hcd ehci_hcd usbcore sis900 ohci1394 ieee1394 tsdev pcmcia
firmware_class yenta_socket rsrc_nonstatic pcmcia_core ide_scsi agpgart
Oct  8 02:20:33 rc-vaio kernel: CPU:    0
Oct  8 02:20:33 rc-vaio kernel: EIP:    0060:[<c01eac19>]    Tainted: P
VLI
Oct  8 02:20:33 rc-vaio kernel: EFLAGS: 00010297   (2.6.14-rc3)
Oct  8 02:20:33 rc-vaio kernel: EIP is at vsnprintf+0x369/0x500
Oct  8 02:20:33 rc-vaio kernel: eax: f8c19706   ebx: 0000000a   ecx:
f8c19706   edx: fffffffe
Oct  8 02:20:33 rc-vaio kernel: esi: f5c8311f   edi: 00000000   ebp:
f5c83fff   esp: ce25ded0
Oct  8 02:20:33 rc-vaio kernel: ds: 007b   es: 007b   ss: 0068
Oct  8 02:20:33 rc-vaio kernel: Process grep (pid: 12222,
threadinfo=ce25c000 task=f65d7a30)
Oct  8 02:20:33 rc-vaio kernel: Stack: 000003e1 00000000 00000010
00000004 00000002 00000001 ffffffff ffffffff
Oct  8 02:20:33 rc-vaio kernel:        00000eed f5c83113 c0331212
f5c83113 f65a3400 f65a3400 00000113 c017c46f
Oct  8 02:20:33 rc-vaio kernel:        ce25df44 c0330509 f78b7fa0
c011fcb4 f65a3400 c0331200 00000000 c0330509
Oct  8 02:20:33 rc-vaio kernel: Call Trace:
Oct  8 02:20:33 rc-vaio kernel:  [<c017c46f>] seq_printf+0x2f/0x60
Oct  8 02:20:33 rc-vaio kernel:  [<c011fcb4>] r_show+0x84/0x90
Oct  8 02:20:33 rc-vaio kernel:  [<c017c031>] seq_read+0x221/0x290
Oct  8 02:20:33 rc-vaio kernel:  [<c015ba27>] vfs_read+0xc7/0x180
Oct  8 02:20:33 rc-vaio kernel:  [<c015bdb7>] sys_read+0x47/0x80
Oct  8 02:20:33 rc-vaio kernel:  [<c0103005>] syscall_call+0x7/0xb
Oct  8 02:20:33 rc-vaio kernel: Code: 00 83 cf 01 89 44 24 1c eb bc 8b
44 24 40 8b 54 24 18 83 44 24 40 04 8b 08 b8 5e 10 34 c0 81 f9 ff 0f 00
00 0f 46 c8 89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83
e7 10 89 c3 75 20
Oct  8 02:20:33 rc-vaio kernel:  <6>note: grep[12222] exited with
preempt_count 1


Many thanks in advance.
Rgds
Sasa

