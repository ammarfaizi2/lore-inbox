Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVCRUEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVCRUEE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 15:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVCRUEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 15:04:04 -0500
Received: from services.blue4.cz ([212.158.157.202]:58591 "HELO smtp.blue4.cz")
	by vger.kernel.org with SMTP id S261791AbVCRUD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 15:03:58 -0500
From: Milan Svoboda <milan.svoboda@centrum.cz>
To: linux-kernel@vger.kernel.org
Subject: kernel oops, 2.6.11.3
Date: Fri, 18 Mar 2005 21:03:59 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503182103.59649.milan.svoboda@centrum.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

usbnet (iPAQ with Familiar) and harddisk connected throught usb were in use 
during this oops.

HW: HP Omnibook xt6200

Mar 18 20:09:07 drak_mrak kernel: Unable to handle kernel paging request at 
virtual address 00001840
Mar 18 20:09:07 drak_mrak kernel:  printing eip:
Mar 18 20:09:07 drak_mrak kernel: c016ba37
Mar 18 20:09:07 drak_mrak kernel: *pde = 00000000
Mar 18 20:09:07 drak_mrak kernel: Oops: 0002 [#1]
Mar 18 20:09:07 drak_mrak kernel: PREEMPT
Mar 18 20:09:07 drak_mrak kernel: Modules linked in: radeon drm nfsd exportfs 
lockd sunrpc nls_iso8859_2 nls_cp852
 vfat fat nls_base usb_storage usbnet snd_pcm_oss snd_mixer_oss uhci_hcd 
ehci_hcd ohci_hcd usbcore snd_ali5451 snd
_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc 8139too orinoco_pci 
orinoco hermes pcmcia yenta_socket
rsrc_nonstatic pcmcia_core sd_mod 8250 serial_core cpufreq_powersave 
cpufreq_ondemand thermal button battery acpi_
cpufreq freq_table processor evdev ali_agp agpgart psmouse
Mar 18 20:09:07 drak_mrak kernel: CPU:    0
Mar 18 20:09:07 drak_mrak kernel: EIP:    0060:[<c016ba37>]    Not tainted VLI
Mar 18 20:09:07 drak_mrak kernel: EFLAGS: 00010282   (2.6.11.3)
Mar 18 20:09:07 drak_mrak kernel: EIP is at prune_icache+0x197/0x210
Mar 18 20:09:07 drak_mrak kernel: eax: cf72cedc   ebx: cc40c084   ecx: 
cc40c084   edx: 00001840
Mar 18 20:09:07 drak_mrak kernel: esi: cc40c07c   edi: 0000007b   ebp: 
c13e7ed8   esp: c13e7ec8
Mar 18 20:09:07 drak_mrak kernel: ds: 007b   es: 007b   ss: 0068
Mar 18 20:09:07 drak_mrak kernel: Process kswapd0 (pid: 150, 
threadinfo=c13e6000 task=c13bba80)
Mar 18 20:09:07 drak_mrak kernel: Stack: cc40c07c c13e7efc 00000024 0000007b 
cc40cd74 cc819364 00000081 00000000
Mar 18 20:09:07 drak_mrak kernel:        00000000 cfeee9e0 c016bacf 00000080 
c013c0d4 00000080 000000d0 0000db3a
Mar 18 20:09:07 drak_mrak kernel:        0002bc00 00000000 00000003 00000000 
c02f1520 00000002 c02f1520 0000db39
Mar 18 20:09:07 drak_mrak kernel: Call Trace:
Mar 18 20:09:07 drak_mrak kernel:  [<c016bacf>] shrink_icache_memory+0x1f/0x50
Mar 18 20:09:07 drak_mrak kernel:  [<c013c0d4>] shrink_slab+0x154/0x190
Mar 18 20:09:07 drak_mrak kernel:  [<c013d64b>] balance_pgdat+0x2db/0x3b0
Mar 18 20:09:07 drak_mrak kernel:  [<c013d809>] kswapd+0xe9/0x110
Mar 18 20:09:07 drak_mrak kernel:  [<c0129660>] 
autoremove_wake_function+0x0/0x60
Mar 18 20:09:07 drak_mrak kernel:  [<c0102612>] ret_from_fork+0x6/0x14
Mar 18 20:09:07 drak_mrak kernel:  [<c0129660>] 
autoremove_wake_function+0x0/0x60
Mar 18 20:09:07 drak_mrak kernel:  [<c013d720>] kswapd+0x0/0x110
Mar 18 20:09:07 drak_mrak kernel:  [<c010087d>] kernel_thread_helper+0x5/0x18
Mar 18 20:09:07 drak_mrak kernel: Code: a1 24 29 2f c0 83 e8 08 39 c6 0f 85 18 
ff ff ff 89 34 24 e8 2c fe ff ff 85
 c0 0f 84 08 ff ff ff 8b 56 04 85 d2 74 18 8b 06 85 c0 <89> 02 74 03 89 50 04 
c7 06 00 00 00 00 c7 46 04 00 00 00
00 8d
Mar 18 20:09:07 drak_mrak kernel:  <6>note: kswapd0[150] exited with 
preempt_count 1
