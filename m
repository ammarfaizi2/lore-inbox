Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbRGIUV3>; Mon, 9 Jul 2001 16:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbRGIUVW>; Mon, 9 Jul 2001 16:21:22 -0400
Received: from sammy.netpathway.com ([208.137.139.2]:9989 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S264883AbRGIUVO>; Mon, 9 Jul 2001 16:21:14 -0400
Message-ID: <3B4A1234.4CDA9C20@netpathway.com>
Date: Mon, 09 Jul 2001 15:21:08 -0500
From: "Gary White (Network Administrator)" <admin@netpathway.com>
Organization: Internet Pathway
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
        "Mohammad A. Haque" <mhaque@haque.net>
Subject: Re: VMWare crashes
In-Reply-To: <82677BD2F89@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just happened again. This only happens when there is a lot
of network activity. This time I was downloading an mp3 from
the newsgroups. During normal day to day activity it does not
die. 


Unable to handle kernel NULL pointer dereference at virtual address 00000070
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e1af9639>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013282
eax: 00000000   ebx: 00000000   ecx: dae7c000   edx: 00000000
esi: dfe42864   edi: dfe46c10   ebp: dfe46bdc   esp: dae7deb0
ds: 0018   es: 0018   ss: 0018
Process vmware (pid: 371, stackpage=dae7d000)
Stack: dca4e804 00000000 dca4e800 dfe4212c c01283d2 c1887690 de21d584 c18dac00
       dfe425c4 dfe425c4 dfe4212c e1af7ffe dfe46c30 d83d6a5c 00003202 dca4e804
       00000000 dca4e800 dfe4212c e1af8546 dca4e804 d83d6a5c dfe427bc c020a91f
Call Trace: [<c01283d2>] [<c020a91f>] [<c013e85a>] [<c0130696>] [<c0106e33>]
Code: 8b 42 70 83 f8 01 74 0a ff 4a 70 0f 94 c0 84 c0 74 0c 83 c4

>>EIP; e1af9639 <[vmnet]VNetBridgeReceiveFromVNet+191/20c>   <=====
Trace; c01283d2 <kfree+1d2/270>
Trace; c020a91f <__kfree_skb+12f/140>
Trace; c013e85a <select_bits_free+a/10>
Trace; c0130696 <sys_write+96/d0>
Trace; c0106e33 <system_call+33/38>
Code;  e1af9639 <[vmnet]VNetBridgeReceiveFromVNet+191/20c>
0000000000000000 <_EIP>:
Code;  e1af9639 <[vmnet]VNetBridgeReceiveFromVNet+191/20c>   <=====
   0:   8b 42 70                  mov    0x70(%edx),%eax   <=====
Code;  e1af963c <[vmnet]VNetBridgeReceiveFromVNet+194/20c>
   3:   83 f8 01                  cmp    $0x1,%eax
Code;  e1af963f <[vmnet]VNetBridgeReceiveFromVNet+197/20c>
   6:   74 0a                     je     12 <_EIP+0x12> e1af964b <[vmnet]VNetBridgeReceiveFromVNet+1a3/20c>
Code;  e1af9641 <[vmnet]VNetBridgeReceiveFromVNet+199/20c>
   8:   ff 4a 70                  decl   0x70(%edx)
Code;  e1af9644 <[vmnet]VNetBridgeReceiveFromVNet+19c/20c>
   b:   0f 94 c0                  sete   %al
Code;  e1af9647 <[vmnet]VNetBridgeReceiveFromVNet+19f/20c>
   e:   84 c0                     test   %al,%al
Code;  e1af9649 <[vmnet]VNetBridgeReceiveFromVNet+1a1/20c>
  10:   74 0c                     je     1e <_EIP+0x1e> e1af9657 <[vmnet]VNetBridgeReceiveFromVNet+1af/20c>
Code;  e1af964b <[vmnet]VNetBridgeReceiveFromVNet+1a3/20c>
  12:   83 c4 00                  add    $0x0,%esp


Petr Vandrovec wrote:
> 
> On  9 Jul 01 at 9:49, Gary White (Network Administr wrote:
> > I realize this may be a VMWare problem, but I just waited to
> > bring this to the attention of the developers in case it was related
> > to the kernel and to also see if anyone else is having the same
> > problem. VMWare dies under load with all kernel versions up to and
> > including ac versions after 2.4.6. Kernel version up to and including
> > 2.4.5-ac15 I know all run fine. Somewhere between 2.4.5-ac15 and 2.4.6
> > is where the problem started. I have backed up to 2.4.5 now and VMWare
> > is rock solid.
> 
> > Unable to handle kernel NULL pointer dereference at virtual address 00000070
> >  printing eip:
> > e1af85e1
> > Call Trace: [<c0203fe4>] [<c0203fe4>] [<c011722f>] [<c012eb26>] [<c0106dc3>]
> 
> Could you feed these oopeses through ksymoops?
> 
> I'm now running vmware 24h/day with linux and win98 as guest, doing
> network transfers between host and guest, and I did not noticed any problems.
> 
> It worked fine with 2.4.5-ac24 from wednesday to sunday, and yesterday
> I upgraded to 2.4.6-ac2, and it still works. Kernel compiled with
> Debian's gcc-3.0-3 or gcc-3.0-4, Asus A7V, KT133, 1GHz Athlon, and
> Chaintech 6BTM, 440BX, 300MHz Celeron... I did not tested Linus's kernel
> for more than 6 months now, so I cannot tell whether it works with Linus's
> 2.4.6, or not...
>                                         Best regards,
>                                             Petr Vandrovec
>                                             vandrove@vc.cvut.cz
> 

-- 
Gary White               Network Administrator
admin@netpathway.com          Internet Pathway
Voice 601-776-3355            Fax 601-776-2314

