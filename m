Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274492AbRIURm7>; Fri, 21 Sep 2001 13:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274550AbRIURmu>; Fri, 21 Sep 2001 13:42:50 -0400
Received: from [217.6.75.131] ([217.6.75.131]:63960 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S274492AbRIURmj>; Fri, 21 Sep 2001 13:42:39 -0400
Message-ID: <3BAB7E1C.36CB94D4@internetwork-ag.de>
Date: Fri, 21 Sep 2001 19:51:24 +0200
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Reply-To: tip@prs.de
Organization: interNetwork AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.10-pre13: ATM drivers cause panic
In-Reply-To: <E15kU3r-0000bv-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well - here it comes w/ BUG in spinlock.h...

Thanks for your help...

Immanuel

ksymoops 2.4.0 on i686 2.4.10-pre13.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-pre13/ (default)
     -m /boot/System.map (specified)

Reading Oops report from the terminal
Sep 21 18:41:15 ipat01 kernel: kernel BUG at
/usr/src/linux-2.4.10-pre13-inw/include/asm/spinlock.h:104!
Sep 21 18:41:15 ipat01 kernel: invalid operand: 0000
Sep 21 18:41:15 iSep 21 18:41:15 ipat01 kernel: kernel BUG at
/usr/src/linux-2.4.10-pre13-inw/include/asm/spinlock.h:104!
pat01 kernel: CPU:    0
Sep 21 18:41:15 ipat01 kernel: EIP:    0010:[atm_dev_register+350/376]
Sep 21 18:41:15 ipat01 kernel: EFLAGS: 00010282
Sep 21 18:41:15 ipat01 kernel: eax: 0000004a   ebx: f6e2e160   ecx: c0374428
edx: 00003da4
Sep 21 18:41:15 ipat01 kernel: esi: f8995fb2   edi: f6e2e1cc   ebp: 00000000
esp: f6b43eb0
Sep 21 18:41:15 ipat01 kernel: ds: 0018   es: 0018   ss: 0018
Sep 21 18:41:15 ipat01 kernel: Process insmod (pid: 520, stackpage=f6b43000)
Sep 21 18:41:15 ipat01 kernel: Stack: c035fd40 00000068 f89969b0 00000000
f8996a00 c4322800 f89910a6 f8995fb2
Sep 21 18:41:15 ipat01 kernel:        f8996960 ffffffff 00000000 f89969b0
c4322800Sep 21 18:41:15 ipat01 kernel: invalid operand: 0000
Sep 21 18:41:15 ipat01 kernel: CPU:    0
Sep 21 18:41:15 ipat01 kernel: EIP:    0010:[atm_dev_register+350/376]
 f8996a00 00000000 c4322800
Sep 21 18:41:15 ipat01 kernel:        c025c90e c4322800 f89969b0 c4322800
f8996a00 00000000 00005b20 c025c974
Sep 21 18:41:15 ipat01 kernel: Call Trace: [<f89969b0>] [<f8996a00>]
[<f89910a6>] [<f8995fb2>] [<f8996960>]
Sep 21 18:41:15 ipat01 kernel:    [<f89969b0>] [<f8996a00>]
[pci_announce_device+54/84] [<f89969b0>] [<f8996a00>]
[pci_register_driver+72/96]
SeSep 21 18:41:15 ipat01 kernel: EFLAGS: 00010282
Sep 21 18:41:15 ipat01 kernel: eax: 0000004a   ebx: f6e2e160   ecx: c0374428
edx: 00003da4
Sep 21 18:41:15 ipat01 kernel: esi: f8995fb2   edi: f6e2e1cc   ebp: 00000000
esp: f6b43eb0
Sep 21 18:41:15 ipat01 kernel: ds: 0018   es: 0018   ss: 0018
p 21 18:41:15 ipat01 kernel:    [<f8996a00>] [<f8991063>] [<f8995c5f>]
[<f8996a00>] [sys_init_module+1373/1648] [<f8991060>]
Sep 21 18:41:15 ipat01 kernel:    [system_call+51/56]
Sep 21 18:41:15 ipat01 kernel:
Sep 21 18:41:15 ipat01 kernel: Code: 0f 0b 83 c4 08 90 8d 74 26 00 c6 05 74 c1
38 c0 01 89 d8 5b
Sep 21 18:41:15 ipat01 kernel: Process insmod (pid: 520, stackpage=f6b43000)
Sep 21 18:41:15 ipat01 kernel: Stack: c035fd40 00000068 f89969b0 00000000
f8996a00 c4322800 f89910a6 f8995fb2
Sep 21 18:41:15 ipat01 kernel:        f8996960 ffffffff 00000000 f89969b0
c4322800 f8996a00 00000000 c4322800
Sep 21 18:41:15 ipat01 kernel:        c025c90e c4322800 f89969b0 c4322800
f8996a00 00000000 00005b20 c025c974
Sep 21 18:41:15 ipat01 kernel: Call Trace: [<f89969b0>] [<f8996a00>]
[<f89910a6>] [<f8995fb2>] [<f8996960>]
Sep 21 18:41:15 ipat01 kernel:    [<f89969b0>] [<f8996a00>]
[pci_announce_device+54/84] [<f89969b0>] [<f8996a00>]
[pci_register_driver+72/96]
Sep 21 18:41:15 ipat01 kernel:    [<f8996a00>] [<f8991063>] [<f8995c5f>]
[<f8996a00>] [sys_init_module+1373/1648] [<f8991060>]
Sep 21 18:41:15 ipat01 kernel: Code: 0f 0b 83 c4 08 90 8d 74 26 00 c6 05 74 c1
38 c0 01 89 d8 5b
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; f89969b0 <[he]he_pci_tbl+0/50>
Trace; f8996a00 <[he]he_driver+0/27>
Trace; f89910a6 <[he]__module_parm_desc_disable64+6/d4>
Trace; f8995fb2 <[he].rodata.start+212/abf>
Trace; f8996960 <[he]he_ops+0/40>
Trace; f89969b0 <[he]he_pci_tbl+0/50>
Trace; f8996a00 <[he]he_driver+0/27>
Trace; f8996a00 <[he]he_driver+0/27>
Trace; f8991063 <[he]he_init_one+3/2c>
Trace; f8995c5f <[he]he_init+b/38>
Trace; f8996a00 <[he]he_driver+0/27>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   90                        nop
Code;  00000006 Before first symbol
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000a Before first symbol
   a:   c6 05 74 c1 38 c0 01      movb   $0x1,0xc038c174
Code;  00000011 Before first symbol
  11:   89 d8                     mov    %ebx,%eax
Code;  00000013 Before first symbol
  13:   5b                        pop    %ebx


Alan Cox wrote:

> > Sep 21 18:03:41 ipat01 kernel: invalid operand: 0000
> > Sep 21 18:03:41 ipat01 kernel: CPU:    0
> > Sep 21 18:03:41 ipat01 kernel: EIP:    0010:[atm_dev_register+289/308]
> > Sep 21 18:03:41 ipat01 kernel: EFLAGS: 00010202
>
> Thats confusing since I don't immediately see where the BUG() it hits is.
> Can you rebuild with verbose kernel debugging enabled
>         Kernel debugging = Y
>         Verbose BUG() reporting = Y
>
> Alan

--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de



