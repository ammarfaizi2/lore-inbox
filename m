Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273625AbRIURLG>; Fri, 21 Sep 2001 13:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273626AbRIURK5>; Fri, 21 Sep 2001 13:10:57 -0400
Received: from [217.6.75.131] ([217.6.75.131]:59352 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S273625AbRIURKr>; Fri, 21 Sep 2001 13:10:47 -0400
Message-ID: <3BAB76A4.74B43FBD@internetwork-ag.de>
Date: Fri, 21 Sep 2001 19:19:32 +0200
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Reply-To: tip@prs.de
Organization: interNetwork AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.4.10-pre13: ATM drivers cause panic
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following ATM drivers cause linux to panic during boot (if one of the cards
is inserted :-))
iphase
fore200e
he

Machine is a 2 PIII, 3GB, Asus CUR-DLS motherboard - tried NOAPIC, MAXCPUS, same
difference.
When installing as a module I'll get the following trace below.
Any help is greatly appreciated!

Thanks

Immanuel

P.S. If you need more info please let me know what kind...


Sep 21 18:03:41 ipat01 kernel: invalid operand: 0000
Sep 21 18:03:41 ipat01 kernel: CPU:    0
Sep 21 18:03:41 ipat01 kernel: EIP:    0010:[atm_dev_register+289/308]
Sep 21 18:03:41 ipat01 kernel: EFLAGS: 00010202
Sep 21 18:03:41 ipat01 kernel: eax: 00000001   ebx: f75303c0   ecx: 0000006f
edx: 0000120c
Sep 21 18:03:41 ipat01 kernel: esi: f898ca09   edi: f753042c   ebp: 00000000
esp: f619beb8
Sep 21 18:03:41 ipat01 kernel: ds: 0018   es: 0018   ss: 0018
Sep 21 18:03:41 ipat01 kernel: Process insmod (pid: 1078, stackpage=f619b000)
Sep 21 18:03:41 ipat01 kernel: Stack: f898d410 00000000 f898d460 c4322800
f89880a6 f898ca09 f898d3c0 ffffffff
Sep 21 18:03:41 ipat01 kernel:        00000000 f898d410 c4322800 f898d460
00000000 c4322800 c024871e c4322800
Sep 21 18:03:41 ipat01 kernel:        f898d410 c4322800 f898d460 00000000
00005580 c0248784 f898d460 c4322800
Sep 21 18:03:41 ipat01 kernel: Call Trace: [<f898d410>] [<f898d460>]
[<f89880a6>] [<f898ca09>] [<f898d3c0>]
Sep 21 18:03:41 ipat01 kernel:    [<f898d410>] [<f898d460>]
[pci_announce_device+54/84] [<f898d410>] [<f898d460>]
[pci_register_driver+72/96]
Sep 21 18:03:41 ipat01 kernel:    [<f898d460>] [<f8988063>] [<f898c8bf>]
[<f898d460>] [sys_init_module+1357/1580] [<f8988060>]
Sep 21 18:03:41 ipat01 kernel:    [system_call+51/56]
Sep 21 18:03:41 ipat01 kernel:
Sep 21 18:03:41 ipat01 kernel: Code: 0f 0b c6 05 14 74 34 c0 01 89 d8 5b 5e 5f
5d c3 8d 76 00 53


--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de



