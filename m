Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265986AbSKBTHf>; Sat, 2 Nov 2002 14:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbSKBTHf>; Sat, 2 Nov 2002 14:07:35 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:28164 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S265986AbSKBTHd>; Sat, 2 Nov 2002 14:07:33 -0500
Message-ID: <3DC4254A.BEB36954@compuserve.com>
Date: Sat, 02 Nov 2002 14:19:38 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.45 - oops installing usb audio module
Content-Type: multipart/mixed;
 boundary="------------EDFA231ABA49469CEF649845"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EDFA231ABA49469CEF649845
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

When I 'modprobe audio' in 2.5.45, I get the attached oops.  System is
an Athlon MP SMP.

-- 
Kevin
--------------EDFA231ABA49469CEF649845
Content-Type: text/plain; charset=us-ascii;
 name="oops_2545"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops_2545"

Nov  2 13:57:19 sea kernel: drivers/usb/core/hcd-pci.c: ohci-hcd @ 00:07.4, PCI device 1022:7414
Nov  2 13:57:19 sea kernel: drivers/usb/core/hcd-pci.c: irq 11, pci mem c00dc000
Nov  2 13:57:19 sea kernel: drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
Nov  2 13:57:19 sea kernel: drivers/usb/core/hub.c: USB hub found at 0
Nov  2 13:57:19 sea kernel: drivers/usb/core/hub.c: 4 ports detected
Nov  2 13:57:20 sea kernel: drivers/usb/core/hub.c: new USB device 00:07.4-1, assigned address 2
Nov  2 13:57:35 sea kernel: Unable to handle kernel paging request at virtual address 000119a6
Nov  2 13:57:35 sea kernel:  printing eip:
Nov  2 13:57:35 sea kernel: e0a3614e
Nov  2 13:57:35 sea kernel: *pde = 0d89c001
Nov  2 13:57:35 sea kernel: Oops: 0000
Nov  2 13:57:35 sea kernel: audio soundcore ohci-hcd nfsd exportfs ipv6 ehci-hcd usbcore 3c59x aic7xxx reiserfs DAC960  
Nov  2 13:57:35 sea kernel: CPU:    1
Nov  2 13:57:35 sea kernel: EIP:    0060:[<e0a3614e>]    Not tainted
Nov  2 13:57:35 sea kernel: EFLAGS: 00010202
Nov  2 13:57:35 sea kernel: EIP is at usb_audio_parsecontrol+0x49e/0x5e0 [audio]
Nov  2 13:57:35 sea kernel: eax: 000119a4   ebx: 00000002   ecx: 00000003   edx: d65b9540
Nov  2 13:57:35 sea kernel: esi: d6b92c12   edi: ce438dd8   ebp: d6930960   esp: cd869dcc
Nov  2 13:57:35 sea kernel: ds: 0068   es: 0068   ss: 0068
Nov  2 13:57:35 sea kernel: Process modprobe (pid: 931, threadinfo=cd868000 task=cdb80040)
Nov  2 13:57:35 sea kernel: Stack: e0a39460 ce438cec ffffffff 00000001 00000000 ffffffff d6930974 d693096c 
Nov  2 13:57:35 sea kernel:        00000001 00000000 d6b92c00 00000001 cdb8fea0 031afe01 02000000 00000200 
Nov  2 13:57:35 sea kernel:        d6b92c00 00000004 e09ba4e4 ce96ac00 80000280 00000006 00000080 00000200 
Nov  2 13:57:35 sea kernel: Call Trace:
Nov  2 13:57:35 sea kernel:  [<e0a39460>] usb_audio_driver+0x0/0x84 [audio]
Nov  2 13:57:35 sea kernel:  [<e09ba4e4>] usb_get_descriptor+0x94/0xb0 [usbcore]
Nov  2 13:57:35 sea kernel:  [<e0a363c1>] usb_audio_probe+0x131/0x1b0 [audio]
Nov  2 13:57:35 sea kernel:  [<e0a394d0>] usb_audio_driver+0x70/0x84 [audio]
Nov  2 13:57:35 sea kernel:  [<e0a39460>] usb_audio_driver+0x0/0x84 [audio]
Nov  2 13:57:35 sea kernel:  [<e0a39420>] usb_audio_ids+0x0/0x28 [audio]
Nov  2 13:57:35 sea kernel:  [<e09b413a>] usb_device_probe+0xaa/0xe0 [usbcore]
Nov  2 13:57:35 sea kernel:  [<e0a39420>] usb_audio_ids+0x0/0x28 [audio]
Nov  2 13:57:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x84 [audio]
Nov  2 13:57:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x84 [audio]
Nov  2 13:57:35 sea kernel:  [<c01d7972>] bus_match+0x42/0x70
Nov  2 13:57:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x84 [audio]
Nov  2 13:57:35 sea kernel:  [<e09c9604>] usb_bus_type+0x24/0x80 [usbcore]
Nov  2 13:57:35 sea kernel:  [<c01d7a8d>] driver_attach+0x5d/0x80
Nov  2 13:57:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x84 [audio]
Nov  2 13:57:35 sea kernel:  [<e09c95e4>] usb_bus_type+0x4/0x80 [usbcore]
Nov  2 13:57:35 sea kernel:  [<e09c95e0>] usb_bus_type+0x0/0x80 [usbcore]
Nov  2 13:57:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x84 [audio]
Nov  2 13:57:35 sea kernel:  [<c01d7d7a>] bus_add_driver+0x6a/0xa0
Nov  2 13:57:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x84 [audio]
Nov  2 13:57:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x84 [audio]
Nov  2 13:57:35 sea kernel:  [<c01d837e>] driver_register+0x4e/0x60
Nov  2 13:57:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x84 [audio]
Nov  2 13:57:35 sea kernel:  [<e0a39460>] usb_audio_driver+0x0/0x84 [audio]
Nov  2 13:57:35 sea kernel:  [<e09b42d7>] usb_register+0x77/0xc0 [usbcore]
Nov  2 13:57:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x84 [audio]
Nov  2 13:57:35 sea kernel:  [<c01cb5dc>] copy_from_user+0x4c/0x50
Nov  2 13:57:35 sea kernel:  [<e0a365af>] usb_audio_init+0xf/0x20 [audio]
Nov  2 13:57:35 sea kernel:  [<e0a39460>] usb_audio_driver+0x0/0x84 [audio]
Nov  2 13:57:35 sea kernel:  [<c0120d3f>] sys_init_module+0x4ef/0x640
Nov  2 13:57:35 sea kernel:  [<e0a2e060>] dmabuf_release+0x0/0x60 [audio]
Nov  2 13:57:35 sea kernel:  [<e0a38760>] .kmodtab+0x0/0x18 [audio]
Nov  2 13:57:35 sea kernel:  [<e0a2e060>] dmabuf_release+0x0/0x60 [audio]
Nov  2 13:57:35 sea kernel:  [<c0109613>] syscall_call+0x7/0xb
Nov  2 13:57:35 sea kernel: 
Nov  2 13:57:35 sea kernel: Code: 80 78 02 00 79 35 83 7c 24 24 1f 0f 87 af fc ff ff 8b 44 24 

--------------EDFA231ABA49469CEF649845--

