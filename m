Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315224AbSDWOqz>; Tue, 23 Apr 2002 10:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315225AbSDWOqy>; Tue, 23 Apr 2002 10:46:54 -0400
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:31243
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S315224AbSDWOqs>; Tue, 23 Apr 2002 10:46:48 -0400
Date: Tue, 23 Apr 2002 07:46:45 -0700
From: Phil Oester <kernel@theoesters.com>
To: linux-kernel@vger.kernel.org
Subject: OOPS in 2.4.18
Message-ID: <20020423074645.A7419@ns1.theoesters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wasn't doing anything special to trigger this...

ksymoops 2.4.0 on i586 2.4.18.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Apr 21 12:38:09 ns1 kernel: Unable to handle kernel paging request at virtual address 89106880
Apr 21 12:38:09 ns1 kernel: 89106880
Apr 21 12:38:09 ns1 kernel: *pde = 00000000
Apr 21 12:38:09 ns1 kernel: Oops: 0000
Apr 21 12:38:09 ns1 kernel: CPU:    0
Apr 21 12:38:09 ns1 kernel: EIP:    0010:[cpuid_exit+-1995413408/-1072693280]    Not tainted
Apr 21 12:38:09 ns1 kernel: EIP:    0010:[<89106880>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 21 12:38:09 ns1 kernel: EFLAGS: 00010206
Apr 21 12:38:09 ns1 kernel: eax: c2b4bf30   ebx: c2b4a000   ecx: c2b4bfc4   edx: c13de2b0
Apr 21 12:38:09 ns1 kernel: esi: 00000020   edi: c2b4a000   ebp: c2b4bf30   esp: c2b4bf10
Apr 21 12:38:09 ns1 kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 12:38:09 ns1 kernel: Process named (pid: 712, stackpage=c2b4b000)
Apr 21 12:38:09 ns1 kernel: Stack: c0106bc5 00000020 c13de2b0 c2b4bf30 c2b4a560 c2b4bfc4 c2b4a560 c2b4bfc4 
Apr 21 12:38:09 ns1 kernel:        00000020 00000000 00000000 000002c7 00000000 c02b5ce0 c11e9060 c2b4a000 
Apr 21 12:38:09 ns1 kernel:        c2b4a000 00000000 c189a000 c0290540 c2b4bf78 00000246 c2b4bf78 c010f204 
Apr 21 12:38:09 ns1 kernel: Call Trace: [do_signal+581/656] [schedule_timeout+132/160] [process_timeout+0/80] [schedule+710/752] [sys_nanosleep+270/400] 
Apr 21 12:38:09 ns1 kernel: Call Trace: [<c0106bc5>] [<c010f204>] [<c010f130>] [<c010f506>] [<c0117c3e>] 
Apr 21 12:38:09 ns1 kernel:    [<c0106d44>] 
Apr 21 12:38:09 ns1 kernel: Code:  Bad EIP value.

>>EIP; 89106880 Before first symbol   <=====
Trace; c0106bc5 <do_signal+245/290>
Trace; c010f204 <schedule_timeout+84/a0>
Trace; c010f130 <process_timeout+0/50>
Trace; c010f506 <schedule+2c6/2f0>
Trace; c0117c3e <sys_nanosleep+10e/190>
Trace; c0106d44 <signal_return+14/20>

