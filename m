Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWKIT13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWKIT13 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754832AbWKIT13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:27:29 -0500
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:28851 "EHLO
	aa012msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1754829AbWKIT11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:27:27 -0500
Date: Thu, 9 Nov 2006 20:26:59 +0100
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: Benoit Boissinot <bboissin@gmail.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.19-rc5-mm1
Message-ID: <20061109192658.GA2560@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Benoit Boissinot <bboissin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20061108015452.a2bb40d2.akpm@osdl.org> <40f323d00611091043g407231e2nfcd7ed3fc06e711a@mail.gmail.com> <20061109110453.4d2195dc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109110453.4d2195dc.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.19-rc5-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 11:04:53AM -0800, Andrew Morton wrote:
> 
> (added linux-scsi)
[...]
> > [27526.232000] EIP: [<e8074e26>]
> > scsi_device_dev_release_usercontext+0x36/0x100 [scsi_mod] SS:ESP
> > 0068:dfdb1e3c
> > 
> > full dmesg attached, I can test patches and provide any useful
> > information if needed (just not now because the dock is at work).
> 
> You're the second or third person to report this (to no effect, btw). 

oh, great. I was going to report the same (had with usb key unplug).
Linux version 2.6.19-rc5-mm1-1 (mattia@tadamune) (gcc version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)) #4 SMP Wed Nov 8 22:46:11 CET 2006
...
usb 5-1: new high speed USB device using ehci_hcd and address 8
usb 5-1: new device found, idVendor=0c76, idProduct=0005
usb 5-1: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 5-1: Product: FlashDisk       
usb 5-1: Manufacturer: USBDisk 
usb 5-1: SerialNumber: 0608120154580
usb 5-1: configuration #1 chosen from 1 choice
scsi3 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 8
usb-storage: waiting for device to settle before scanning
scsi 3:0:0:0: Direct-Access     USBDisk  FlashDisk        1.00 PQ: 0 ANSI: 2
SCSI device sdc: 2002000 512-byte hdwr sectors (1025 MB)
sdc: Write Protect is off
sdc: Mode Sense: 0b 00 00 08
sdc: assuming drive cache: write through
SCSI device sdc: 2002000 512-byte hdwr sectors (1025 MB)
sdc: Write Protect is off
sdc: Mode Sense: 0b 00 00 08
sdc: assuming drive cache: write through
 sdc: sdc1
sd 3:0:0:0: Attached scsi removable disk sdc
usb-storage: device scan complete
usb 5-1: USB disconnect, address 8
BUG: unable to handle kernel paging request at virtual address 00100104
 printing eip:
