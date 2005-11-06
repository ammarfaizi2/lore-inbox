Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVKFXZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVKFXZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 18:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVKFXZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 18:25:25 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:60336
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932298AbVKFXZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 18:25:24 -0500
Message-ID: <436E90D5.8040800@linuxwireless.org>
Date: Sun, 06 Nov 2005 17:25:09 -0600
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Gustavo_Guillermo_P=E9rez?= <gustavo@compunauta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Several Oops on boot and while system is idle.
References: <436DB9B4.4080804@linuxwireless.org> <200511061106.50534.gustavo@compunauta.com>
In-Reply-To: <200511061106.50534.gustavo@compunauta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo Guillermo Pérez wrote:

>El Domingo, 6 de Noviembre de 2005 02:07, escribió:
>  
>
>>Hi,
>>
>>    I have an IBM T42, latest BIOS, Debian Sid running on the Linus git
>>2.6.14.
>>
>>Please check below an unedited part of the syslog.
>>
>>Are these just applets giving me a hard time?
>>
>>.Alejandro
>>    
>>
>
>Check your ram with memtest
>is too likely to be the guilty.
>  
>
This works perfectly with 2.6.14 and before. All these Oops are only 
with 2.6.14-git

I'm just reporting...

Anyway, memtest came up fine, 0 unstable, 0 dirty pages.

.Alejandro

