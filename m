Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbVJ2ATF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVJ2ATF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVJ2ATE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:19:04 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:62875
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750903AbVJ2ATB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:19:01 -0400
Message-ID: <4362BFF1.3040304@linuxwireless.org>
Date: Fri, 28 Oct 2005 18:18:57 -0600
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, rml@novell.com
Subject: Kernel Badness 2.6.14-Git
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I just pulled from Linus Tree and I'm getting this badness in dmesg.

Please let me know if it is too soon to start reporting this. 2.6.14 is 
OK and does not output this.


ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
[drm] Initialized radeon 1.17.0 20050311 on minor 0:
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU] (supports 8 throttling states)
hdaps: IBM ThinkPad T42 detected.
hdaps: initial latch check good (0x01).
hdaps: device successfully initialized.
Badness in kref_get at lib/kref.c:32
 [<c026c3f1>] kref_get+0x26/0x2d
 [<c026bc45>] kobject_get+0x12/0x17
 [<c02c9e02>] class_device_get+0x13/0x1a
 [<c02c99bd>] class_device_add+0x5f/0x20a
 [<c02c98b3>] class_device_initialize+0x15/0x1d
 [<c02c9bf1>] class_device_create+0x73/0x95
 [<e1289c0c>] evdev_connect+0xc0/0xdd [evdev]
 [<c0324636>] input_register_device+0xe2/0x129
 [<e080b0c9>] hdaps_init+0xc9/0x146 [hdaps]
 [<e132e5ac>] hdaps_dmi_match_invert+0x0/0x21 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e5ac>] hdaps_dmi_match_invert+0x0/0x21 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e5ac>] hdaps_dmi_match_invert+0x0/0x21 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<c012e593>] sys_init_module+0xaa/0x1ac
 [<c0102bc5>] syscall_call+0x7/0xb
Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
c0180ba1
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: hdaps speedstep_centrino processor radeon pcmcia 
usbhid ipw2200 ieee80211 ieee80211_crypt yenta_socket rsrc_nonstatic 
e1000 pcmcia_core firmware_class i2c_i801 i810_audio ac97_codec 
irtty_sir soundcore i2c_core sir_dev intel_agp shpchp pci_hotplug irda 
ehci_hcd uhci_hcd rtc crc_ccitt pcspkr evdev mousedev unix
CPU:    0
EIP:    0060:[<c0180ba1>]    Not tainted VLI
EFLAGS: 00010286   (2.6.14)
EIP is at create_dir+0xd/0x172
eax: 00000000   ebx: dde13d88   ecx: dedfd7f0   edx: 00000000
esi: dde13d88   edi: e13307d4   ebp: de735c9c   esp: de735c74
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4012, threadinfo=de734000 task=dee85580)
Stack: dde13d88 dde13d88 dde13d88 e13307d4 dde13d88 c0180d7b dde13d88 
00000000
       dde13d8c de735c9c 00000000 00000000 c026b8f9 dde13d88 dde13d88 
de734000
       c026bad8 dde13d88 dde13d80 dde13df0 dde13df7 c02c99ef dde13d88 
c042b800
Call Trace:
 [<c0180d7b>] sysfs_create_dir+0x3e/0x59
 [<c026b8f9>] create_dir+0x13/0x33
 [<c026bad8>] kobject_add+0x83/0xa2
 [<c02c99ef>] class_device_add+0x91/0x20a
 [<c02c9bf1>] class_device_create+0x73/0x95
 [<e1289c0c>] evdev_connect+0xc0/0xdd [evdev]
 [<c0324636>] input_register_device+0xe2/0x129
 [<e080b0c9>] hdaps_init+0xc9/0x146 [hdaps]
 [<e132e5ac>] hdaps_dmi_match_invert+0x0/0x21 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e5ac>] hdaps_dmi_match_invert+0x0/0x21 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e5ac>] hdaps_dmi_match_invert+0x0/0x21 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<e132e593>] hdaps_dmi_match+0x0/0x19 [hdaps]
 [<c012e593>] sys_init_module+0xaa/0x1ac
 [<c0102bc5>] syscall_call+0x7/0xb
Code: d5 82 f9 ff e8 32 2e f8 ff 83 c4 10 ff 03 31 c0 89 5f 50 c7 47 48 
ec 3b 41 c0 5b 5e 5f c3 55 57 56 53 56 8b 44 24 1c 8b 6c 24 24 <8b> 50 
08 ff 4a 70 0f 88 b3 0a 00 00 31 c0 83 c9 ff 8b 7c 24 20
 <6>Non-volatile memory driver v1.3
Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
c0180ba1
*pde = 00000000
Oops: 0000 [#2]
PREEMPT
Modules linked in: joydev nvram hdaps speedstep_centrino processor 
radeon pcmcia usbhid ipw2200 ieee80211 ieee80211_crypt yenta_socket 
rsrc_nonstatic e1000 pcmcia_core firmware_class i2c_i801 i810_audio 
ac97_codec irtty_sir soundcore i2c_core sir_dev intel_agp shpchp 
pci_hotplug irda ehci_hcd uhci_hcd rtc crc_ccitt pcspkr evdev mousedev unix
CPU:    0
EIP:    0060:[<c0180ba1>]    Not tainted VLI
EFLAGS: 00010286   (2.6.14)
EIP is at create_dir+0xd/0x172
eax: 00000000   ebx: dde13b88   ecx: dde13ca4   edx: 00000000
esi: dde13b88   edi: e13307d4   ebp: de735ed8   esp: de735eb0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4045, threadinfo=de734000 task=dee85580)
Stack: dde13b88 dde13b88 dde13b88 e13307d4 dde13b88 c0180d7b dde13b88 
00000000
       dde13b8c de735ed8 00000000 00000000 c026b8f9 dde13b88 dde13b88 
de734000
       c026bad8 dde13b88 dde13b80 dde13bf0 dde13bf4 c02c99ef dde13b88 
c042b800
Call Trace:
 [<c0180d7b>] sysfs_create_dir+0x3e/0x59
 [<c026b8f9>] create_dir+0x13/0x33
 [<c026bad8>] kobject_add+0x83/0xa2
 [<c02c99ef>] class_device_add+0x91/0x20a
 [<c02c9bf1>] class_device_create+0x73/0x95
 [<e13f4ca1>] joydev_connect+0x27a/0x297 [joydev]
 [<c03247d1>] input_register_handler+0x75/0xc8
 [<e134600a>] joydev_init+0xa/0xe [joydev]
 [<c012e593>] sys_init_module+0xaa/0x1ac
 [<c0102bc5>] syscall_call+0x7/0xb
Code: d5 82 f9 ff e8 32 2e f8 ff 83 c4 10 ff 03 31 c0 89 5f 50 c7 47 48 
ec 3b 41 c0 5b 5e 5f c3 55 57 56 53 56 8b 44 24 1c 8b 6c 24 24 <8b> 50 
08 ff 4a 70 0f 88 b3 0a 00 00 31 c0 83 c9 ff 8b 7c 24 20
 <6>ibm_acpi: IBM ThinkPad ACPI Extras v0.11
ibm_acpi: http://ibm-acpi.sf.net/
ibm_acpi: dock device not present
kjournald starting.  Commit interval 5 seconds

