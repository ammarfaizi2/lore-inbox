Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUDFIpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 04:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUDFIpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 04:45:39 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:52922 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S262768AbUDFIpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 04:45:35 -0400
Date: Tue, 6 Apr 2004 10:45:33 +0200
From: Jan Killius <jkillius@arcor.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops with cpufreq on 2.6.5-mm1
Message-ID: <20040406084533.GA9227@gate.unimatrix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
X-Operating-System: Linux 2.6.5 i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here is the right Oops.
-- 
        Jan

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

ksymoops 2.4.9 on x86_64 2.6.5-mm1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.5-mm1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at 0000000000000004 RIP:
<ffffffff80269922>{cpufreq_frequency_table_cpuinfo+2}PML4 3e8f6067 PGD 3e963067 PMD 0
Oops: 0000 [1] PREEMPT
CPU 0
Pid: 5201, comm: modprobe Not tainted 2.6.5-mm1
RIP: 0010:[<ffffffff80269922>] <ffffffff80269922>{cpufreq_frequency_table_cpuinfo+2}
Using defaults from ksymoops -t elf64-x86-64 -a i386:x86-64
RSP: 0018:000001003ecb7d90  EFLAGS: 00010246
RAX: 00000000001e8480 RBX: 000000000000000c RCX: 0000000000000000
RDX: 00000000fffffffb RSI: 0000000000000000 RDI: 000001003fb739c0
RBP: 000001003f40f600 R08: 0000000000000033 R09: 0000000000000003
R10: 00000000ffffffff R11: 0000000000000000 R12: 000000000000020c
R13: 000000000000000c R14: 00000100000f0e88 R15: 000001003fb739c0
FS:  0000003872f0f060(0000) GS:ffffffff803ef580(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
        CR2: 0000000000000004 CR3: 0000000000101000 CR4: 00000000000006e0
Process modprobe (pid: 5201, stackpage=1003e8b5000)
        Stack: ffffffffa0003523 0000000000000002 ffffffff00000002 000001003fbc3c60
        0000000000000001 000001003fb739c0 ffffffff803ba688 000001003fb739e8
        0000000000000000 0000000000517c70
        Call Trace:<ffffffffa0003523>{:powernow_k8:powernowk8_cpu_init+1315}
        <ffffffff802691e1>{cpufreq_add_dev+257} <ffffffff8013333e>{printk+494}
        <ffffffff80213a09>{sysdev_driver_register+121} <ffffffff802696fb>{cpufreq_register_driver+219}
        <ffffffffa0003698>{:powernow_k8:powernowk8_init+216}
        <ffffffff80149c8e>{sys_init_module+318} <ffffffff8010f172>{system_call+126}
Code: 83 7e 04 fe 41 b8 ff ff ff ff 89 ca 74 22 31 c0 8b 44 c6 04


>>RIP; ffffffff80269922 <cpufreq_frequency_table_cpuinfo+2/60>   <=====

Trace; ffffffffa0003523 <_end+1fbe7523/7f1e4000>
Trace; ffffffff802691e1 <cpufreq_add_dev+101/350>
Trace; ffffffff80213a09 <sysdev_driver_register+79/d0>
Trace; ffffffffa0003698 <_end+1fbe7698/7f1e4000>
Trace; ffffffff80149c8e <sys_init_module+13e/2b0>

Code;  ffffffff80269922 <cpufreq_frequency_table_cpuinfo+2/60>
0000000000000000 <_RIP>:
Code;  ffffffff80269922 <cpufreq_frequency_table_cpuinfo+2/60>   <=====
   0:   83 7e 04 fe               cmpl   $0xfffffffffffffffe,0x4(%rsi)   <=====
Code;  ffffffff80269926 <cpufreq_frequency_table_cpuinfo+6/60>
   4:   41 b8 ff ff ff ff         mov    $0xffffffff,%r8d
Code;  ffffffff8026992c <cpufreq_frequency_table_cpuinfo+c/60>
   a:   89 ca                     mov    %ecx,%edx
Code;  ffffffff8026992e <cpufreq_frequency_table_cpuinfo+e/60>
   c:   74 22                     je     30 <_RIP+0x30>
Code;  ffffffff80269930 <cpufreq_frequency_table_cpuinfo+10/60>
   e:   31 c0                     xor    %eax,%eax
Code;  ffffffff80269932 <cpufreq_frequency_table_cpuinfo+12/60>
  10:   8b 44 c6 04               mov    0x4(%rsi,%rax,8),%eax

CR2: 0000000000000004

1 warning and 1 error issued.  Results may not be reliable.

--bg08WKrSYDhXBjb5--
