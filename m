Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266417AbUANXln (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUANXER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:04:17 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:10955 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S264398AbUANWvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:51:24 -0500
Date: Wed, 14 Jan 2004 23:51:18 +0100
From: Axel Siebenwirth <axel@pearbough.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-mm2 oops when plugging out USB scanner
Message-ID: <20040114225118.GA9078@neon>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
Organization: pearbough.net
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,

when I plug out my USB AGFA SnapScan 1212U scanner I get this oops.

Jan 14 23:38:50 neon kernel: Unable to handle kernel NULL pointer
Jan 14 23:38:50 neon kernel: c029234f
Jan 14 23:38:50 neon kernel: *pde = 00000000
Jan 14 23:38:50 neon kernel: Oops: 0000 [#1]
Jan 14 23:38:50 neon kernel: CPU:    0
Jan 14 23:38:50 neon kernel: EIP:    0060:[<c029234f>]    Tainted: P   VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 14 23:38:50 neon kernel: EFLAGS: 00010282
Jan 14 23:38:50 neon kernel: eax: dfd32380   ebx: dfd32394   ecx: c0292323
Jan 14 23:38:50 neon kernel: esi: 00000000   edi: dfd0b3a8   ebp: c037747c
Jan 14 23:38:50 neon kernel: ds: 007b   es: 007b   ss: 0068
Jan 14 23:38:50 neon kernel: Stack: dfd32380 c03774f8 dfd32380 c0377560
c027e14b dfd32380 dfd32380 dfd323c0
Jan 14 23:38:50 neon kernel:        dfd32394 c0377580 c0251bf6 dfd32394
dfd323c0 dfd0b3bc dfd0b380 c0291cd6
Jan 14 23:38:50 neon kernel:        dfd32394 dfd32380 dfd0b3bc c037748c
00000000 00000000 c01f368a dfd0b3bc
Jan 14 23:38:50 neon kernel: Call Trace:
Jan 14 23:38:50 neon kernel:  [<c027e14b>] usb_unbind_interface+0x7b/0x7d
Jan 14 23:38:50 neon kernel:  [<c0251bf6>] device_release_driver+0x64/0x66
Jan 14 23:38:50 neon kernel:  [<c0291cd6>] destroy_scanner+0x4f/0xa4
Jan 14 23:38:50 neon kernel:  [<c01f368a>] kobject_cleanup+0x98/0x9a
Jan 14 23:38:50 neon kernel:  [<c027e14b>] usb_unbind_interface+0x7b/0x7d
Jan 14 23:38:50 neon kernel:  [<c0251bf6>] device_release_driver+0x64/0x66
Jan 14 23:38:50 neon kernel:  [<c0251d1a>] bus_remove_device+0x55/0x96
Jan 14 23:38:50 neon kernel:  [<c0250ddc>] device_del+0x5d/0x9b
Jan 14 23:38:50 neon kernel:  [<c0284068>] usb_disable_device+0x71/0xac
Jan 14 23:38:50 neon kernel:  [<c027e8d7>] usb_disconnect+0x9b/0xe8
Jan 14 23:38:50 neon kernel:  [<c0280ef3>]
Jan 14 23:38:50 neon kernel:  [<c0280844>] hub_port_status+0x45/0xb0
Jan 14 23:38:50 neon kernel:  [<c02811cb>] hub_events+0x2d3/0x346
Jan 14 23:38:50 neon kernel:  [<c028126b>] hub_thread+0x2d/0xe4
Jan 14 23:38:50 neon kernel:  [<c02fe832>] ret_from_fork+0x6/0x14
Jan 14 23:38:50 neon kernel:  [<c011cdde>] default_wake_function+0x0/0x12
Jan 14 23:38:50 neon kernel:  [<c028123e>] hub_thread+0x0/0xe4
Jan 14 23:38:50 neon kernel:  [<c0109255>] kernel_thread_helper+0x5/0xb
Jan 14 23:38:50 neon kernel: Code: ec 10 8b 44 24 14 89 5c 24 08 89 74 24 0c


>>EIP; c029234f <usbfs_add_bus+65/118>   <=====

>>eax; dfd32380 <_end+1f8ec918/3fbb7598>
>>ebx; dfd32394 <_end+1f8ec92c/3fbb7598>
>>ecx; c0292323 <usbfs_add_bus+39/118>
>>edi; dfd0b3a8 <_end+1f8c5940/3fbb7598>
>>ebp; c037747c <shrinker_sem+20/24>

Trace; c027e14b <fbcon_scroll+2cb/c39>
Trace; c0251bf6 <device_release_driver+64/66>
Trace; c0291cd6 <default_file_lseek+6f/c2>
Trace; c01f368a <kobject_cleanup+98/9a>
Trace; c027e14b <fbcon_scroll+2cb/c39>
Trace; c0251bf6 <device_release_driver+64/66>
Trace; c0251d1a <bus_remove_device+55/96>
Trace; c0250ddc <device_del+5d/9b>
Trace; c0284068 <fb_validate_mode+85/125>
Trace; c027e8d7 <fbcon_scroll+a57/c39>
Trace; c0280ef3 <fb_pan_display+57/8b>
Trace; c0280844 <fb_show_logo+105/1fa>
Trace; c02811cb <fb_ioctl+ea/543>
Trace; c028126b <fb_ioctl+18a/543>
Trace; c02fe832 <xprt_socket_autoclose+2e/5b>
Trace; c011cdde <default_wake_function+0/12>
Trace; c028123e <fb_ioctl+15d/543>
Trace; c0109255 <kernel_thread_helper+5/b>

Code;  c029234f <usbfs_add_bus+65/118>
00000000 <_EIP>:
Code;  c029234f <usbfs_add_bus+65/118>   <=====
   0:   ec                        in     (%dx),%al   <=====
Code;  c0292350 <usbfs_add_bus+66/118>
   1:   10 8b 44 24 14 89         adc    %cl,0x89142444(%ebx)
Code;  c0292356 <usbfs_add_bus+6c/118>
   7:   5c                        pop    %esp
Code;  c0292357 <usbfs_add_bus+6d/118>
   8:   24 08                     and    $0x8,%al
Code;  c0292359 <usbfs_add_bus+6f/118>
   a:   89 74 24 0c               mov    %esi,0xc(%esp,1)


Linux neon 2.6.1-mm2 #3 Tue Jan 13 18:52:15 CET 2004 i686 unknown unknown
GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.14
e2fsprogs              1.34
quota-tools            3.09.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 2.0.18
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         ide_cd cdrom nvidia

.config.gz attached.

Best regards,
Axel Siebenwirth


____________________________________________________________________________
Axel Siebenwirth				      phone +49 3641 776807 |
Am Birnstiel 3			 		  axel at pearbough dot net |
07745 Jena								    |
Germany________________________________________________http://pearbough.net |

Peeping Tom:
        A window fan.
____________________________________________________________________________

--x+6KMIRAuhnl3hBn
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--x+6KMIRAuhnl3hBn--
