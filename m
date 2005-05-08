Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVEHNRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVEHNRn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 09:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbVEHNRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 09:17:43 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:52427 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262861AbVEHNRi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 09:17:38 -0400
Message-ID: <427E116D.4080709@tiscali.de>
Date: Sun, 08 May 2005 15:17:33 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Usb-Storage OOPS
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this when plugging out and plugging in my digicam.

Matthias-Christian Ott

--

usb 2-1: new full speed USB device using uhci_hcd and address 3
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usb 2-1: reset full speed USB device using uhci_hcd and address 3
   Vendor: Digital   Model: Camera            Rev: 1.00
   Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 124160 512-byte hdwr sectors (64 MB)
sda: Write Protect is off
sda: Mode Sense: 00 06 00 00
sda: assuming drive cache: write through
SCSI device sda: 124160 512-byte hdwr sectors (64 MB)
sda: Write Protect is off
sda: Mode Sense: 00 06 00 00
sda: assuming drive cache: write through
  /dev/scsi/host1/bus0/target0/lun0: p1
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
usb-storage: device scan complete
usb 2-1: USB disconnect, address 3
usb 2-1: new full speed USB device using uhci_hcd and address 4
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
usb 2-1: USB disconnect, address 4
scsi: Device offlined - not ready after error recovery: host 2 channel 0 
id 0 lun 0
usb-storage: device scan complete
Unable to handle kernel NULL pointer dereference at virtual address 00000050
  printing eip:
c019b4ef
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: nls_cp437 vfat fat usb_storage ipt_state iptable_filter 
ip_tables ohci_hcd ehci_hcd snd_cs4231_lib snd_mpu401 analog ns558 
parport_pc parport pcspkr eth1394 snd_cmipci gameport snd_opl3_lib 
snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device ohci1394 ieee1394 
nvidia i2c_i801 i2c_core usbhid uhci_hcd pci_hotplug tsdev evdev 
p4_clockmod speedstep_lib freq_table ip_conntrack_ftp ip_conntrack 
snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore 
ndiswrapper 8139too mii usbserial usbcore rtc
CPU:    0
EIP:    0060:[<c019b4ef>]    Tainted: P      VLI
EFLAGS: 00010292   (2.6.12-rc3-mm2-ott)
EIP is at sysfs_hash_and_remove+0xb/0x10d
eax: 00000000   ebx: d5a482d0   ecx: 00000003   edx: c05bf63c
esi: d5a482c8   edi: d5a48198   ebp: c05bf5c0   esp: d6afde08
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 1229, threadinfo=d6afc000 task=d7386030)
Stack: 00000003 00000001 00000000 d5a482d0 d5a482c8 d5a48198 c05bf5c0 c039064a
        00000000 c0524989 c05bf63c d5a482c8 c144e3f8 c144e438 cc1bc800 
c03906bb
        d5a482c8 d5a48000 c03dc06c d5a482c8 00000003 d5a48000 c144e3f8 
c144e400
Call Trace:
  [<c039064a>] class_device_del+0x83/0xe4
  [<c03906bb>] class_device_unregister+0x10/0x1d
  [<c03dc06c>] scsi_remove_device+0x4b/0x94
  [<c03dc138>] __scsi_remove_target+0x83/0xbf
  [<c03db217>] scsi_forget_host+0x3f/0x67
  [<c03d44c6>] scsi_remove_host+0x11/0x64
  [<c04d1143>] __down_failed+0x7/0xc
  [<d9432a24>] storage_disconnect+0x5c/0x7a [usb_storage]
  [<d91870b4>] usb_unbind_interface+0x41/0x7d [usbcore]
  [<c038f915>] device_release_driver+0x75/0x91
  [<c038f1f0>] bus_remove_device+0x6a/0x82
  [<c038e62d>] device_del+0x31/0x6c
  [<d918f1be>] usb_disable_device+0xa7/0x11d [usbcore]
  [<d91893eb>] usb_disconnect+0xaa/0x13d [usbcore]
  [<d918ac6c>] hub_port_connect_change+0x57/0x422 [usbcore]
  [<d91880e7>] clear_port_feature+0x57/0x5b [usbcore]
  [<d918b339>] hub_events+0x302/0x48b [usbcore]
  [<d918b511>] hub_thread+0x4f/0x116 [usbcore]
  [<c0134302>] autoremove_wake_function+0x0/0x4b
  [<d918b4c2>] hub_thread+0x0/0x116 [usbcore]
  [<c0101151>] kernel_thread_helper+0x5/0xb
Code: 7d 33 00 89 5c 24 18 8b 47 10 89 44 24 14 83 c4 04 5b 5e 5f e9 d7 52 
fe ff 83 c4 04 5b 5e 5f c3 55 57 56 53 83 ec 0c 8b 44 24 20 <8b> 50 50 8b 
48 10 f0 ff 49 78 0f 88 f2 00 00 00 8b 42 0c 8d 68
