Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129184AbRBUPsT>; Wed, 21 Feb 2001 10:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129192AbRBUPsJ>; Wed, 21 Feb 2001 10:48:09 -0500
Received: from [64.64.109.142] ([64.64.109.142]:31247 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129184AbRBUPsF>; Wed, 21 Feb 2001 10:48:05 -0500
Message-ID: <3A93E2E6.F6FD4602@didntduck.org>
Date: Wed, 21 Feb 2001 10:46:46 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alberto Bertogli <albertogli@telpin.com.ar>
CC: linux-kernel@vger.kernel.org, soporte@telpin.com.ar
Subject: Re: "Unable to handle kernel paging request" x 3
In-Reply-To: <982763791.3a93c90f0c35c@webmail.telpin.com.ar>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alberto Bertogli wrote:
> 
> This is the 3rd day in a row i got an oops.
> The only difference this time was the machine had one postgresql running, with
> mailsnarf, vmstat, apache and inetd; without any load.
> 
> The oops (passed through ksymoops 2.4) is attached, with the dmesg.
> 
> Linux sol 2.4.1 #3 SMP Wed Feb 14 18:14:33 ARST 2001 i686 unknown
> The only module loaded is the megaraid.
> 
> Please ask if you need any other info.
> 
> Thanks,
>         Alberto
> 
>   ------------------------------------------------------------------------
> 
> ksymoops 2.3.7 on i686 2.4.1.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.1/ (default)
>      -m /boot/System.map (specified)
> 
> Unable to handle kernel paging request at virtual address 00009fac
> *pde = 00000000
> CPU:    1
> EIP:    0010:[<c01071ec>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: 00000000  ebx: c01071c0  ecx: c1228000  edx: c1228000
> esi: c1228000  edi: c01071c0  ebp: 00000000  esp: c1229bf0
> ds: 0018  es: 0018 ss: 0018
> Process swapper (pid: 0, stackpage=c1229000)
> Stack: c010724e 00000000 00000000 00000000 c037d886 0000002b 00000000 c024126d
>        00000000 00000006 00000007 00000000 00000000 c03e8a40 0000c000 c01e771e
>        c1223000 00000001 00000000 00000000
> Call trace: [<c010724e>] [<c024126d>] [<c01e771e>]
> Code: c3 8d 76 00 fb c3 89 f6 fb ba 00 e0 ff ff 21 e2 b8 ff ff ff
> 
> >>EIP; c01071ec <default_idle+2c/34>   <=====
> Trace; c010724e <cpu_idle+3a/50>
> Trace; c024126d <vgacon_cursor+1e9/1f4>
> Trace; c01e771e <set_cursor+6e/84>
> Code;  c01071ec <default_idle+2c/34>
> 00000000 <_EIP>:
> Code;  c01071ec <default_idle+2c/34>   <=====
>    0:   c3                        ret       <=====

This one just looks really odd.  I can't figure out where the faulting
address (0x00009fac) is coming from.  It's not from the ret instruction,
which should be getting a valid return address off the stack.  Do you
still have the raw oops message (before sending it through ksymoops)?

--

				Brian Gerst