c024831f
*pde = 00000000
Oops: 0002 [#1]
SMP 
last sysfs file: /devices/pci0000:00/0000:00:1d.7/usb5/5-1/idVendor
Modules linked in: ipv6 cpufreq_ondemand acpi_cpufreq freq_table thermal fan button processor ac battery ipt_MASQUERADE iptable_nat ip_nat xt_tcpudp xt_state ip_conntrack nfnetlink iptable_filter ip_tables x_tables usbhid hci_usb bluetooth dm_snapshot dm_mirror dm_mod sbp2 loop eth1394 usb_storage pcmcia snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss ipw3945 tpm_infineon tpm ieee80211 ieee80211_crypt yenta_socket i2c_i801 ide_cd ohci1394 firmware_class intel_agp agpgart tpm_bios pcspkr ehci_hcd evdev sky2 ieee1394 uhci_hcd rsrc_nonstatic tifm_7xx1 tifm_core snd_pcm rtc psmouse pcmcia_core snd_timer usbcore snd soundcore snd_page_alloc cdrom
CPU:    0
EIP:    0060:[<c024831f>]    Not tainted VLI
EFLAGS: 00010002   (2.6.19-rc5-mm1-1 #4)
EIP is at scsi_device_dev_release_usercontext+0x41/0xfa
eax: 00200200   ebx: f7824094   ecx: 00100100   edx: 00000286
esi: f7824008   edi: f7824000   ebp: f78bddc0   esp: f78bddb0
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 756, ti=f78bc000 task=c1990a70 task.ti=f78bc000)
Stack: f7f05014 f7824284 c02482de c032e6e0 f78bddd0 c012d897 f782410c c032e748 
       f78bddd8 c024754d f78bddf0 c022f74d c01d1b6e f782410c c032e748 c032e6e0 
       f78bde08 c01d1b54 f7f0508c f7824124 c01d1b74 00000246 f78bde10 c01d1b7f 
Call Trace:
 [<c012d897>] execute_in_process_context+0x1d/0x4e
 [<c024754d>] scsi_device_dev_release+0x15/0x17
 [<c022f74d>] device_release+0x29/0x6b
 [<c01d1b54>] kobject_cleanup+0x46/0x66
 [<c01d1b7f>] kobject_release+0xb/0xd
 [<c01d263b>] kref_put+0x7f/0x90
 [<c01d1b0c>] kobject_put+0x14/0x16
 [<c022f829>] put_device+0xf/0x11
 [<c0247c49>] __scsi_remove_device+0x5e/0x62
 [<c02458cc>] scsi_forget_host+0x30/0x4f
 [<c02410c5>] scsi_remove_host+0x6a/0xdd
 [<f8e3f6c7>] quiesce_and_remove_host+0x8f/0x94 [usb_storage]
 [<f8e3f789>] storage_disconnect+0x11/0x1b [usb_storage]
 [<f8d338c2>] usb_unbind_interface+0x4c/0x94 [usbcore]
 [<c02314c7>] __device_release_driver+0x71/0x86
 [<c0231895>] device_release_driver+0x26/0x3d
 [<c0230f29>] bus_remove_device+0x5e/0x6c
 [<c022fbd2>] device_del+0x104/0x15a
 [<f8d314a8>] usb_disable_device+0x5f/0xbc [usbcore]
 [<f8d2e1be>] usb_disconnect+0x8b/0xe7 [usbcore]
 [<f8d2edd5>] hub_thread+0x397/0xa50 [usbcore]
 [<c01307e2>] kthread+0xb5/0xdf
 [<c0103a0f>] kernel_thread_helper+0x7/0x10
DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
Leftover inexact backtrace:
 [<c0103ee9>] show_trace_log_lvl+0x1a/0x2f
 [<c0103f9b>] show_stack_log_lvl+0x9d/0xa5
 [<c0104168>] show_registers+0x1c5/0x29b
 [<c0104354>] die+0x116/0x22e
 [<c0117c57>] do_page_fault+0x446/0x51f
 [<c02c5a4c>] error_code+0x7c/0x84
 [<c012d897>] execute_in_process_context+0x1d/0x4e
 [<c024754d>] scsi_device_dev_release+0x15/0x17
 [<c022f74d>] device_release+0x29/0x6b
 [<c01d1b54>] kobject_cleanup+0x46/0x66
 [<c01d1b7f>] kobject_release+0xb/0xd
 [<c01d263b>] kref_put+0x7f/0x90
 [<c01d1b0c>] kobject_put+0x14/0x16
 [<c022f829>] put_device+0xf/0x11
 [<c0247c49>] __scsi_remove_device+0x5e/0x62
 [<c02458cc>] scsi_forget_host+0x30/0x4f
 [<c02410c5>] scsi_remove_host+0x6a/0xdd
 [<f8e3f6c7>] quiesce_and_remove_host+0x8f/0x94 [usb_storage]
 [<f8e3f789>] storage_disconnect+0x11/0x1b [usb_storage]
 [<f8d338c2>] usb_unbind_interface+0x4c/0x94 [usbcore]
 [<c02314c7>] __device_release_driver+0x71/0x86
 [<c0231895>] device_release_driver+0x26/0x3d
 [<c0230f29>] bus_remove_device+0x5e/0x6c
 [<c022fbd2>] device_del+0x104/0x15a
 [<f8d314a8>] usb_disable_device+0x5f/0xbc [usbcore]
 [<f8d2e1be>] usb_disconnect+0x8b/0xe7 [usbcore]
 [<f8d2edd5>] hub_thread+0x397/0xa50 [usbcore]
 [<c01307e2>] kthread+0xb5/0xdf
 [<c0103a0f>] kernel_thread_helper+0x7/0x10
 =======================
Code: f0 89 c6 8b 83 6c ff ff ff 83 ee 14 8b 40 2c e8 b5 d4 07 00 ff 86 70 01 00 00 8d b3 74 ff ff ff 8b 8b 74 ff ff ff 89 c2 8b 46 04 <89> 41 04 89 08 c7 46 04 00 02 20 00 8d b3 7c ff ff ff 8b 8b 7c 
EIP: [<c024831f>] scsi_device_dev_release_usercontext+0x41/0xfa SS:ESP 0068:f78bddb0
 

> Other reports have been with USB-unplug, so I doubt if the docking code is
> involved.

full dmesg is here:
http://oioio.altervista.org/linux/dmesg_usbkey_remove
and .config:
http://oioio.altervista.org/linux/config-2.6.19-rc5-mm1-1

-- 
mattia
:wq!
