Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWDSK6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWDSK6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 06:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWDSK6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 06:58:34 -0400
Received: from mail2-new.vianetworks.nl ([212.61.9.29]:60688 "EHLO
	mail2-new.vianetworks.nl") by vger.kernel.org with ESMTP
	id S1750851AbWDSK6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 06:58:34 -0400
Message-ID: <444617D3.4090906@vianetworks.nl>
Date: Wed, 19 Apr 2006 12:58:27 +0200
From: Axel Scheepers <ascheepers@vianetworks.nl>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops at reboot/shutdown in device_shutdown
References: <4444F060.1090503@vianetworks.nl> <9a8748490604180812i7368fdd3w9e345165d886239@mail.gmail.com>
In-Reply-To: <9a8748490604180812i7368fdd3w9e345165d886239@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------090007030504070607000106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090007030504070607000106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jesper Juhl wrote:
> Please post those panic messages (complete ones).
> It's hard to help you and/or track down the problem without them.
> 
> Please also read the REPORTING-BUGS document in the kernel source for
> more info that it is usually good to provide. The more detailed info
> from you, the greater the chance that someone will find and fix the
> bug.

Hi Jesper and list,

I've managed to transcribe the oops from the console which I've
attached. The output of ver_linux:

axel@grace:/usr/src/linux$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux grace 2.6.16.7.20060418.pm #1 Tue Apr 18 15:15:29 CEST 2006 i686
GNU/Linux
Gnu C                  4.0.3
Gnu make               3.81rc2
binutils               2.16.91
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39-WIP
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.7.14
pcmcia-cs              3.2.8
nfs-utils              1.0.7
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.94
Modules Loaded         radeon drm rfcomm l2cap sd_mod scsi_mod ipv6
pcmcia firmware_class af_packet yenta_socket rsrc_nonstatic pcmcia_core
8250_pci 8250 serial_core snd_intel8x0 snd_ac97_codec snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc
intel_agp agpgart ehci_hcd hci_usb bluetooth usbhid uhci_hcd usbcore
ide_cd cdrom rtc joydev unix

I should note that I've build the .broken kernel with both gcc-4.1 and
4.0.3 as mentioned above. (I've build gcc-4.1 in ~/gcc41/bin).

The last kernel which worked fine on this laptop is 2.6.15.4 after that
I've switched to 2.6.16 which started to oops at reboot/shutdown.

Kind regards,

Axel Scheepers
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFERhfTvOFCXiGjP+ARAlZqAKCElcGVUgXb0nWD+NsKL44MTNc91gCffDAR
f+mbMwDvLmmq7tw4FjVGmtk=
=Sb2b
-----END PGP SIGNATURE-----

--------------090007030504070607000106
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

Unable to handle kernel paging request at virtual address e0aca644
Printing EIP
c0280d10
*pde = 014d4067
*pte = 00000000
Oops:  0000 [#1]
Modules linked in: rfcomm l2cap sd_mod scsi_mos ipv6 firmware_class af_packet
                   yenta_socket rsrc_nonstatic pcmcia_core 8250_pci 8250
                   serial_core snd_intel8x0 snd_ac97_codec snd_ac97_bus
                   snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_soundcore
                   snd_page_alloc intel_agp agpart ahci_hcd hci_usb bluetooth
                   usbhid uhci_hcd usbcore ide_cd cdrom rtc joydev unix

CPU: 0
EIP: 0060:[<c0280d10>] Not tainted VLI
EFLAGS: 00010282 (2.6.16.7.broken #1)
EIP is at device_shutdown+0x50/0xc4
eax: e0aca520 ebx: def95408 ecx: 00000000 edx: ded75a38
esi: c0378b68 edi: b7f3cff  ebp: def54000 esp: def55e84
ds: 007b es: 007b ss: 0068

Process reboot (pid: 4939, threadinfo=def54000 task=dfc18970
Stack: <0> c03e9dc8 00000000 01234567 c0126060 00000000 c0226a3f 28121969 
           c0126646 00000000 c03012fc bfa63cb4 def55ebc 00000020 00000000
           00006f6c 00000000 00000000 00000000 00000002 0100007f 00000008
           bfa63c94 c0226a3f 00000286

Call trace:
  [<c0126060>]  kernel_restart+0x10/0x70
  [<c0226a3f>]  copy_to_user+0x3f/0x80
  [<c0126646>]  sys_reboot+0xc6/0x160
  [<c03012fc>]  inet_gifconf+0x7c/0xd0
  [<c0226a3f>]  copy_to_user+0x3f/0x80
  [<c0302e0e>]  inet_sock_destruct+0xce/0x240
  [<c015a071>]  invalidate_inode_buffers+0x11/0x50
  [<c02b548b>]  sock_destroy_inode+0x1b/0x20
  [<c016cf1a>]  dentry_input+0x5a/0x70
  [<c0170f83>]  mntput_no_expire+0x23/0x80
  [<c0156d37>]  __fput+0xc7/0x110
  [<c0153ee2>]  filp_close+0x52/0x90
  [<c0154c92>]  sys_close+0x72/0x80
  [<c0102e51>]  syscall_call+0x7/0xb

Code: c0 8d 90 7c ff ff ff 8b 9a 88 00 00 00
      81 eb 84 00 00 00 3d 28 8b 37 c0 74 71
      8b 82 d4 00 00 00 85 c0 74 37 8d b4 26
      00 00 00 00 <8b> 80 24 01 00 00 85
      c0 74 26 89 14 24 ff db 8b 83 88 00
      00 00


--------------090007030504070607000106--
