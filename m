Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbSKSQlA>; Tue, 19 Nov 2002 11:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbSKSQlA>; Tue, 19 Nov 2002 11:41:00 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:14720
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S265484AbSKSQk7>; Tue, 19 Nov 2002 11:40:59 -0500
Subject: Re: Two Stack Traces  - please respond if you can.
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1037690746.4410.10.camel@digitalroadkill.net>
References: <1037690746.4410.10.camel@digitalroadkill.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1037724480.3620.0.camel@digitalroadkill.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 19 Nov 2002 10:48:00 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If someone can help me with the stack trace examination I'd surely
appreciate it. Search the subject of this email, for the stack traces.
If people prefer attachments, I'll be happy to send them instead.

--The GrandMaster


On Tue, 2002-11-19 at 01:25, GrandMasterLee wrote:
> There are two stack traces in this email. I was curious if they both are
> bad output, as the stack may be corrupt, which I feel may be causing
> these panics. 
> 
> The recent, is from a 2.4.19-aa1 kernel, on my production oracle db
> which happened today.
> The old, is from a 2.4.19-aa1 kernel, on an identical box, running
> oracle, but occurred during stress testing. Any help regarding these two
> stacks is extremely welcome, as this is a rather urgent issue. 
> 
> TIA.
> 
> 
> <recent ksymoops output>
> 
> ksymoops 2.4.1 on i686 2.4.19.  Options used
>      -V (specified)
>      -k /proc/ksyms (specified)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.19/ (default)
>      -m /boot/System.map-2.4.19 (default)
> 
> Oops:   0000     2.4.19 #1 SMP Wed Oct 16 17:02:35 CDT 2002
> CPU:    0
> EIP:    0010:[<c01164ee>]  Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010007
> eax: c031e000   ebx: c034d8a8     ecx: 00000000       edx: ffffffd4
> esi: c034d880   edi: 00000080     ebp: c031ffc8       esp: c031ff98
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c031f000)
> Stack: c034d880 00000019 c031e000 c031e000 ffffffd4 0008e000 00000000
> c0100018
>        c0100018 c031e000 c0106e60 c0105000 0008e000 c0106ee9 0002080e
> 00098700
>        c03207a5 c031e000 00000000 c02a6da0 00200000 00200000 00200000
> 00038000
> Call Trace:    [<c0106e60>] [<c0105000>] [<c0106ee9>]
> Code: 8b 72 58 8b 40 5c 85 f6 89 45 d4 75 35 89 42 5c f0 ff 40 14
> 
> >>EIP; c01164ee <schedule+1ae/390>   <=====
> Trace; c0106e60 <default_idle+0/40>
> Trace; c0105000 <_stext+0/0>
> Trace; c0106ee9 <cpu_idle+29/30>
> Code;  c01164ee <schedule+1ae/390>
> 00000000 <_EIP>:
> Code;  c01164ee <schedule+1ae/390>   <=====
>    0:   8b 72 58                  mov    0x58(%edx),%esi   <=====
> Code;  c01164f1 <schedule+1b1/390>
>    3:   8b 40 5c                  mov    0x5c(%eax),%eax
> Code;  c01164f4 <schedule+1b4/390>
>    6:   85 f6                     test   %esi,%esi
> Code;  c01164f6 <schedule+1b6/390>
>    8:   89 45 d4                  mov    %eax,0xffffffd4(%ebp)
> Code;  c01164f9 <schedule+1b9/390>
>    b:   75 35                     jne    42 <_EIP+0x42> c0116530
> <schedule+1f0/390>
> Code;  c01164fb <schedule+1bb/390>
>    d:   89 42 5c                  mov    %eax,0x5c(%edx)
> Code;  c01164fe <schedule+1be/390>
>   10:   f0 ff 40 14               lock incl 0x14(%eax)
> 
> <0> Kernel panic: Attempted to kill the idle task!
> 
> 
> </recent ksymoops output>