>  
>
>>Nov  6 01:53:25 localhost kernel:  printing eip:
>>Nov  6 01:53:25 localhost kernel: c014b49f
>>Nov  6 01:53:25 localhost kernel: *pde = 00000000
>>Nov  6 01:53:25 localhost kernel: Oops: 0000 [#5]
>>Nov  6 01:53:25 localhost kernel: PREEMPT
>>Nov  6 01:53:25 localhost kernel: Modules linked in: usb_storage
>>ibm_acpi ipw2200 ieee80211 ieee80211_crypt firmware_class thermal fan
>>button ac battery autofs4 ipv6 af_packet nls_iso8859_1 nls_cp437 joydev
>>nvram hdaps speedstep_centrino processor radeon pcmcia e1000
>>yenta_socket rsrc_nonstatic pcmcia_core i810_audio ac97_codec soundcore
>>i2c_i801 i2c_core ehci_hcd rtc irtty_sir uhci_hcd sir_dev irda shpchp
>>pci_hotplug crc_ccitt intel_agp pcspkr evdev mousedev unix
>>Nov  6 01:53:25 localhost kernel: CPU:    0
>>Nov  6 01:53:25 localhost kernel: EIP:
>>0060:[rw_verify_area+46/122]    Not tainted VLI
>>Nov  6 01:53:25 localhost kernel: EFLAGS: 00013246   (2.6.14)
>>Nov  6 01:53:25 localhost kernel: EIP is at rw_verify_area+0x2e/0x7a
>>Nov  6 01:53:25 localhost kernel: eax: d57eb888   ebx: 00000000   ecx:
>>00000000   edx: 014a8038
>>Nov  6 01:53:25 localhost kernel: esi: 00000040   edi: d515ff00   ebp:
>>00000000   esp: dc71bf00
>>Nov  6 01:53:25 localhost kernel: ds: 007b   es: 007b   ss: 0068
>>Nov  6 01:53:25 localhost kernel: Process Xorg (pid: 5681,
>>threadinfo=dc71a000 task=de2dc030)
>>Nov  6 01:53:25 localhost kernel: Stack: dc71bf30 00000040 00000001
>>c014bc02 00000001 d515ff00 dc71bfa4 00000040
>>Nov  6 01:53:25 localhost kernel:        dc71bf28 00000000 08a1e580
>>00000040 ffff037f ffff0120 ffffffff 080e1e89
>>Nov  6 01:53:25 localhost kernel:        035d0073 bfe20c60 0000007b
>>de2dc030 de2dc250 c010860f de2dc250 bfe20d0c
>>Nov  6 01:53:25 localhost kernel: Call Trace:
>>Nov  6 01:53:25 localhost kernel:  [do_readv_writev+228/583]
>>do_readv_writev+0xe4/0x247
>>Nov  6 01:53:25 localhost kernel:  [restore_i387_fxsave+114/124]
>>restore_i387_fxsave+0x72/0x7c
>>Nov  6 01:53:25 localhost kernel:  [vfs_writev+54/64] vfs_writev+0x36/0x40
>>Nov  6 01:53:25 localhost kernel:  [sys_writev+59/151] sys_writev+0x3b/0x97
>>Nov  6 01:53:25 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>>Nov  6 01:53:25 localhost kernel: Code: 8b 74 24 1c 8b 7c 24 14 85 f6 78
>>62 8b 44 24 18 8b 58 04 8b 08 85 db 78 55 89 f0 31 d2 01 c8 11 da 85 d2
>>78 49 8b 47 08 8b 50 08 <83> ba 98 00 00 00 00 74 36 8b 82 94 00 00 00
>>f6 40 34 40 74 2a
>>Nov  6 01:53:25 localhost kernel:  <7>ipw2200: I ipw_rx_notification
>>type = 25 (4 bytes)
>>Nov  6 01:53:25 localhost kernel: ipw2200: I ipw_rx_notification type =
>>25 (4 bytes)
>>Nov  6 01:53:26 localhost last message repeated 6 times
>>Nov  6 01:53:26 localhost kernel: Unable to handle kernel NULL pointer
>>dereference at virtual address 000000b3
>>Nov  6 01:53:26 localhost kernel:  printing eip:
>>Nov  6 01:53:26 localhost kernel: c014b49f
>>Nov  6 01:53:26 localhost kernel: *pde = 00000000
>>Nov  6 01:53:26 localhost kernel: Oops: 0000 [#6]
>>Nov  6 01:53:26 localhost kernel: PREEMPT
>>Nov  6 01:53:26 localhost kernel: Modules linked in: usb_storage
>>ibm_acpi ipw2200 ieee80211 ieee80211_crypt firmware_class thermal fan
>>button ac battery autofs4 ipv6 af_packet nls_iso8859_1 nls_cp437 joydev
>>nvram hdaps speedstep_centrino processor radeon pcmcia e1000
>>yenta_socket rsrc_nonstatic pcmcia_core i810_audio ac97_codec soundcore
>>i2c_i801 i2c_core ehci_hcd rtc irtty_sir uhci_hcd sir_dev irda shpchp
>>pci_hotplug crc_ccitt intel_agp pcspkr evdev mousedev unix
>>Nov  6 01:53:26 localhost kernel: CPU:    0
>>Nov  6 01:53:26 localhost kernel: EIP:
>>0060:[rw_verify_area+46/122]    Not tainted VLI
>>Nov  6 01:53:26 localhost kernel: EFLAGS: 00010246   (2.6.14)
>>Nov  6 01:53:26 localhost kernel: EIP is at rw_verify_area+0x2e/0x7a
>>Nov  6 01:53:26 localhost kernel: eax: d57ebcc8   ebx: 00000000   ecx:
>>00000000   edx: 0000001b
>>Nov  6 01:53:26 localhost kernel: esi: 0000000c   edi: d54a1d80   ebp:
>>00000000   esp: d5ae1f00
>>Nov  6 01:53:26 localhost kernel: ds: 007b   es: 007b   ss: 0068
>>Nov  6 01:53:26 localhost kernel: Process multiload-apple (pid: 5890,
>>threadinfo=d5ae0000 task=d5914070)
>>Nov  6 01:53:26 localhost kernel: Stack: d5ae1f30 0000000c 00000001
>>c014bc02 00000001 d54a1d80 d5ae1fa4 0000000c
>>Nov  6 01:53:26 localhost kernel:        d5ae1f28 00000003 080a5b78
>>0000000c d5ae0000 d4693668 d498ab24 c033d3d6
>>Nov  6 01:53:26 localhost kernel:        dff41e60 c015efbe dff41e60
>>c04c5614 d53e4540 d53e4540 d498ab24 c014c4ef
>>Nov  6 01:53:26 localhost kernel: Call Trace:
>>Nov  6 01:53:26 localhost kernel:  [do_readv_writev+228/583]
>>do_readv_writev+0xe4/0x247
>>Nov  6 01:53:26 localhost kernel:  [sock_destroy_inode+19/22]
>>sock_destroy_inode+0x13/0x16
>>Nov  6 01:53:26 localhost kernel:  [dput+28/499] dput+0x1c/0x1f3
>>Nov  6 01:53:26 localhost kernel:  [__fput+276/312] __fput+0x114/0x138
>>Nov  6 01:53:26 localhost kernel:  [vfs_writev+54/64] vfs_writev+0x36/0x40
>>Nov  6 01:53:26 localhost kernel:  [sys_writev+59/151] sys_writev+0x3b/0x97
>>Nov  6 01:53:26 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>>Nov  6 01:53:26 localhost kernel: Code: 8b 74 24 1c 8b 7c 24 14 85 f6 78
>>62 8b 44 24 18 8b 58 04 8b 08 85 db 78 55 89 f0 31 d2 01 c8 11 da 85 d2
>>78 49 8b 47 08 8b 50 08 <83> ba 98 00 00 00 00 74 36 8b 82 94 00 00 00
>>f6 40 34 40 74 2a
>>Nov  6 01:53:26 localhost kernel:  <1>Unable to handle kernel NULL
>>pointer dereference at virtual address 00000043
>>Nov  6 01:53:26 localhost kernel:  printing eip:
>>Nov  6 01:53:26 localhost kernel: c0175214
>>Nov  6 01:53:26 localhost kernel: *pde = 00000000
>>Nov  6 01:53:26 localhost kernel: Oops: 0000 [#7]
>>Nov  6 01:53:26 localhost kernel: PREEMPT
>>Nov  6 01:53:26 localhost kernel: Modules linked in: usb_storage
>>ibm_acpi ipw2200 ieee80211 ieee80211_crypt firmware_class thermal fan
>>button ac battery autofs4 ipv6 af_packet nls_iso8859_1 nls_cp437 joydev
>>nvram hdaps speedstep_centrino processor radeon pcmcia e1000
>>yenta_socket rsrc_nonstatic pcmcia_core i810_audio ac97_codec soundcore
>>i2c_i801 i2c_core ehci_hcd rtc irtty_sir uhci_hcd sir_dev irda shpchp
>>pci_hotplug crc_ccitt intel_agp pcspkr evdev mousedev unix
>>Nov  6 01:53:26 localhost kernel: CPU:    0
>>Nov  6 01:53:26 localhost kernel: EIP:    0060:[dnotify_flush+17/125]
>>Not tainted VLI
>>Nov  6 01:53:26 localhost kernel: EFLAGS: 00010256   (2.6.14)
>>Nov  6 01:53:26 localhost kernel: EIP is at dnotify_flush+0x11/0x7d
>>Nov  6 01:53:26 localhost kernel: eax: d57ebcc8   ebx: d54a1d80   ecx:
>>0000001b   edx: d54a1d80
>>Nov  6 01:53:26 localhost kernel: esi: d54a1d80   edi: c1759580   ebp:
>>d627fe00   esp: d5ae1e08
>>Nov  6 01:53:26 localhost kernel: ds: 007b   es: 007b   ss: 0068
>>Nov  6 01:53:26 localhost kernel: Process multiload-apple (pid: 5890,
>>threadinfo=d5ae0000 task=d5914070)
>>Nov  6 01:53:26 localhost kernel: Stack: d54a1d80 00000000 c1759580
>>c014af4e d54a1d80 c1759580 c1759580 00000090
>>Nov  6 01:53:26 localhost kernel:        00000025 c011a376 d54a1d80
>>c1759580 00000002 00000020 c1759580 d5914070
>>Nov  6 01:53:26 localhost kernel:        0000000b 00000001 c011ae39
>>d5ae0000 00000000 d5ae1ecc 000000b3 c0103cea
>>Nov  6 01:53:26 localhost kernel: Call Trace:
>>Nov  6 01:53:26 localhost kernel:  [filp_close+64/87] filp_close+0x40/0x57
>>Nov  6 01:53:26 localhost kernel:  [put_files_struct+102/163]
>>put_files_struct+0x66/0xa3
>>Nov  6 01:53:26 localhost kernel:  [do_exit+431/901] do_exit+0x1af/0x385
>>Nov  6 01:53:26 localhost kernel:  [do_divide_error+0/152]
>>do_divide_error+0x0/0x98
>>Nov  6 01:53:26 localhost kernel:  [do_page_fault+882/1286]
>>do_page_fault+0x372/0x506
>>Nov  6 01:53:26 localhost kernel:  [do_page_fault+0/1286]
>>do_page_fault+0x0/0x506
>>Nov  6 01:53:26 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
>>Nov  6 01:53:26 localhost kernel:  [rw_verify_area+46/122]
>>rw_verify_area+0x2e/0x7a
>>Nov  6 01:53:26 localhost kernel:  [do_readv_writev+228/583]
>>do_readv_writev+0xe4/0x247
>>Nov  6 01:53:26 localhost kernel:  [sock_destroy_inode+19/22]
>>sock_destroy_inode+0x13/0x16
>>Nov  6 01:53:26 localhost kernel:  [dput+28/499] dput+0x1c/0x1f3
>>Nov  6 01:53:26 localhost kernel:  [__fput+276/312] __fput+0x114/0x138
>>Nov  6 01:53:26 localhost kernel:  [vfs_writev+54/64] vfs_writev+0x36/0x40
>>Nov  6 01:53:26 localhost kernel:  [sys_writev+59/151] sys_writev+0x3b/0x97
>>Nov  6 01:53:26 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>>Nov  6 01:53:26 localhost kernel: Code: eb 0c 8b 42 04 8b 12 25 ff ff ff
>>7f 09 c1 85 d2 75 f0 89 8b 0c 01 00 00 5b c3 57 56 53 8b 74 24 10 8b 7c
>>24 14 8b 46 08 8b 48 08 <0f> b7 41 28 25 00 f0 00 00 3d 00 40 00 00 75
>>58 b8 00 e0 ff ff
>>Nov  6 01:53:26 localhost kernel:  <1>Fixing recursive fault but reboot
>>is needed!
>>Nov  6 01:53:26 localhost kernel: Unable to handle kernel paging request
>>at virtual address 014c104f
>>Nov  6 01:53:26 localhost kernel:  printing eip:
>>Nov  6 01:53:26 localhost kernel: c014b49f
>>Nov  6 01:53:26 localhost kernel: *pde = 00000000
>>Nov  6 01:53:26 localhost kernel: Oops: 0000 [#8]
>>Nov  6 01:53:26 localhost kernel: PREEMPT
>>Nov  6 01:53:26 localhost kernel: Modules linked in: usb_storage
>>ibm_acpi ipw2200 ieee80211 ieee80211_crypt firmware_class thermal fan
>>button ac battery autofs4 ipv6 af_packet nls_iso8859_1 nls_cp437 joydev
>>nvram hdaps speedstep_centrino processor radeon pcmcia e1000
>>yenta_socket rsrc_nonstatic pcmcia_core i810_audio ac97_codec soundcore
>>i2c_i801 i2c_core ehci_hcd rtc irtty_sir uhci_hcd sir_dev irda shpchp
>>pci_hotplug crc_ccitt intel_agp pcspkr evdev mousedev unix
>>Nov  6 01:53:26 localhost kernel: CPU:    0
>>Nov  6 01:53:26 localhost kernel: EIP:
>>0060:[rw_verify_area+46/122]    Not tainted VLI
>>Nov  6 01:53:26 localhost kernel: EFLAGS: 00210246   (2.6.14)
>>Nov  6 01:53:26 localhost kernel: EIP is at rw_verify_area+0x2e/0x7a
>>Nov  6 01:53:26 localhost kernel: eax: d57ebbb8   ebx: 00000000   ecx:
>>00000000   edx: 014c0fb7
>>Nov  6 01:53:26 localhost kernel: esi: 0000000c   edi: d57ccf00   ebp:
>>00000000   esp: d5b85f00
>>Nov  6 01:53:26 localhost kernel: ds: 007b   es: 007b   ss: 0068
>>Nov  6 01:53:26 localhost kernel: Process battstat-applet (pid: 5894,
>>threadinfo=d5b84000 task=d5acd540)
>>Nov  6 01:53:26 localhost kernel: Stack: d5b85f30 0000000c 00000001
>>c014bc02 00000001 d57ccf00 d5b85fa4 0000000c
>>Nov  6 01:53:26 localhost kernel:        d5b85f28 00000003 080a7b68
>>0000000c d5b84000 d45b0448 d450c0e4 c033d3d6
>>Nov  6 01:53:26 localhost kernel:        dff41e60 c015efbe dff41e60
>>c04c5614 d53c6980 d53c6980 d450c0e4 c014c4ef
>>Nov  6 01:53:26 localhost kernel: Call Trace:
>>Nov  6 01:53:26 localhost kernel:  [do_readv_writev+228/583]
>>do_readv_writev+0xe4/0x247
>>Nov  6 01:53:26 localhost kernel:  [sock_destroy_inode+19/22]
>>sock_destroy_inode+0x13/0x16
>>Nov  6 01:53:26 localhost kernel:  [dput+28/499] dput+0x1c/0x1f3
>>Nov  6 01:53:26 localhost kernel:  [__fput+276/312] __fput+0x114/0x138
>>Nov  6 01:53:26 localhost kernel:  [vfs_writev+54/64] vfs_writev+0x36/0x40
>>Nov  6 01:53:26 localhost kernel:  [sys_writev+59/151] sys_writev+0x3b/0x97
>>Nov  6 01:53:26 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>>Nov  6 01:53:26 localhost kernel: Code: 8b 74 24 1c 8b 7c 24 14 85 f6 78
>>62 8b 44 24 18 8b 58 04 8b 08 85 db 78 55 89 f0 31 d2 01 c8 11 da 85 d2
>>78 49 8b 47 08 8b 50 08 <83> ba 98 00 00 00 00 74 36 8b 82 94 00 00 00
>>f6 40 34 40 74 2a
>>Nov  6 01:53:26 localhost kernel:  <1>Unable to handle kernel paging
>>request at virtual address 014c0fdf
>>Nov  6 01:53:26 localhost kernel:  printing eip:
>>Nov  6 01:53:26 localhost kernel: c0175214
>>Nov  6 01:53:26 localhost kernel: *pde = 00000000
>>Nov  6 01:53:26 localhost kernel: Oops: 0000 [#9]
>>Nov  6 01:53:26 localhost kernel: PREEMPT
>>Nov  6 01:53:26 localhost kernel: Modules linked in: usb_storage
>>ibm_acpi ipw2200 ieee80211 ieee80211_crypt firmware_class thermal fan
>>button ac battery autofs4 ipv6 af_packet nls_iso8859_1 nls_cp437 joydev
>>nvram hdaps speedstep_centrino processor radeon pcmcia e1000
>>yenta_socket rsrc_nonstatic pcmcia_core i810_audio ac97_codec soundcore
>>i2c_i801 i2c_core ehci_hcd rtc irtty_sir uhci_hcd sir_dev irda shpchp
>>pci_hotplug crc_ccitt intel_agp pcspkr evdev mousedev unix
>>Nov  6 01:53:26 localhost kernel: CPU:    0
>>Nov  6 01:53:26 localhost kernel: EIP:    0060:[dnotify_flush+17/125]
>>Not tainted VLI
>>Nov  6 01:53:26 localhost kernel: EFLAGS: 00210256   (2.6.14)
>>Nov  6 01:53:26 localhost kernel: EIP is at dnotify_flush+0x11/0x7d
>>Nov  6 01:53:26 localhost kernel: eax: d57ebbb8   ebx: d57ccf00   ecx:
>>014c0fb7   edx: d57ccf00
>>Nov  6 01:53:26 localhost kernel: esi: d57ccf00   edi: c1760200   ebp:
>>d627fcc0   esp: d5b85e08
>>Nov  6 01:53:26 localhost kernel: ds: 007b   es: 007b   ss: 0068
>>Nov  6 01:53:26 localhost kernel: Process battstat-applet (pid: 5894,
>>threadinfo=d5b84000 task=d5acd540)
>>Nov  6 01:53:26 localhost kernel: Stack: d57ccf00 00000000 c1760200
>>c014af4e d57ccf00 c1760200 c1760200 00000090
>>Nov  6 01:53:26 localhost kernel:        000000d7 c011a376 d57ccf00
>>c1760200 00000002 00000020 c1760200 d5acd540
>>Nov  6 01:53:26 localhost kernel:        0000000b 00000001 c011ae39
>>d5b84000 00000000 d5b85ecc 014c104f c0103cea
>>Nov  6 01:53:26 localhost kernel: Call Trace:
>>Nov  6 01:53:26 localhost kernel:  [filp_close+64/87] filp_close+0x40/0x57
>>Nov  6 01:53:26 localhost kernel:  [put_files_struct+102/163]
>>put_files_struct+0x66/0xa3
>>Nov  6 01:53:26 localhost kernel:  [do_exit+431/901] do_exit+0x1af/0x385
>>Nov  6 01:53:26 localhost kernel:  [do_divide_error+0/152]
>>do_divide_error+0x0/0x98
>>Nov  6 01:53:26 localhost kernel:  [do_page_fault+882/1286]
>>do_page_fault+0x372/0x506
>>Nov  6 01:53:26 localhost kernel:  [do_page_fault+0/1286]
>>do_page_fault+0x0/0x506
>>Nov  6 01:53:26 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
>>Nov  6 01:53:26 localhost kernel:  [rw_verify_area+46/122]
>>rw_verify_area+0x2e/0x7a
>>Nov  6 01:53:26 localhost kernel:  [do_readv_writev+228/583]
>>do_readv_writev+0xe4/0x247
>>Nov  6 01:53:26 localhost kernel:  [sock_destroy_inode+19/22]
>>sock_destroy_inode+0x13/0x16
>>Nov  6 01:53:26 localhost kernel:  [dput+28/499] dput+0x1c/0x1f3
>>Nov  6 01:53:26 localhost kernel:  [__fput+276/312] __fput+0x114/0x138
>>Nov  6 01:53:26 localhost kernel:  [vfs_writev+54/64] vfs_writev+0x36/0x40
>>Nov  6 01:53:26 localhost kernel:  [sys_writev+59/151] sys_writev+0x3b/0x97
>>Nov  6 01:53:26 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>>Nov  6 01:53:26 localhost kernel: Code: eb 0c 8b 42 04 8b 12 25 ff ff ff
>>7f 09 c1 85 d2 75 f0 89 8b 0c 01 00 00 5b c3 57 56 53 8b 74 24 10 8b 7c
>>24 14 8b 46 08 8b 48 08 <0f> b7 41 28 25 00 f0 00 00 3d 00 40 00 00 75
>>58 b8 00 e0 ff ff
>>Nov  6 01:53:26 localhost kernel:  <1>Fixing recursive fault but reboot
>>is needed!
>>Nov  6 01:53:26 localhost kernel: Unable to handle kernel paging request
>>at virtual address 014bfb1f
>>Nov  6 01:53:26 localhost kernel:  printing eip:
>>Nov  6 01:53:26 localhost kernel: c014b49f
>>Nov  6 01:53:26 localhost kernel: *pde = 00000000
>>Nov  6 01:53:26 localhost kernel: Oops: 0000 [#10]
>>Nov  6 01:53:26 localhost kernel: PREEMPT
>>Nov  6 01:53:26 localhost gdm[5610]: gdm_slave_xioerror_handler: Fatal X
>>error - Restarting :0
>>Nov  6 01:53:26 localhost kernel: Modules linked in: usb_storage
>>ibm_acpi ipw2200 ieee80211 ieee80211_crypt firmware_class thermal fan
>>button ac battery autofs4 ipv6 af_packet nls_iso8859_1 nls_cp437 joydev
>>nvram hdaps speedstep_centrino processor radeon pcmcia e1000
>>yenta_socket rsrc_nonstatic pcmcia_core i810_audio ac97_codec soundcore
>>i2c_i801 i2c_core ehci_hcd rtc irtty_sir uhci_hcd sir_dev irda shpchp
>>pci_hotplug crc_ccitt intel_agp pcspkr evdev mousedev unix
>>Nov  6 01:53:26 localhost kernel: CPU:    0
>>Nov  6 01:53:26 localhost kernel: EIP:
>>0060:[rw_verify_area+46/122]    Not tainted VLI
>>Nov  6 01:53:26 localhost kernel: EFLAGS: 00010246   (2.6.14)
>>Nov  6 01:53:26 localhost kernel: EIP is at rw_verify_area+0x2e/0x7a
>>Nov  6 01:53:26 localhost kernel: eax: d57eba20   ebx: 00000000   ecx:
>>00000000   edx: 014bfa87
>>Nov  6 01:53:26 localhost kernel: esi: 0000000c   edi: d57e3d40   ebp:
>>00000000   esp: d5b43f00
>>Nov  6 01:53:26 localhost kernel: ds: 007b   es: 007b   ss: 0068
>>Nov  6 01:53:26 localhost kernel: Process cpufreq-applet (pid: 5892,
>>threadinfo=d5b42000 task=d5acda50)
>>Nov  6 01:53:26 localhost kernel: Stack: d5b43f30 0000000c 00000001
>>c014bc02 00000001 d57e3d40 d5b43fa4 0000000c
>>Nov  6 01:53:26 localhost kernel:        d5b43f28 00000003 080a6ba8
>>0000000c d5b42000 d45b0dd8 d498a524 c033d3d6
>>Nov  6 01:53:26 localhost kernel:        dff41e60 c015efbe dff41e60
>>c04c5614 d4c08bc0 d4c08bc0 d498a524 c014c4ef
>>Nov  6 01:53:26 localhost kernel: Call Trace:
>>Nov  6 01:53:26 localhost kernel:  [do_readv_writev+228/583]
>>do_readv_writev+0xe4/0x247
>>Nov  6 01:53:26 localhost kernel:  [sock_destroy_inode+19/22]
>>sock_destroy_inode+0x13/0x16
>>Nov  6 01:53:26 localhost kernel:  [dput+28/499] dput+0x1c/0x1f3
>>Nov  6 01:53:26 localhost kernel:  [__fput+276/312] __fput+0x114/0x138
>>Nov  6 01:53:26 localhost kernel:  [vfs_writev+54/64] vfs_writev+0x36/0x40
>>Nov  6 01:53:26 localhost kernel:  [sys_writev+59/151] sys_writev+0x3b/0x97
>>Nov  6 01:53:26 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>>Nov  6 01:53:26 localhost kernel: Code: 8b 74 24 1c 8b 7c 24 14 85 f6 78
>>62 8b 44 24 18 8b 58 04 8b 08 85 db 78 55 89 f0 31 d2 01 c8 11 da 85 d2
>>78 49 8b 47 08 8b 50 08 <83> ba 98 00 00 00 00 74 36 8b 82 94 00 00 00
>>f6 40 34 40 74 2a
>>Nov  6 01:53:26 localhost kernel:  <1>Unable to handle kernel paging
>>request at virtual address 014bfaaf
>>Nov  6 01:53:26 localhost kernel:  printing eip:
>>Nov  6 01:53:26 localhost kernel: c0175214
>>Nov  6 01:53:26 localhost kernel: *pde = 00000000
>>Nov  6 01:53:26 localhost kernel: Oops: 0000 [#11]
>>Nov  6 01:53:26 localhost kernel: PREEMPT
>>Nov  6 01:53:26 localhost kernel: Modules linked in: usb_storage
>>ibm_acpi ipw2200 ieee80211 ieee80211_crypt firmware_class thermal fan
>>button ac battery autofs4 ipv6 af_packet nls_iso8859_1 nls_cp437 joydev
>>nvram hdaps speedstep_centrino processor radeon pcmcia e1000
>>yenta_socket rsrc_nonstatic pcmcia_core i810_audio ac97_codec soundcore
>>i2c_i801 i2c_core ehci_hcd rtc irtty_sir uhci_hcd sir_dev irda shpchp
>>pci_hotplug crc_ccitt intel_agp pcspkr evdev mousedev unix
>>Nov  6 01:53:26 localhost kernel: CPU:    0
>>Nov  6 01:53:26 localhost kernel: EIP:    0060:[dnotify_flush+17/125]
>>Not tainted VLI
>>Nov  6 01:53:26 localhost kernel: EFLAGS: 00010256   (2.6.14)
>>Nov  6 01:53:26 localhost kernel: EIP is at dnotify_flush+0x11/0x7d
>>Nov  6 01:53:26 localhost kernel: eax: d57eba20   ebx: d57e3d40   ecx:
>>014bfa87   edx: d57e3d40
>>Nov  6 01:53:26 localhost kernel: esi: d57e3d40   edi: c17603c0   ebp:
>>d627fd80   esp: d5b43e08
>>Nov  6 01:53:26 localhost kernel: ds: 007b   es: 007b   ss: 0068
>>Nov  6 01:53:26 localhost kernel: Process cpufreq-applet (pid: 5892,
>>threadinfo=d5b42000 task=d5acda50)
>>Nov  6 01:53:26 localhost kernel: Stack: d57e3d40 00000000 c17603c0
>>c014af4e d57e3d40 c17603c0 c17603c0 00000090
>>Nov  6 01:53:26 localhost kernel:        0000004b c011a376 d57e3d40
>>c17603c0 00000002 00000020 c17603c0 d5acda50
>>Nov  6 01:53:26 localhost kernel:        0000000b 00000001 c011ae39
>>d5b42000 00000000 d5b43ecc 014bfb1f c0103cea
>>Nov  6 01:53:26 localhost kernel: Call Trace:
>>Nov  6 01:53:26 localhost kernel:  [filp_close+64/87] filp_close+0x40/0x57
>>Nov  6 01:53:26 localhost kernel:  [put_files_struct+102/163]
>>put_files_struct+0x66/0xa3
>>Nov  6 01:53:26 localhost kernel:  [do_exit+431/901] do_exit+0x1af/0x385
>>Nov  6 01:53:26 localhost kernel:  [do_divide_error+0/152]
>>do_divide_error+0x0/0x98
>>Nov  6 01:53:26 localhost kernel:  [do_page_fault+882/1286]
>>do_page_fault+0x372/0x506
>>Nov  6 01:53:26 localhost kernel:  [do_page_fault+0/1286]
>>do_page_fault+0x0/0x506
>>Nov  6 01:53:26 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
>>Nov  6 01:53:26 localhost kernel:  [rw_verify_area+46/122]
>>rw_verify_area+0x2e/0x7a
>>Nov  6 01:53:26 localhost kernel:  [do_readv_writev+228/583]
>>do_readv_writev+0xe4/0x247
>>Nov  6 01:53:26 localhost kernel:  [sock_destroy_inode+19/22]
>>sock_destroy_inode+0x13/0x16
>>Nov  6 01:53:26 localhost kernel:  [dput+28/499] dput+0x1c/0x1f3
>>Nov  6 01:53:26 localhost kernel:  [__fput+276/312] __fput+0x114/0x138
>>Nov  6 01:53:26 localhost kernel:  [vfs_writev+54/64] vfs_writev+0x36/0x40
>>Nov  6 01:53:26 localhost kernel:  [sys_writev+59/151] sys_writev+0x3b/0x97
>>Nov  6 01:53:26 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>>Nov  6 01:53:26 localhost kernel: Code: eb 0c 8b 42 04 8b 12 25 ff ff ff
>>7f 09 c1 85 d2 75 f0 89 8b 0c 01 00 00 5b c3 57 56 53 8b 74 24 10 8b 7c
>>24 14 8b 46 08 8b 48 08 <0f> b7 41 28 25 00 f0 00 00 3d 00 40 00 00 75
>>58 b8 00 e0 ff ff
>>Nov  6 01:53:26 localhost kernel:  <1>Fixing recursive fault but reboot
>>is needed!
>>Nov  6 01:53:26 localhost kernel: Unable to handle kernel NULL pointer
>>dereference at virtual address 0000013a
>>Nov  6 01:53:26 localhost kernel:  printing eip:
>>Nov  6 01:53:26 localhost kernel: c014b49f
>>Nov  6 01:53:26 localhost kernel: *pde = 00000000
>>Nov  6 01:53:26 localhost kernel: Oops: 0000 [#12]
>>Nov  6 01:53:26 localhost kernel: PREEMPT
>>Nov  6 01:53:26 localhost kernel: Modules linked in: usb_storage
>>ibm_acpi ipw2200 ieee80211 ieee80211_crypt firmware_class thermal fan
>>button ac battery autofs4 ipv6 af_packet nls_iso8859_1 nls_cp437 joydev
>>nvram hdaps speedstep_centrino processor radeon pcmcia e1000
>>yenta_socket rsrc_nonstatic pcmcia_core i810_audio ac97_codec soundcore
>>i2c_i801 i2c_core ehci_hcd rtc irtty_sir uhci_hcd sir_dev irda shpchp
>>pci_hotplug crc_ccitt intel_agp pcspkr evdev mousedev unix
>>Nov  6 01:53:26 localhost kernel: CPU:    0
>>Nov  6 01:53:26 localhost kernel: EIP:
>>0060:[rw_verify_area+46/122]    Not tainted VLI
>>Nov  6 01:53:26 localhost kernel: EFLAGS: 00210246   (2.6.14)
>>Nov  6 01:53:26 localhost kernel: EIP is at rw_verify_area+0x2e/0x7a
>>Nov  6 01:53:26 localhost kernel: eax: d57eb910   ebx: 00000000   ecx:
>>00000000   edx: 000000a2
>>Nov  6 01:53:26 localhost kernel: esi: 0000000c   edi: d57e3bc0   ebp:
>>00000000   esp: d54a7f00
>>Nov  6 01:53:26 localhost kernel: ds: 007b   es: 007b   ss: 0068
>>Nov  6 01:53:26 localhost kernel: Process mixer_applet2 (pid: 5896,
>>threadinfo=d54a6000 task=d5acd030)
>>Nov  6 01:53:26 localhost kernel: Stack: d54a7f30 0000000c 00000001
>>c014bc02 00000001 d57e3bc0 d54a7fa4 0000000c
>>Nov  6 01:53:26 localhost kernel:        d54a7f28 00000003 080a4b90
>>0000000c d54a6000 d4a055e0 d450c564 c033d3d6
>>Nov  6 01:53:26 localhost kernel:        dff41e60 c015efbe dff41e60
>>c04c5614 d53c6440 d53c6440 d450c564 c014c4ef
>>Nov  6 01:53:26 localhost kernel: Call Trace:
>>Nov  6 01:53:26 localhost kernel:  [do_readv_writev+228/583]
>>do_readv_writev+0xe4/0x247
>>Nov  6 01:53:26 localhost kernel:  [sock_destroy_inode+19/22]
>>sock_destroy_inode+0x13/0x16
>>Nov  6 01:53:26 localhost kernel:  [dput+28/499] dput+0x1c/0x1f3
>>Nov  6 01:53:26 localhost kernel:  [__fput+276/312] __fput+0x114/0x138
>>Nov  6 01:53:26 localhost kernel:  [vfs_writev+54/64] vfs_writev+0x36/0x40
>>Nov  6 01:53:26 localhost kernel:  [sys_writev+59/151] sys_writev+0x3b/0x97
>>Nov  6 01:53:26 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>>Nov  6 01:53:26 localhost kernel: Code: 8b 74 24 1c 8b 7c 24 14 85 f6 78
>>62 8b 44 24 18 8b 58 04 8b 08 85 db 78 55 89 f0 31 d2 01 c8 11 da 85 d2
>>78 49 8b 47 08 8b 50 08 <83> ba 98 00 00 00 00 74 36 8b 82 94 00 00 00
>>f6 40 34 40 74 2a
>>Nov  6 01:53:26 localhost kernel:  <1>Unable to handle kernel NULL
>>pointer dereference at virtual address 000000ca
>>Nov  6 01:53:26 localhost kernel:  printing eip:
>>Nov  6 01:53:26 localhost kernel: c0175214
>>Nov  6 01:53:26 localhost kernel: *pde = 00000000
>>Nov  6 01:53:26 localhost kernel: Oops: 0000 [#13]
>>Nov  6 01:53:26 localhost kernel: PREEMPT
>>Nov  6 01:53:26 localhost kernel: Modules linked in: usb_storage
>>ibm_acpi ipw2200 ieee80211 ieee80211_crypt firmware_class thermal fan
>>button ac battery autofs4 ipv6 af_packet nls_iso8859_1 nls_cp437 joydev
>>nvram hdaps speedstep_centrino processor radeon pcmcia e1000
>>yenta_socket rsrc_nonstatic pcmcia_core i810_audio ac97_codec soundcore
>>i2c_i801 i2c_core ehci_hcd rtc irtty_sir uhci_hcd sir_dev irda shpchp
>>pci_hotplug crc_ccitt intel_agp pcspkr evdev mousedev unix
>>Nov  6 01:53:26 localhost kernel: CPU:    0
>>Nov  6 01:53:26 localhost kernel: EIP:    0060:[dnotify_flush+17/125]
>>Not tainted VLI
>>Nov  6 01:53:26 localhost kernel: EFLAGS: 00210256   (2.6.14)
>>Nov  6 01:53:26 localhost kernel: EIP is at dnotify_flush+0x11/0x7d
>>Nov  6 01:53:26 localhost kernel: eax: d57eb910   ebx: d57e3bc0   ecx:
>>000000a2   edx: d57e3bc0
>>Nov  6 01:53:26 localhost kernel: esi: d57e3bc0   edi: c1760040   ebp:
>>d627fe40   esp: d54a7e08
>>Nov  6 01:53:26 localhost kernel: ds: 007b   es: 007b   ss: 0068
>>Nov  6 01:53:26 localhost kernel: Process mixer_applet2 (pid: 5896,
>>threadinfo=d54a6000 task=d5acd030)
>>Nov  6 01:53:26 localhost kernel: Stack: d57e3bc0 00000000 c1760040
>>c014af4e d57e3bc0 c1760040 c1760040 00000090
>>Nov  6 01:53:26 localhost kernel:        000001af c011a376 d57e3bc0
>>c1760040 00000002 00000020 c1760040 d5acd030
>>Nov  6 01:53:26 localhost kernel:        0000000b 00000001 c011ae39
>>d54a6000 00000000 d54a7ecc 0000013a c0103cea
>>Nov  6 01:53:26 localhost kernel: Call Trace:
>>Nov  6 01:53:26 localhost kernel:  [filp_close+64/87] filp_close+0x40/0x57
>>Nov  6 01:53:26 localhost kernel:  [put_files_struct+102/163]
>>put_files_struct+0x66/0xa3
>>Nov  6 01:53:26 localhost kernel:  [do_exit+431/901] do_exit+0x1af/0x385
>>Nov  6 01:53:26 localhost kernel:  [do_divide_error+0/152]
>>do_divide_error+0x0/0x98
>>Nov  6 01:53:26 localhost kernel:  [do_page_fault+882/1286]
>>do_page_fault+0x372/0x506
>>Nov  6 01:53:26 localhost kernel:  [do_page_fault+0/1286]
>>do_page_fault+0x0/0x506
>>Nov  6 01:53:26 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
>>Nov  6 01:53:26 localhost kernel:  [rw_verify_area+46/122]
>>rw_verify_area+0x2e/0x7a
>>Nov  6 01:53:26 localhost kernel:  [do_readv_writev+228/583]
>>do_readv_writev+0xe4/0x247
>>Nov  6 01:53:26 localhost kernel:  [sock_destroy_inode+19/22]
>>sock_destroy_inode+0x13/0x16
>>Nov  6 01:53:26 localhost kernel:  [dput+28/499] dput+0x1c/0x1f3
>>Nov  6 01:53:26 localhost kernel:  [__fput+276/312] __fput+0x114/0x138
>>Nov  6 01:53:26 localhost kernel:  [vfs_writev+54/64] vfs_writev+0x36/0x40
>>Nov  6 01:53:26 localhost kernel:  [sys_writev+59/151] sys_writev+0x3b/0x97
>>Nov  6 01:53:26 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>>Nov  6 01:53:26 localhost kernel: Code: eb 0c 8b 42 04 8b 12 25 ff ff ff
>>7f 09 c1 85 d2 75 f0 89 8b 0c 01 00 00 5b c3 57 56 53 8b 74 24 10 8b 7c
>>24 14 8b 46 08 8b 48 08 <0f> b7 41 28 25 00 f0 00 00 3d 00 40 00 00 75
>>58 b8 00 e0 ff ff
>>Nov  6 01:53:26 localhost kernel:  <1>Fixing recursive fault but reboot
>>is needed!
>>Nov  6 01:53:26 localhost kernel: Unable to handle kernel paging request
>>at virtual address 014a8060
>>Nov  6 01:53:26 localhost kernel:  printing eip:
>>Nov  6 01:53:26 localhost kernel: c0175214
>>Nov  6 01:53:26 localhost kernel: *pde = 00000000
>>Nov  6 01:53:26 localhost kernel: Oops: 0000 [#14]
>>Nov  6 01:53:26 localhost kernel: PREEMPT
>>Nov  6 01:53:26 localhost kernel: Modules linked in: usb_storage
>>ibm_acpi ipw2200 ieee80211 ieee80211_crypt firmware_class thermal fan
>>button ac battery autofs4 ipv6 af_packet nls_iso8859_1 nls_cp437 joydev
>>nvram hdaps speedstep_centrino processor radeon pcmcia e1000
>>yenta_socket rsrc_nonstatic pcmcia_core i810_audio ac97_codec soundcore
>>i2c_i801 i2c_core ehci_hcd rtc irtty_sir uhci_hcd sir_dev irda shpchp
>>pci_hotplug crc_ccitt intel_agp pcspkr evdev mousedev unix
>>Nov  6 01:53:26 localhost kernel: CPU:    0
>>Nov  6 01:53:26 localhost kernel: EIP:    0060:[dnotify_flush+17/125]
>>Not tainted VLI
>>Nov  6 01:53:26 localhost kernel: EFLAGS: 00213246   (2.6.14)
>>Nov  6 01:53:26 localhost kernel: EIP is at dnotify_flush+0x11/0x7d
>>Nov  6 01:53:26 localhost kernel: eax: d57eb888   ebx: d515ff00   ecx:
>>014a8038   edx: d515ff00
>>Nov  6 01:53:26 localhost kernel: esi: d515ff00   edi: c175cc80   ebp:
>>d2d31740   esp: dc71be08
>>Nov  6 01:53:26 localhost kernel: ds: 007b   es: 007b   ss: 0068
>>Nov  6 01:53:26 localhost kernel: Process Xorg (pid: 5681,
>>threadinfo=dc71a000 task=de2dc030)
>>Nov  6 01:53:26 localhost kernel: Stack: d515ff00 00000000 c175cc80
>>c014af4e d515ff00 c175cc80 c175cc80 00000070
>>Nov  6 01:53:26 localhost kernel:        0000000f c011a376 d515ff00
>>c175cc80 00000001 00000000 c175cc80 de2dc030
>>Nov  6 01:53:26 localhost kernel:        0000000b 00000001 c011ae39
>>dc71a000 00000000 dc71becc 014a80d0 c0103cea
>>Nov  6 01:53:26 localhost kernel: Call Trace:
>>Nov  6 01:53:26 localhost kernel:  [filp_close+64/87] filp_close+0x40/0x57
>>Nov  6 01:53:26 localhost kernel:  [put_files_struct+102/163]
>>put_files_struct+0x66/0xa3
>>Nov  6 01:53:26 localhost kernel:  [do_exit+431/901] do_exit+0x1af/0x385
>>Nov  6 01:53:26 localhost kernel:  [do_divide_error+0/152]
>>do_divide_error+0x0/0x98
>>Nov  6 01:53:26 localhost kernel:  [do_page_fault+882/1286]
>>do_page_fault+0x372/0x506
>>Nov  6 01:53:26 localhost kernel:  [do_page_fault+0/1286]
>>do_page_fault+0x0/0x506
>>Nov  6 01:53:26 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
>>Nov  6 01:53:26 localhost kernel:  [rw_verify_area+46/122]
>>rw_verify_area+0x2e/0x7a
>>Nov  6 01:53:26 localhost kernel:  [do_readv_writev+228/583]
>>do_readv_writev+0xe4/0x247
>>Nov  6 01:53:26 localhost kernel:  [restore_i387_fxsave+114/124]
>>restore_i387_fxsave+0x72/0x7c
>>Nov  6 01:53:26 localhost kernel:  [vfs_writev+54/64] vfs_writev+0x36/0x40
>>Nov  6 01:53:26 localhost kernel:  [sys_writev+59/151] sys_writev+0x3b/0x97
>>Nov  6 01:53:26 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>>Nov  6 01:53:26 localhost kernel: Code: eb 0c 8b 42 04 8b 12 25 ff ff ff
>>7f 09 c1 85 d2 75 f0 89 8b 0c 01 00 00 5b c3 57 56 53 8b 74 24 10 8b 7c
>>24 14 8b 46 08 8b 48 08 <0f> b7 41 28 25 00 f0 00 00 3d 00 40 00 00 75
>>58 b8 00 e0 ff ff
>>Nov  6 01:53:26 localhost kernel:  <1>Fixing recursive fault but reboot
>>is needed!
>>Nov  6 01:53:26 localhost kernel: ipw2200: I ipw_rx_notification type =
>>25 (4 bytes)
>>Nov  6 01:53:26 localhost kernel: Unable to handle kernel paging request
>>at virtual address 000095a8
>>Nov  6 01:53:26 localhost kernel:  printing eip:
>>Nov  6 01:53:26 localhost kernel: c014c3f8
>>Nov  6 01:53:26 localhost kernel: *pde = 00000000
>>Nov  6 01:53:26 localhost kernel: Oops: 0000 [#15]
>>Nov  6 01:53:26 localhost kernel: PREEMPT
>>Nov  6 01:53:26 localhost kernel: Modules linked in: usb_storage
>>ibm_acpi ipw2200 ieee80211 ieee80211_crypt firmware_class thermal fan
>>button ac battery autofs4 ipv6 af_packet nls_iso8859_1 nls_cp437 joydev
>>nvram hdaps speedstep_centrino processor radeon pcmcia e1000
>>yenta_socket rsrc_nonstatic pcmcia_core i810_audio ac97_codec soundcore
>>i2c_i801 i2c_core ehci_hcd rtc irtty_sir uhci_hcd sir_dev irda shpchp
>>pci_hotplug crc_ccitt intel_agp pcspkr evdev mousedev unix
>>Nov  6 01:53:26 localhost kernel: CPU:    0
>>Nov  6 01:53:26 localhost kernel: EIP:    0060:[__fput+29/312]    Not
>>tainted VLI
>>Nov  6 01:53:26 localhost kernel: EFLAGS: 00010297   (2.6.14)
>>Nov  6 01:53:26 localhost kernel: EIP is at __fput+0x1d/0x138
>>Nov  6 01:53:26 localhost kernel: eax: 00000000   ebx: d510d9bc   ecx:
>>d99fa090   edx: d50f0380
>>Nov  6 01:53:26 localhost kernel: esi: d50f0380   edi: 00009580   ebp:
>>dff44240   esp: d56c9f44
>>Nov  6 01:53:26 localhost kernel: ds: 007b   es: 007b   ss: 0068
>>Nov  6 01:53:26 localhost kernel: Process clock-applet (pid: 5898,
>>threadinfo=d56c8000 task=d5695a90)
>>Nov  6 01:53:26 localhost kernel: Stack: d57eb778 d510d9bc d571e5f4
>>d510da14 ddf0d040 c01407c3 d56c9f70 d510d9bc
>>Nov  6 01:53:26 localhost kernel:        c0142283 d510d9bc 000001ca
>>c04b10c8 ddf0d040 ddf0d07c 00000000 00000001
>>Nov  6 01:53:26 localhost kernel:        c0116edc ddf0d040 d56c8000
>>d5695a90 c011adfd ddf0d040 d56c8000 00000000
>>Nov  6 01:53:26 localhost kernel: Call Trace:
>>Nov  6 01:53:26 localhost kernel:  [remove_vma+39/58] remove_vma+0x27/0x3a
>>Nov  6 01:53:26 localhost kernel:  [exit_mmap+179/201] exit_mmap+0xb3/0xc9
>>Nov  6 01:53:26 localhost kernel:  [mmput+32/125] mmput+0x20/0x7d
>>Nov  6 01:53:26 localhost kernel:  [do_exit+371/901] do_exit+0x173/0x385
>>Nov  6 01:53:26 localhost kernel:  [sys_exit_group+0/17]
>>sys_exit_group+0x0/0x11
>>Nov  6 01:53:26 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>>Nov  6 01:53:26 localhost kernel: Code: 94 c0 84 c0 74 07 89 d0 e9 01 00
>>00 00 c3 55 57 56 89 c6 53 53 8b 40 08 89 04 24 8b 78 08 0f b7 46 1c 8b
>>6e 0c 83 e0 02 83 f8 01 <0f> b7 47 28 19 db 83 e3 08 83 c3 08 25 00 f0
>>00 00 89 da 81 ca
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>
>  
>

