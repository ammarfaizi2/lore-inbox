Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264614AbUEEMJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264614AbUEEMJW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 08:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbUEEMJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:09:22 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:34441 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S264614AbUEEMJL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:09:11 -0400
Message-ID: <4098D965.3060500@free.fr>
Date: Wed, 05 May 2004 14:09:09 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040501
X-Accept-Language: en
MIME-Version: 1.0
To: eric.valette@free.fr
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Re : 2.6.6-rc3-mm2 : REGPARAM forced => no external module with
 some object code only
References: <4098D65D.9010107@free.fr>
In-Reply-To: <4098D65D.9010107@free.fr>
Content-Type: multipart/mixed;
 boundary="------------080408030809060303060501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080408030809060303060501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Eric Valette wrote:
> Andrew,
> 
> The Changelog says nothing really important but forcing REGPARAM is 
> rather important : it breaks any external module using object only code 
> that calls a kernel function.
>...
> Complete stack trace attached... (that shows they do not expect kmalloc 
> to fail :-( )


-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr




--------------080408030809060303060501
Content-Type: text/plain;
 name="bewanBub.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bewanBub.txt"

May  5 12:04:29 localhost kernel: unicorn_pci_atm: module license 'Proprietary' taints kernel.
May  5 12:04:29 localhost kernel: PCI: Enabling device 0000:00:09.0 (0014 -> 0016)
May  5 12:04:29 localhost kernel: unicorn_pci: AFE 70134
May  5 12:04:29 localhost kernel: unicorn_pci: v 0.0.0, 12:03:15 May  5 2004
May  5 12:04:29 localhost kernel: unicorn_pci: MSW parameters: 
May  5 12:04:29 localhost kernel: ActivationMode=1
May  5 12:04:29 localhost kernel: ActTimeout=300000
May  5 12:04:29 localhost kernel: AutoActivation=1
May  5 12:04:29 localhost kernel: DebugLevel=0
May  5 12:04:29 localhost kernel: DownstreamRate=8128
May  5 12:04:29 localhost kernel: unicorn_pci: ExchangeDelay=20
May  5 12:04:29 localhost kernel: FmPollingRate=1000
May  5 12:04:29 localhost kernel: g_RefGain=28
May  5 12:04:29 localhost kernel: g_Teqmode=7
May  5 12:04:29 localhost kernel: InitTimeout=20000
May  5 12:04:29 localhost kernel: Interoperability=0
May  5 12:04:29 localhost kernel: unicorn_pci: LCD_Trig=15000
May  5 12:04:29 localhost kernel: LOS_LOF_Trig=5000
May  5 12:04:29 localhost kernel: LoopbackMode=0
May  5 12:04:29 localhost kernel: MswDebugLevel=2
May  5 12:04:29 localhost kernel: RetryTime=5000
May  5 12:04:29 localhost kernel: TrainingDelay=120
May  5 12:04:29 localhost kernel: unicorn_pci: useRFC019v=0
May  5 12:04:29 localhost kernel: useRFC029v=7000
May  5 12:04:29 localhost kernel: useRFC040v=0
May  5 12:04:29 localhost kernel: useRFC041v=1
May  5 12:04:29 localhost kernel: setINITIALDAC=93
May  5 12:04:29 localhost kernel: unicorn_pci: useRFCFixedRate=1
May  5 12:04:29 localhost kernel: useVCXO=0
May  5 12:04:29 localhost kernel: _no_TS652=0
May  5 12:04:29 localhost kernel: unicorn_pci: driver parameters: DebugLevel=0
May  5 12:04:29 localhost kernel: alloc_obj: kmalloc failed,size=-742088876,type=abc0
May  5 12:04:29 localhost kernel:  printing eip:
May  5 12:04:29 localhost kernel: e3aa11d5
May  5 12:04:29 localhost kernel: Oops: 0002 [#1]
May  5 12:04:29 localhost kernel: PREEMPT 
May  5 12:04:29 localhost kernel: CPU:    0
May  5 12:04:29 localhost kernel: EIP:    0060:[pg0+592122325/1067507712]    Tainted: P   VLI
May  5 12:04:29 localhost kernel: EFLAGS: 00010296   (2.6.6-rc3-mm2) 
May  5 12:04:29 localhost kernel: EIP is at xsm_ident+0x15/0xf0 [unicorn_pci_atm]
May  5 12:04:29 localhost kernel: eax: 00000001   ebx: 00000000   ecx: 00000001   edx: 00000001
May  5 12:04:29 localhost kernel: esi: 00000000   edi: e3ae6b00   ebp: 00000001   esp: d3c49ecc
May  5 12:04:29 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  5 12:04:29 localhost kernel: Process modprobe (pid: 3217, threadinfo=d3c49000 task=d6ba11f0)
May  5 12:04:29 localhost kernel: Stack: 00000000 0000abc0 d3c49f54 e3aa072b 00000001 00000001 00000000 00000000 
May  5 12:04:29 localhost kernel:        e3ae6b00 d3c49f10 e3a86a67 e3ab313f 00000000 00000000 e3aa8f20 00000000 
May  5 12:04:29 localhost kernel:        00000000 d3c49f50 e3a60d7c 00000000 d3c49f44 000000ff 00000000 de618768 
May  5 12:04:29 localhost kernel: Call Trace:
May  5 12:04:29 localhost kernel:  [pg0+592119595/1067507712] alloc_obj+0xfb/0x130 [unicorn_pci_atm]
May  5 12:04:29 localhost kernel:  [pg0+592013927/1067507712] _ZN19InterfaceProtectionC1Ev+0x17/0x48 [unicorn_pci_atm]
May  5 12:04:29 localhost kernel:  [pg0+591859068/1067507712] AMSW_Modem_SW_Init+0x28/0x11c [unicorn_pci_atm]
May  5 12:04:29 localhost kernel:  [pg0+592133283/1067507712] unicorn_atm_startdevice+0x23/0x90 [unicorn_pci_atm]
May  5 12:04:29 localhost kernel:  [pg0+592128052/1067507712] msw_init+0x14/0x140 [unicorn_pci_atm]
May  5 12:04:29 localhost kernel:  [pg0+592142941/1067507712] unicorn_attach+0x16d/0x1b0 [unicorn_pci_atm]
May  5 12:04:29 localhost kernel:  [pg0+592429885/1067507712] unicorn_pci_init+0x33d/0x43e [unicorn_pci_atm]
May  5 12:04:29 localhost kernel:  [sys_init_module+258/528] sys_init_module+0x102/0x210
May  5 12:04:29 localhost kernel:  [filp_close+79/128] filp_close+0x4f/0x80
May  5 12:04:29 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  5 12:04:29 localhost kernel: 
May  5 12:04:29 localhost kernel: Code: c0 8b 44 24 30 c7 00 00 00 00 00 b8 01 00 00 00 eb b1 8d 74 26 00 55 89 cd 57 56 53 83 ec 18 89 44 24 14 c7 44 24 10 01 00 00 00 <c7> 01 00 00 00 00 9c 5b fa b8 00 f0 ff ff 21 e0 ff 40 14 a1 bc 

--------------080408030809060303060501--
