Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbVCWX45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbVCWX45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVCWX44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:56:56 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:51403 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262964AbVCWXxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:53:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=KIxsh7Q2sFgmTiYKe6O6nTnnp/ZdyvlfxPJ8ErxsDKpuycT8AReCAXIfG3Jm1n1cQp/XJtemfkTperc+s83nnQD04eV41ziJ65IS2cIYgs5Bghhkf/eflCoaRKWPuYoXafUktHcTr+TmP6QNQipvDuNkydXToGNiqu8edtfeJy0=
Message-ID: <d9def9db0503231553405b6f5b@mail.gmail.com>
Date: Thu, 24 Mar 2005 00:53:14 +0100
From: Rechberger Markus <mrechberger@gmail.com>
Reply-To: Rechberger Markus <mrechberger@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Ooops: 0000 [#1] PIONEER DVD-RW DVR-K12RA
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just got that message when I tried to mount a cd

Kernel: 2.6.11.5

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA
Storage Controller (rev 03)


ATAPI CD-ROM, with removable media
        Model Number:       PIONEER DVD-RW DVR-K12RA                
        Serial Number:      DBDL085110WL       
        Firmware Revision:  1.10    
Standards:
        Likely used CD-ROM ATAPI-1
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 64.0kB
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    DEVICE RESET cmd
           *    PACKET command feature set
           *    Power Management feature set
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper



Oops: 0000 [#1]
PREEMPT 
Modules linked in: isofs ext3 jbd md5 ipv6 pcmcia joydev evdev
yenta_socket rsrc_nonstatic pcmcia_core sd_mod snd_intel8x0m 8250_pci
8250 serial_core snd_intel8x0 snd_ac97_codec hw_random usb_storage
usb_midi snd_usb_audio snd_pcm snd_timer snd_page_alloc snd_usb_lib
snd_rawmidi snd eth1394 ehci_hcd uhci_hcd b44 mii ohci1394 dm_mod sg
audio sr_mod cdrom usbcore soundcore ide_scsi sbp2 scsi_mod ieee1394
rtc unix
CPU:    0
EIP:    0060:[<c01ad0c6>]    Not tainted VLI
EFLAGS: 00010246   (2.6.11.5) 
EIP is at get_kobj_path_length+0x26/0x40
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: ddc3414c
esi: 00000001   edi: 00000000   ebp: ffffffff   esp: cd89bdd4
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 5066, threadinfo=cd89a000 task=cd0595a0)
Stack: d5666e00 c1430580 ffffffea ddc3414c c01ad15f ddc3414c 00000282 00000020 
       d26f94b4 d5666e00 c1430580 ffffffea 00000000 c01adb98 ddc3414c 000000d0 
       00000020 00000064 fffffff4 d5666e00 c1430580 ffffffea cd915000 c01adca8 
Call Trace:
 [<c01ad15f>] kobject_get_path+0x1f/0x80
 [<c01adb98>] do_kobject_uevent+0x28/0x110
 [<c01adca8>] kobject_uevent+0x28/0x30
 [<c015bade>] bdev_uevent+0x2e/0x50
 [<c015bc76>] kill_block_super+0x26/0x60
 [<c015ad9e>] deactivate_super+0x6e/0xa0
 [<c015bc21>] get_sb_bdev+0x121/0x150
 [<c0172050>] alloc_vfsmnt+0x90/0xd0
 [<dec43fc0>] isofs_get_sb+0x30/0x40 [isofs]
 [<dec42cc0>] isofs_fill_super+0x0/0x6d0 [isofs]
 [<c015be67>] do_kern_mount+0x57/0xe0
 [<c017332c>] do_new_mount+0x9c/0xe0
 [<c0173a47>] do_mount+0x157/0x1b0
 [<c0173893>] copy_mount_options+0x63/0xc0
 [<c0173e3f>] sys_mount+0x9f/0xe0
 [<c01031af>] syscall_call+0x7/0xb
Code: 90 8d 74 26 00 55 bd ff ff ff ff 57 56 be 01 00 00 00 53 8b 54
24 14 31 db 8d b6 00 00 00 00 8d bf 00 00 00 00 8b 3a 89 e9 89 d8 <f2>
ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 ea 5b 89 f0 5e 5f

Markus
