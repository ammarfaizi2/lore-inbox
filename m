Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSKHE7S>; Thu, 7 Nov 2002 23:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbSKHE7S>; Thu, 7 Nov 2002 23:59:18 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:27143 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S261600AbSKHE7P>; Thu, 7 Nov 2002 23:59:15 -0500
Message-ID: <3DCB479D.3B70EB3B@compuserve.com>
Date: Fri, 08 Nov 2002 00:11:57 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: usb audio null pointer
Content-Type: multipart/mixed;
 boundary="------------4D35D89FFF90ADB189868062"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4D35D89FFF90ADB189868062
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I've tried the latest usb changes from the bk tree, and continue to see
the attached null pointer problem when trying to install the 'audio'
module.

-- 
Kevin
--------------4D35D89FFF90ADB189868062
Content-Type: text/plain; charset=us-ascii;
 name="bk_audio_null_pointer"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bk_audio_null_pointer"

Nov  7 23:52:13 sea kernel: drivers/usb/core/hcd-pci.c: ohci-hcd @ 00:07.4, PCI device 1022:7414
Nov  7 23:52:13 sea kernel: drivers/usb/core/hcd-pci.c: irq 11, pci mem c00dc000
Nov  7 23:52:13 sea kernel: drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
Nov  7 23:52:13 sea kernel: drivers/usb/core/hub.c: USB hub found at 0
Nov  7 23:52:13 sea kernel: drivers/usb/core/hub.c: 4 ports detected
Nov  7 23:52:21 sea kernel: drivers/usb/core/hub.c: new USB device 00:07.4-1, assigned address 2
Nov  7 23:52:35 sea kernel: Unable to handle kernel NULL pointer dereference at virtual address 000001f6
Nov  7 23:52:35 sea kernel:  printing eip:
Nov  7 23:52:35 sea kernel: e0a3611e
Nov  7 23:52:35 sea kernel: *pde = 0d6f5001
Nov  7 23:52:35 sea kernel: Oops: 0000
Nov  7 23:52:35 sea kernel: audio soundcore ohci-hcd nfsd exportfs ipv6 ehci-hcd usbcore 3c59x aic7xxx reiserfs DAC960  
Nov  7 23:52:35 sea kernel: CPU:    0
Nov  7 23:52:35 sea kernel: EIP:    0060:[<e0a3611e>]    Not tainted
Nov  7 23:52:35 sea kernel: EFLAGS: 00010202
Nov  7 23:52:35 sea kernel: EIP is at usb_audio_parsecontrol+0x45e/0x5d0 [audio]
Nov  7 23:52:35 sea kernel: eax: 000001f4   ebx: 00000002   ecx: cda7a208   edx: d7a7c560
Nov  7 23:52:35 sea kernel: esi: d444b812   edi: d055c720   ebp: 00000001   esp: cd6f9dbc
Nov  7 23:52:35 sea kernel: ds: 0068   es: 0068   ss: 0068
Nov  7 23:52:35 sea kernel: Process modprobe (pid: 927, threadinfo=cd6f8000 task=cda807c0)
Nov  7 23:52:35 sea kernel: Stack: e0a39460 cda7a104 ffffffff 00000001 00000000 ffffffff d055c734 d055c72c 
Nov  7 23:52:35 sea kernel:        00000000 00000001 d444b800 cda7a208 d055c3e0 031ac3e0 02000000 00000200 
Nov  7 23:52:35 sea kernel:        d444b800 00000004 e09ba524 d0513800 80000280 00000001 00000080 00000200 
Nov  7 23:52:35 sea kernel: Call Trace:
Nov  7 23:52:35 sea kernel:  [<e0a39460>] usb_audio_driver+0x0/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<e09ba524>] usb_get_descriptor+0x94/0xb0 [usbcore]
Nov  7 23:52:35 sea kernel:  [<e0a363c1>] usb_audio_probe+0x131/0x1b0 [audio]
Nov  7 23:52:35 sea kernel:  [<e0a394e8>] usb_audio_driver+0x88/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<e0a39460>] usb_audio_driver+0x0/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<e0a39420>] usb_audio_ids+0x0/0x28 [audio]
Nov  7 23:52:35 sea kernel:  [<e09b4140>] usb_device_probe+0xb0/0xf0 [usbcore]
Nov  7 23:52:35 sea kernel:  [<e0a39420>] usb_audio_ids+0x0/0x28 [audio]
Nov  7 23:52:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<c01dbe55>] bus_match+0x45/0x70
Nov  7 23:52:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<e09c97d4>] usb_bus_type+0x114/0x140 [usbcore]
Nov  7 23:52:35 sea kernel:  [<c01dbf8d>] driver_attach+0x6d/0x90
Nov  7 23:52:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<e09c96c4>] usb_bus_type+0x4/0x140 [usbcore]
Nov  7 23:52:35 sea kernel:  [<e09c96c0>] usb_bus_type+0x0/0x140 [usbcore]
Nov  7 23:52:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<e0a39490>] usb_audio_driver+0x30/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<c01dc2bd>] bus_add_driver+0x6d/0x90
Nov  7 23:52:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<e0a3859a>] .rodata.str1.1+0x5d/0x77 [audio]
Nov  7 23:52:35 sea kernel:  [<e0a394a0>] usb_audio_driver+0x40/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<c01dca58>] driver_register+0x98/0xb0
Nov  7 23:52:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<e0a39460>] usb_audio_driver+0x0/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<e09b4306>] usb_register+0x86/0xd0 [usbcore]
Nov  7 23:52:35 sea kernel:  [<e0a39478>] usb_audio_driver+0x18/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<c01ce82c>] copy_from_user+0x4c/0x50
Nov  7 23:52:35 sea kernel:  [<e0a365af>] usb_audio_init+0xf/0x20 [audio]
Nov  7 23:52:35 sea kernel:  [<e0a39460>] usb_audio_driver+0x0/0x9c [audio]
Nov  7 23:52:35 sea kernel:  [<c012304f>] sys_init_module+0x4ef/0x640
Nov  7 23:52:35 sea kernel:  [<e0a2e060>] dmabuf_release+0x0/0x60 [audio]
Nov  7 23:52:35 sea kernel:  [<e0a38760>] .kmodtab+0x0/0x18 [audio]
Nov  7 23:52:35 sea kernel:  [<e0a2e060>] dmabuf_release+0x0/0x60 [audio]
Nov  7 23:52:35 sea kernel:  [<c010b373>] syscall_call+0x7/0xb
Nov  7 23:52:35 sea kernel: 
Nov  7 23:52:35 sea kernel: Code: 80 78 02 00 79 39 83 7c 24 24 1f 0f 87 ef fc ff ff 8b 44 24 

--------------4D35D89FFF90ADB189868062--

