Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbSBDUw1>; Mon, 4 Feb 2002 15:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSBDUwS>; Mon, 4 Feb 2002 15:52:18 -0500
Received: from barn.holstein.com ([198.134.143.193]:60432 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S282843AbSBDUv5>;
	Mon, 4 Feb 2002 15:51:57 -0500
Date: Mon, 4 Feb 2002 15:51:28 -0500
Message-Id: <200202042051.g14KpS200331@pcx4168.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: oops booting 2.4.18-pre7-ac3
Reply-To: troy@holstein.com
In-Reply-To: <E16Xi2z-00073m-00@the-village.bc.nu>
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 02/04/2002 03:51:31 PM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 02/04/2002 03:51:32 PM,
	Serialize complete at 02/04/2002 03:51:32 PM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
  I got an oops almost immediatly when booting 2.4.18-pre7-ac3
(ksymoops appended to bottom of dmesg extract).

-- todd --


PCI: PCI BIOS revision 2.10 entry at 0xfcaee, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: Card 'CS4236B'
isapnp: 1 Plug & Play card detected total
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0.
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe2f4, dseg 0x40.
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver.
PnPBIOS: PNP0c01: ioport range 0x800-0x83f has been reserved.
PnPBIOS: PNP0c01: ioport range 0x850-0x85f has been reserved.
Unable to handle kernel NULL pointer dereference at virtual address 0000002c
c0126c04
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0126c04>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: 00000008   ecx: c150a000   edx: 00000000
esi: 00000000   edi: c02c5a20   ebp: 000001f0   esp: c150bf90
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 2, stackpage=c150b000)
Stack: 00000000 00000000 c02c5a20 c150bfd4 c011a850 00000000 000001f0 c150a000 
       00000000 00000000 c011c54f 00000000 00010f00 c151dfb8 c0111dbc 00000000 
       00000000 0008e000 c01d5589 00010f00 c151dfb8 00000000 0008e000 c010567f 
Call Trace: [<c011a850>] [<c011c54f>] [<c0111dbc>] [<c01d5589>] [<c010567f>] 
   [<c0105688>] 
Code: f6 46 2c 01 74 02 0f 0b 9c 5f fa 8b 4e 08 39 d9 75 22 8b 4e 

>>EIP; c0126c04 <swap_out+1c4/468>   <=====
Trace; c011a850 <collect_signal+cc/d4>
Trace; c011c54f <sys_setuid+eb/134>
Trace; c0111dbc <mm_init+68/a8>
Trace; c01d5589 <vesafb_set_cmap+9/7c>
Trace; c010567f <kernel_thread+1f/38>
Trace; c0105688 <kernel_thread+28/38>
Code;  c0126c04 <swap_out+1c4/468>
00000000 <_EIP>:
Code;  c0126c04 <swap_out+1c4/468>   <=====
   0:   f6 46 2c 01               testb  $0x1,0x2c(%esi)   <=====
Code;  c0126c08 <swap_out+1c8/468>
   4:   74 02                     je     8 <_EIP+0x8> c0126c0c <swap_out+1cc/468>
Code;  c0126c0a <swap_out+1ca/468>
   6:   0f 0b                     ud2a   
Code;  c0126c0c <swap_out+1cc/468>
   8:   9c                        pushf  
Code;  c0126c0d <swap_out+1cd/468>
   9:   5f                        pop    %edi
Code;  c0126c0e <swap_out+1ce/468>
   a:   fa                        cli    
Code;  c0126c0f <swap_out+1cf/468>
   b:   8b 4e 08                  mov    0x8(%esi),%ecx
Code;  c0126c12 <swap_out+1d2/468>
   e:   39 d9                     cmp    %ebx,%ecx
Code;  c0126c14 <swap_out+1d4/468>
  10:   75 22                     jne    34 <_EIP+0x34> c0126c38 <swap_out+1f8/468>
Code;  c0126c16 <swap_out+1d6/468>
  12:   8b 4e 00                  mov    0x0(%esi),%ecx

root [pcx4168] /home/tmr
$ 
