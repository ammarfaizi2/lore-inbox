Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWBJUYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWBJUYH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWBJUYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:24:06 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:48312 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751376AbWBJUYF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:24:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Bk3o/D5LvINPJ36OVt0OcXUKZHm4TppkyTPp+IwMCm6QgJrpdXLarE5bb4eIh/waD1hguIoV4o+KVS5Tc0j06PmVjCr8aoFsTJW5Z4tcsS9T7wytU2h9Py64CL1XvhE2yNw8u1/nPumi9xNIAKhKxM4+us2E1oQNNSGN9T8KoXQ=
Message-ID: <a44ae5cd0602101224l63886192sec85a8771cf77ba9@mail.gmail.com>
Date: Fri, 10 Feb 2006 15:24:03 -0500
From: Miles Lane <miles.lane@gmail.com>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.16-rc2-mm1 - BUG: unable to handle kernel NULL pointer dereference at virtual address 0000003a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: unable to handle kernel NULL pointer dereference at virtual
address 0000003a
 printing eip:
0000003a
*pde = 00000000
Oops: 0000 [#1]
SMP
last sysfs file: /devices/pci0000:00/0000:00:02.2/usb3/idProduct
Modules linked in: sr_mod eth1394 snd_mpu401 8250_pnp snd_mpu401_uart
snd_rawmidi pcspkr ehci_hcd autofs4 vfat
 fat 3c59x mii forcedeth parport_pc parport 8250 serial_core ohci1394
ieee1394 ohci_hcd uhci_hcd usbcore conta
iner ide_cd cdrom ide_scsi
CPU:    0
EIP:    0060:[<0000003a>]    Not tainted VLI
EFLAGS: 00010286   (2.6.16-rc2-mm1 #9)
EIP is at 0x3a
eax: ffffff85   ebx: 00000000   ecx: 00000000   edx: 00000020
esi: 00020070   edi: 12000000   ebp: 00000000   esp: f6b60c70
ds: 007b   es: 007b   ss: 0068
Process cdrom_id (pid: 3482, threadinfo=f6b60000 task=f6b6f6f0)
Stack: <0>00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
       00000000 00000000 00000000 00000000 00000043 00000000 0000400c c04aaca4
       0000000c ffffff85 00000000 00000002 00000001 00007530 00000000 f64006ac
Call Trace:
 <c01038b9> show_stack_log_lvl+0xaa/0xb5   <c01039fd> show_registers+0x139/0x1a5
 <c0103cf6> die+0x162/0x1ef   <c01120e6> do_page_fault+0x389/0x4cc
 <c01032bf> error_code+0x4f/0x54
Code:  Bad EIP value.
 BUG: cdrom_id/3482, lock held at task exit time!
 [dfca557c] {init_once}
.. held by:          cdrom_id: 3482 [f6b6f6f0, 123]
... acquired at:               do_open+0x61/0x2f0
BUG: unable to handle kernel NULL pointer dereference at virtual
address 00000024
 printing eip:
00000024
*pde = 00000000
Oops: 0000 [#2]
SMP
last sysfs file: /devices/pci0000:00/0000:00:02.2/usb3/idProduct
Modules linked in: sr_mod eth1394 snd_mpu401 8250_pnp snd_mpu401_uart
snd_rawmidi pcspkr ehci_hcd autofs4 vfat
 fat 3c59x mii forcedeth parport_pc parport 8250 serial_core ohci1394
ieee1394 ohci_hcd uhci_hcd usbcore conta
iner ide_cd cdrom ide_scsi
CPU:    0
EIP:    0060:[<00000024>]    Not tainted VLI
EFLAGS: 00010286   (2.6.16-rc2-mm1 #9)
EIP is at 0x24
eax: fffffffb   ebx: 00000000   ecx: 00000000   edx: 00000020
esi: 00050070   edi: 0a000000   ebp: 00000000   esp: f6ba6c70
ds: 007b   es: 007b   ss: 0068
Process cdrom_id (pid: 3480, threadinfo=f6ba6000 task=f6b6ec30)
Stack: <0>00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
       00000000 00000000 00000000 00000000 00000043 00000000 0000400c c04aaa98
       0000000c 00000000 00000000 00000002 00000001 00007530 00000000 f6b2e968
Call Trace:
 <c01038b9> show_stack_log_lvl+0xaa/0xb5   <c01039fd> show_registers+0x139/0x1a5
 <c0103cf6> die+0x162/0x1ef   <c01120e6> do_page_fault+0x389/0x4cc
 <c01032bf> error_code+0x4f/0x54
Code:  Bad EIP value.
