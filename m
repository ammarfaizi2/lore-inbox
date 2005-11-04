Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbVKDXZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbVKDXZT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVKDXZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:25:18 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:703 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750956AbVKDXZR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:25:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SLUb5iZ1hJskQ/U7oZM0AZF08tj65R40Bl5uVMVxzrE3PvyEiPp0mSgIuZhph6HYEFAHFZQzWckTeygzpE8N+Rp3QrA/1C5BkJZv6iSFabiJr05JN8+9N+/oHfWoxqI1+QC5QzqwVf8Vc/d3DHp/sI6uDhEc1Ip1PmoYX1YYGY4=
Message-ID: <8b2d7b4d0511041525g3bd05e7dycb1816db331c68a9@mail.gmail.com>
Date: Sat, 5 Nov 2005 00:25:16 +0100
From: Sandro Tosi <matrixhasu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Oops on 2.6.14 (debian -1-smp pck)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I hope I'm going do the right think posting here this oops tracing:

Nov  5 00:00:39 morpheus kernel: kernel BUG at mm/rmap.c:487!
Nov  5 00:00:39 morpheus kernel: invalid operand: 0000 [#1]
Nov  5 00:00:39 morpheus kernel: SMP
Nov  5 00:00:39 morpheus kernel: Modules linked in: snd_ca0106
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd
soundcore snd_ac97_bus snd_page_alloc isofs sd_mod usb_storage
scsi_mod lp ipt_TCPMSS ipt_tcpmss iptable_filter ip_tables pppoe pppox
ipv6 af_packet ppp_generic slhc tsdev floppy pcspkr 8139cp i2c_viapro
via686a i2c_isa i2c_core shpchp pci_hotplug yealink via_agp usbhid
uhci_hcd usbcore pdc202xx_old e100 8139too mii parport_pc parport
agpgart
nls_iso8859_1 nls_cp437 vfat fat ide_cd cdrom unix ext3 jbd mbcache
dm_mod ide_disk ide_generic generic via82cxxx ide_core evdev mousedev
psmouse
Nov  5 00:00:39 morpheus kernel: CPU:    1
Nov  5 00:00:39 morpheus kernel: EIP:    0060:[page_remove_rmap+73/96]
   Not tainted VLI
Nov  5 00:00:39 morpheus kernel: EFLAGS: 00010286   (2.6.14-1-686-smp)
Nov  5 00:00:39 morpheus kernel: EIP is at page_remove_rmap+0x49/0x60
Nov  5 00:00:39 morpheus kernel: eax: ffffffff   ebx: c1630740   ecx:
00000038   edx: c1630740
Nov  5 00:00:39 morpheus kernel: esi: f0b73218   edi: c180e840   ebp:
08086000   esp: f223ddb8
Nov  5 00:00:39 morpheus kernel: ds: 007b   es: 007b   ss: 0068
Nov  5 00:00:39 morpheus kernel: Process metacity (pid: 6915,
threadinfo=f223c000 task=f3e9ba90)
Nov  5 00:00:39 morpheus kernel: Stack: c015245d c1630740 c01572cf
c1630740 00000000 f7b64084 080bd000 080bd000
Nov  5 00:00:39 morpheus kernel:        080bcfff c0157455 c180e840
f7b64080 08048000 080bd000 00000000 00075000
Nov  5 00:00:39 morpheus kernel:        080bd000 f10816a4 0038b000
c0157582 c180e840 f10816a4 08048000 080bd000
Nov  5 00:00:39 morpheus kernel: Call Trace:
Nov  5 00:00:39 morpheus kernel:  [mark_page_accessed+45/64]
mark_page_accessed+0x2d/0x40
Nov  5 00:00:39 morpheus kernel:  [zap_pte_range+415/656]
zap_pte_range+0x19f/0x290
Nov  5 00:00:39 morpheus kernel:  [unmap_page_range+149/208]
unmap_page_range+0x95/0xd0
Nov  5 00:00:39 morpheus kernel:  [unmap_vmas+242/624] unmap_vmas+0xf2/0x270
Nov  5 00:00:39 morpheus kernel:  [exit_mmap+161/400] exit_mmap+0xa1/0x190
Nov  5 00:00:39 morpheus kernel:  [mmput+56/160] mmput+0x38/0xa0
Nov  5 00:00:39 morpheus kernel:  [do_exit+225/1024] do_exit+0xe1/0x400
Nov  5 00:00:39 morpheus kernel:  [do_group_exit+64/176] do_group_exit+0x40/0xb0
Nov  5 00:00:39 morpheus kernel:  [get_signal_to_deliver+546/832]
get_signal_to_deliver+0x222/0x340
Nov  5 00:00:39 morpheus kernel:  [do_signal+109/368] do_signal+0x6d/0x170
Nov  5 00:00:39 morpheus kernel:  [do_pollfd+97/192] do_pollfd+0x61/0xc0
Nov  5 00:00:39 morpheus kernel:  [do_poll+106/208] do_poll+0x6a/0xd0
Nov  5 00:00:39 morpheus kernel:  [do_page_fault+576/1770]
do_page_fault+0x240/0x6ea
Nov  5 00:00:39 morpheus kernel:  [do_page_fault+0/1770] do_page_fault+0x0/0x6ea
Nov  5 00:00:39 morpheus kernel:  [do_notify_resume+40/56]
do_notify_resume+0x28/0x38
Nov  5 00:00:39 morpheus kernel:  [work_notifysig+19/25]
work_notifysig+0x13/0x19
Nov  5 00:00:39 morpheus kernel: Code: 89 f6 8b 42 08 40 78 23 b8 ff
ff ff ff 89 44 24 04 c7 04 24 10 00 00 00 e8 75 e2 fe ff 83 c4 08 c3
0f 0b e4 01 47 da 2e c0 eb c5 <0f> 0b e7 01 47 da 2e c0 eb d3 8d b6 00
00 00 00 8d bc 27 00 00
Nov  5 00:00:39 morpheus kernel:  <1>Fixing recursive fault but reboot
is needed!

And yes, a reboot was needed to give me control back to ws. I was
coping a file with nautilus when that error happens.

I'm using

# uname -a
Linux morpheus 2.6.14-1-686-smp #1 SMP Fri Oct 28 17:07:07 JST 2005
i686 GNU/Linux

kernel version, from the debian package linux-image-2.6.14-1-686-smp

If you need some more informations, I'll try to provide them...

Thanks & regards

--
Sandro Tosi (aka Morpheus, matrixhasu)
My (little) site: http://matrixhasu.altervista.org/
