Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269299AbUJQVz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269299AbUJQVz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 17:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269310AbUJQVz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 17:55:57 -0400
Received: from mid-2.inet.it ([213.92.5.19]:59882 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S269299AbUJQVzr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 17:55:47 -0400
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: linux-kernel@vger.kernel.org
Subject: USB storage oops 2.6.9-rc4-mm1
Date: Sun, 17 Oct 2004 23:55:30 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200410172355.30812.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following oops when I insert a USB storage device (512 Mb stick) on 
i875p system, kernel 2.6.9-rc4-mm1 with optimize-profile-path-slightly.patch 
reverted.

=======================================================
Oct 17 23:37:29 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 1 status 
001803 POWER sig=j  CSC CONNECT
Oct 17 23:37:29 kefk kernel: hub 5-0:1.0: port 1, status 0501, change 0001, 
480 Mb/s
Oct 17 23:37:29 kefk kernel: hub 5-0:1.0: debounce: port 1: total 100ms stable 
100ms status 0x501
Oct 17 23:37:29 kefk kernel: hub 5-0:1.0: port 1 not reset yet, waiting 50ms
Oct 17 23:37:29 kefk kernel: ehci_hcd 0000:00:1d.7: port 1 high speed
Oct 17 23:37:29 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 1 status 
001005 POWER sig=se0  PE CONNECT
Oct 17 23:37:29 kefk kernel: usb 5-1: new high speed USB device using address 
4
Oct 17 23:37:29 kefk kernel: usb 5-1: new device strings: Mfr=1, Product=2, 
SerialNumber=3
Oct 17 23:37:29 kefk kernel: usb 5-1: default language 0x0409
Oct 17 23:37:29 kefk kernel: usb 5-1: Product: Mass storage
Oct 17 23:37:29 kefk kernel: usb 5-1: Manufacturer: USB
Oct 17 23:37:29 kefk kernel: usb 5-1: SerialNumber: 142E19413C2FCA34
Oct 17 23:37:29 kefk kernel: usb 5-1: hotplug
Oct 17 23:37:29 kefk kernel: usb 5-1: adding 5-1:1.0 (config #1, interface 0)
Oct 17 23:37:29 kefk kernel: usb 5-1:1.0: hotplug
Oct 17 23:37:29 kefk kernel: Initializing USB Mass Storage driver...
Oct 17 23:37:29 kefk kernel: usb-storage 5-1:1.0: usb_probe_interface
Oct 17 23:37:29 kefk kernel: usb-storage 5-1:1.0: usb_probe_interface - got id
Oct 17 23:37:29 kefk kernel: scsi3 : SCSI emulation for USB Mass Storage 
devices
Oct 17 23:37:29 kefk kernel: usbcore: registered new driver usb-storage
Oct 17 23:37:29 kefk kernel: USB Mass Storage support registered.
Oct 17 23:37:29 kefk kernel: usb-storage: device found at 4
Oct 17 23:37:29 kefk kernel: usb-storage: waiting for device to settle before 
scanning
Oct 17 23:37:34 kefk kernel:   Vendor: 512MB     Model: USB2.0FlashDrive  Rev: 
2.00
Oct 17 23:37:34 kefk kernel:   Type:   Direct-Access                      ANSI 
SCSI revision: 02
Oct 17 23:37:34 kefk kernel: sdb: Unit Not Ready, sense:
Oct 17 23:37:34 kefk kernel: Current : sense = 70  6
Oct 17 23:37:34 kefk kernel: ASC=28 ASCQ= 0
Oct 17 23:37:34 kefk kernel: Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 
0x0a 0x00 0x00 0x00 0x00 0x28 0x00 0x00 0x00 0x00 0x00
Oct 17 23:37:34 kefk kernel: sdb : READ CAPACITY failed.
Oct 17 23:37:34 kefk kernel: sdb : status=1, message=00, host=0, driver=08
Oct 17 23:37:34 kefk kernel: Current sd: sense = 70  6
Oct 17 23:37:34 kefk kernel: ASC=28 ASCQ= 0
Oct 17 23:37:34 kefk kernel: Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 
0x0a 0x00 0x00 0x00 0x00 0x28 0x00 0x00 0x00 0x00 0x00
Oct 17 23:37:34 kefk kernel: sdb: assuming Write Enabled
Oct 17 23:37:34 kefk kernel: sdb: assuming drive cache: write through
Oct 17 23:37:34 kefk kernel: sdb: Unit Not Ready, sense:
Oct 17 23:37:34 kefk kernel: Current : sense = 70  6
Oct 17 23:37:34 kefk kernel: ASC=28 ASCQ= 0
Oct 17 23:37:34 kefk kernel: Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 
0x0a 0x00 0x00 0x00 0x00 0x28 0x00 0x00 0x00 0x00 0x00
Oct 17 23:37:34 kefk kernel: SCSI device sdb: 1024000 512-byte hdwr sectors 
(524 MB)
Oct 17 23:37:34 kefk kernel: sdb: assuming Write Enabled
Oct 17 23:37:34 kefk kernel: sdb: assuming drive cache: write through
Oct 17 23:37:34 kefk kernel: SCSI device sdb: 1024000 512-byte hdwr sectors 
(524 MB)
Oct 17 23:37:34 kefk kernel: sdb: assuming Write Enabled
Oct 17 23:37:34 kefk kernel: sdb: assuming drive cache: write through
Oct 17 23:37:34 kefk kernel:  sdb: sdb1
Oct 17 23:37:34 kefk kernel:  sdb: sdb1
Oct 17 23:37:34 kefk kernel: kobject_register failed for sdb1 (-17)
Oct 17 23:37:34 kefk kernel:  [<c01f25e0>] kobject_register+0x51/0x5f
Oct 17 23:37:34 kefk kernel:  [<c0184898>] add_partition+0xbb/0xf0
Oct 17 23:37:34 kefk kernel:  [<c0184a10>] register_disk+0xee/0x11d
Oct 17 23:37:34 kefk kernel:  [<c024bb36>] add_disk+0x36/0x41
Oct 17 23:37:34 kefk kernel:  [<c024baec>] exact_match+0x0/0x7
Oct 17 23:37:34 kefk kernel:  [<c024baf3>] exact_lock+0x0/0xd
Oct 17 23:37:34 kefk kernel:  [<c028bf92>] sd_probe+0x224/0x32f
Oct 17 23:37:34 kefk kernel:  [<c0311dce>] _spin_lock+0x1a/0x6e
Oct 17 23:37:34 kefk kernel:  [<c0243680>] bus_match+0x32/0x6a
Oct 17 23:37:34 kefk kernel:  [<c02436fe>] device_attach+0x46/0xaa
Oct 17 23:37:34 kefk kernel:  [<c0168ce2>] dput+0x76/0x209
Oct 17 23:37:34 kefk kernel:  [<c02439ae>] bus_add_device+0x55/0x97
Oct 17 23:37:34 kefk kernel:  [<c0242a4d>] device_add+0x9c/0x128
Oct 17 23:37:34 kefk kernel:  [<c026a6e2>] scsi_sysfs_add_sdev+0xa0/0x309
Oct 17 23:37:34 kefk kernel:  [<c02692ac>] scsi_add_lun+0x2d9/0x32f
Oct 17 23:37:34 kefk kernel:  [<c02693bf>] scsi_probe_and_add_lun+0xbd/0x1a9
Oct 17 23:37:34 kefk kernel:  [<c0269b4d>] scsi_scan_target+0x9a/0x106
Oct 17 23:37:34 kefk kernel:  [<c0269c35>] scsi_scan_channel+0x7c/0x9a
Oct 17 23:37:34 kefk kernel:  [<c0269ccc>] scsi_scan_host_selected+0x79/0xd8
Oct 17 23:37:34 kefk kernel:  [<c0269d4c>] scsi_scan_host+0x21/0x25
Oct 17 23:37:34 kefk kernel:  [<f8c5187a>] usb_stor_scan_thread+0x134/0x145 
[usb_storage]
Oct 17 23:37:34 kefk kernel:  [<c012d901>] autoremove_wake_function+0x0/0x43
Oct 17 23:37:34 kefk kernel:  [<c0103d1a>] ret_from_fork+0x6/0x14
Oct 17 23:37:34 kefk kernel:  [<c012d901>] autoremove_wake_function+0x0/0x43
Oct 17 23:37:34 kefk kernel:  [<f8c51746>] usb_stor_scan_thread+0x0/0x145 
[usb_storage]
Oct 17 23:37:34 kefk kernel:  [<c0102035>] kernel_thread_helper+0x5/0xb
Oct 17 23:37:34 kefk kernel: Attached scsi removable disk sdb at scsi3, 
channel 0, id 0, lun 0
Oct 17 23:37:34 kefk kernel: Attached scsi generic sg4 at scsi3, channel 0, id 
0, lun 0,  type 0
Oct 17 23:37:34 kefk kernel: usb-storage: device scan complete
Oct 17 23:37:35 kefk scsi.agent[6870]: disk 
at /devices/pci0000:00/0000:00:1d.7/usb5/5-1/5-1:1.0/host3/target3:0:0/3:0:0:0
==========================================================

After that I can create by hand sdb1 block device, and then access the pen 
drive. But If I umount sdb1 device and pull out the pen, syslogs report this:


===========================================================
Oct 17 23:47:34 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 1 status 
001002 POWER sig=se0  CSC
Oct 17 23:47:34 kefk kernel: hub 5-0:1.0: port 1, status 0100, change 0001, 12 
Mb/s
Oct 17 23:47:34 kefk kernel: usb 5-1: USB disconnect, address 4
Oct 17 23:47:34 kefk kernel: usb 5-1: usb_disable_device nuking all URBs
Oct 17 23:47:34 kefk kernel: usb 5-1: unregistering interface 5-1:1.0
Oct 17 23:47:34 kefk kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000050
Oct 17 23:47:34 kefk kernel:  printing eip:
Oct 17 23:47:34 kefk kernel: c018654b
Oct 17 23:47:34 kefk kernel: *pde = 00000000
Oct 17 23:47:34 kefk kernel: Oops: 0000 [#1]
Oct 17 23:47:34 kefk kernel: PREEMPT SMP
Oct 17 23:47:34 kefk kernel: Modules linked in: nls_cp437 usb_storage 
snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
snd_seq_midi_emul nvidia
 tun md5 ipv6 rfcomm l2cap bluetooth snd_seq_oss snd_seq_midi_event snd_seq 
snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_seq_device 
snd_ac97_codec
snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore 
ipt_REJECT iptable_filter ip_tables loop nls_utf8 ide_cd i2c_dev w83781d 
i2c_sensor i2
c_isa i2c_i801 isofs zlib_inflate e1000 parport_pc ppa parport usblp ehci_hcd 
uhci_hcd genrtc
Oct 17 23:47:34 kefk kernel: CPU:    1
Oct 17 23:47:34 kefk kernel: EIP:    0060:[<c018654b>]    Tainted: P      VLI
Oct 17 23:47:34 kefk kernel: EFLAGS: 00010246   (2.6.9-rc4-mm1)
Oct 17 23:47:34 kefk kernel: EIP is at sysfs_remove_dir+0x1d/0xef
Oct 17 23:47:34 kefk kernel: eax: d7e9c208   ebx: d7e9c208   ecx: c1991cf4   
edx: c1000000
Oct 17 23:47:34 kefk kernel: esi: e2883a40   edi: 00000000   ebp: f613d594   
esp: c1991de4
Oct 17 23:47:34 kefk kernel: ds: 007b   es: 007b   ss: 0068
Oct 17 23:47:34 kefk kernel: Process khubd (pid: 125, threadinfo=c1991000 
task=c198a530)
Oct 17 23:47:34 kefk kernel: Stack: 00000001 d7e9c208 e2883a40 00000001 
f613d594 c01f26f0 d7e9c208 c01f2700
Oct 17 23:47:34 kefk kernel:        ee9ed080 c0184c18 f613d594 e2883a40 
e86b3400 f613d594 c028c0b4 f613d594
Oct 17 23:47:34 kefk kernel:        c03af724 c024383d f613d594 e2ec5c04 
c0243a43 f613d594 e2ec5c04 c0242b5e
Oct 17 23:47:34 kefk kernel: Call Trace:
Oct 17 23:47:34 kefk kernel:  [<c01f26f0>] kobject_del+0x14/0x1c
Oct 17 23:47:34 kefk kernel:  [<c01f2700>] kobject_unregister+0x8/0x10
Oct 17 23:47:34 kefk kernel:  [<c0184c18>] del_gendisk+0x1d/0xd5
Oct 17 23:47:34 kefk kernel:  [<c028c0b4>] sd_remove+0x17/0x5b
Oct 17 23:47:34 kefk kernel:  [<c024383d>] device_release_driver+0x56/0x58
Oct 17 23:47:34 kefk kernel:  [<c0243a43>] bus_remove_device+0x53/0x90
Oct 17 23:47:34 kefk kernel:  [<c0242b5e>] device_del+0x54/0x91
Oct 17 23:47:34 kefk kernel:  [<c026a9a0>] scsi_remove_device+0x55/0xa6
Oct 17 23:47:34 kefk kernel:  [<c0269d7d>] scsi_forget_host+0x2d/0x4f
Oct 17 23:47:34 kefk kernel:  [<c0263fe7>] scsi_remove_host+0x8/0x59
Oct 17 23:47:34 kefk kernel:  [<f8c51b25>] storage_disconnect+0x7d/0x8f 
[usb_storage]
Oct 17 23:47:34 kefk kernel:  [<c0297e95>] usb_unbind_interface+0x5e/0x60
Oct 17 23:47:34 kefk kernel:  [<c024383d>] device_release_driver+0x56/0x58
Oct 17 23:47:34 kefk kernel:  [<c0243a43>] bus_remove_device+0x53/0x90
Oct 17 23:47:34 kefk kernel:  [<c0242b5e>] device_del+0x54/0x91
Oct 17 23:47:34 kefk kernel:  [<c029f939>] usb_disable_device+0xda/0x147
Oct 17 23:47:34 kefk kernel:  [<c029a66d>] usb_disconnect+0xab/0x198
Oct 17 23:47:34 kefk kernel:  [<c029b923>] hub_port_connect_change+0x2ce/0x47b
Oct 17 23:47:34 kefk kernel:  [<c029bda4>] hub_events+0x2d4/0x4ac
Oct 17 23:47:34 kefk kernel:  [<c029bfb1>] hub_thread+0x35/0x10e
Oct 17 23:47:34 kefk kernel:  [<c0115142>] finish_task_switch+0x38/0x84
Oct 17 23:47:34 kefk kernel:  [<c012d901>] autoremove_wake_function+0x0/0x43
Oct 17 23:47:34 kefk kernel:  [<c0103d1a>] ret_from_fork+0x6/0x14
Oct 17 23:47:34 kefk kernel:  [<c012d901>] autoremove_wake_function+0x0/0x43
Oct 17 23:47:34 kefk kernel:  [<c029bf7c>] hub_thread+0x0/0x10e
Oct 17 23:47:34 kefk kernel:  [<c0102035>] kernel_thread_helper+0x5/0xb
Oct 17 23:47:34 kefk kernel: Code: 55 3c 32 c0 e9 4d ff ff ff e9 23 ff ff ff 
55 57 56 53 83 ec 04 8b 78 30 85 ff 74 0d 8b 07 85 c0 0f 84 ca 00 00 00 f0 ff 
0
7 85 ff <8b> 57 50 0f 84 b4 00 00 00 8b 47 10 8d 48 78 f0 ff 48 78 0f 88
=========================================================

>From this point on any insertion of usb devices simply goes ignored.
If further details are needed, please let me know.



-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
