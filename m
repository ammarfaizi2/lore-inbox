Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289336AbSBEBU2>; Mon, 4 Feb 2002 20:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289335AbSBEBUR>; Mon, 4 Feb 2002 20:20:17 -0500
Received: from foo.stahl.nu ([194.18.231.22]:48118 "EHLO Darkmere.psychozone")
	by vger.kernel.org with ESMTP id <S289336AbSBEBUC>;
	Mon, 4 Feb 2002 20:20:02 -0500
Date: Tue, 5 Feb 2002 02:19:33 +0100
From: Spider <spider@darkmere.wanfear.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Oops booting linux-2.4.18-pre7-ac3
Message-Id: <20020205021933.34aff42f.spider@darkmere.wanfear.com>
Reply-To: spider@darkmere.wanfear.com
Organization: Chaotic
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Message: Why does this appear like this?
X-BeenThere: Pluto
X-Apparently-From: Jupiter
X-A_Mail_Client_Is_Not_A_Web_Browser: <HTML><BLINK><H1>12:00<P>
X-Complaints-To: /dev/null
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.2FM7E/jUA,pxvb"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.2FM7E/jUA,pxvb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This is pretty much the same as "oops booting 2.4.18-pre7-ac3" by "Todd M. Roy" <troy@holstein.com> but I post it as well.

I'm not subscribed, so if you wish more information (.config, other info on hardware/software installed) please cc' me.

//Spider



PCI: PCI BIOS revision 2.10 entry at 0xf1150, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: Disabling Via external APIC routing
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc2b0.
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc2e0, dseg 0xf0000.
PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded by driver.
PnPBIOS: PNP0c02: ioport range 0xe400-0xe47f has been reserved.
PnPBIOS: PNP0c02: ioport range 0xe800-0xe83f could not be reserved.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Unable to handle kernel NULL pointer dereference at virtual address 0000002c
 printing eip:
c012afb1
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012afb1>]    Not tainted
EFLAGS: 00010046
eax: 00000000   ebx: 00000000   ecx: d1fc0000   edx: 00000000
esi: 00000000   edi: c03018a0   ebp: 000001f0   esp: d1fc1f74
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 2, stackpage=d1fc1000)
Stack: 00000000 00000000 00000000 00000000 00000000 00000000 c03018a0 d1fc1fdc 
       c011de76 00000000 000001f0 d1fc0000 00000000 c0105000 c011fdd3 00000000 
       d1fc0000 d1fe1fb8 c0114a9c 00000000 00000000 d1fc0000 d1fc0000 c0114af5 
Call Trace: [<c011de76>] [<c0105000>] [<c011fdd3>] [<c0114a9c>] [<c0114af5>] 
   [<c01f3a3d>] [<c0105000>] [<c0105746>] [<c01f3a30>] 

Code: f6 43 2c 01 74 02 0f 0b 9c 5e fa 8b 4b 08 8d 7b 08 39 f9 75 
 Starting kswapd



>>EIP; c012afb1 <kmem_cache_alloc+21/b0>   <=====
Trace; c011de76 <alloc_uid+56/d0>
Trace; c0105000 <_stext+0/0>
Trace; c011fdd3 <set_user+13/60>
Trace; c0114a9c <reparent_to_init+13c/150>
Trace; c0114af5 <daemonize+45/60>
Trace; c01f3a3d <pnp_dock_thread+d/100>
Trace; c0105000 <_stext+0/0>
Trace; c0105746 <kernel_thread+26/30>
Trace; c01f3a30 <pnp_dock_thread+0/100>
Code;  c012afb1 <kmem_cache_alloc+21/b0>
00000000 <_EIP>:
Code;  c012afb1 <kmem_cache_alloc+21/b0>   <=====
   0:   f6 43 2c 01               testb  $0x1,0x2c(%ebx)   <=====
Code;  c012afb5 <kmem_cache_alloc+25/b0>
   4:   74 02                     je     8 <_EIP+0x8> c012afb9 <kmem_cache_alloc+29/b0>
Code;  c012afb7 <kmem_cache_alloc+27/b0>
   6:   0f 0b                     ud2a   
Code;  c012afb9 <kmem_cache_alloc+29/b0>
   8:   9c                        pushf  
Code;  c012afba <kmem_cache_alloc+2a/b0>
   9:   5e                        pop    %esi
Code;  c012afbb <kmem_cache_alloc+2b/b0>
   a:   fa                        cli    
Code;  c012afbc <kmem_cache_alloc+2c/b0>
   b:   8b 4b 08                  mov    0x8(%ebx),%ecx
Code;  c012afbf <kmem_cache_alloc+2f/b0>
   e:   8d 7b 08                  lea    0x8(%ebx),%edi
Code;  c012afc2 <kmem_cache_alloc+32/b0>
  11:   39 f9                     cmp    %edi,%ecx
Code;  c012afc4 <kmem_cache_alloc+34/b0>
  13:   75 00                     jne    15 <_EIP+0x15> c012afc6 <kmem_cache_alloc+36/b0>



-- 
begin  signature
This is a .signature virus! Please copy me into your .signature!
See Microsoft KB Article Q265230 for more information.
end

--=.2FM7E/jUA,pxvb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8XzMpXNNftdcUD70RAjhmAKCHg52JkuoVKSyUjytDRxDzr3Q40gCdFKnV
lehXTt2LXSSt1vfwad1WNY8=
=yymM
-----END PGP SIGNATURE-----

--=.2FM7E/jUA,pxvb--

