Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTJTAyl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 20:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbTJTAyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 20:54:41 -0400
Received: from web41605.mail.yahoo.com ([66.218.93.105]:48235 "HELO
	web41605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262353AbTJTAyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 20:54:38 -0400
Message-ID: <20031020005437.47533.qmail@web41605.mail.yahoo.com>
Date: Sun, 19 Oct 2003 21:54:37 -0300 (ART)
From: =?iso-8859-1?q?Alexandre=20Nunes?= <alexandrenunes_99@yahoo.com>
Reply-To: alex@polesapart.dhs.org
Subject: Linux 2.4.23-pre7 panic on boot (ksymoops report included)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-649275233-1066611277=:46425"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-649275233-1066611277=:46425
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Linux 2.4.23-pre7 and pre6 panics on boot.

My machine is an athlon 900mhz on an asrock k7vt2
mainboard. The kernel was compiled with gcc 3.3.2, but
3.3.1 shows the same results.

2.4.23-pre5 works fine.

Attached is a ksymoops report. The funny thing is that
since the kernel panics before boot is complete, I had
to use console=ttyS0 and capture kernel log msgs on
another machine.

Please forward to me on replies, since I'm not
subscribed to the list.

Thanks,

Alexandre

Yahoo! Mail - o melhor webmail do Brasil
http://mail.yahoo.com.br
--0-649275233-1066611277=:46425
Content-Type: text/plain; name="oops.txt"
Content-Description: oops.txt
Content-Disposition: inline; filename="oops.txt"

ksymoops 2.4.9 on i686 2.4.23-pre5.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.23-pre7 (specified)
     -m /usr/src/linux/System.map (default)

No modules in ksyms, skipping objects
cpu: 0, clocks: 2000158, slice: 1000079
Unable to handle kernel NULL pointer dereference at virtual address 000000ae
c0192e14
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0192e14>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 000000aa   ebx: 00000000   ecx: c158c580   edx: c158c580
esi: c158c580   edi: dffe0000   ebp: 00000008   esp: dffe9e7c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=dffe9000)
Stack: 000000aa dffe0000 dffe01e8 00000000 e0802144 c019efa5 dffe0000 dffe9ea0 
       00000000 00000000 00080030 000000ad 00000001 c024bcd7 c018ff92 00000000 
       000001f0 00000246 00000030 00000009 00000030 000000ad 00000001 c024bcd7 
Call Trace:    [<c019efa5>] [<c018ff92>] [<c018ff92>] [<c01a3e03>] [<c01a3c78>]
  [<c019f5f3>] [<c019d062>] [<c019d07f>] [<c019cafd>] [<c0105000>] [<c019cb78>]
  [<c0105000>] [<c019cc2b>] [<c01a337a>] [<c0105080>] [<c01057cb>] [<c0105070>]
Code: 8b 40 04 89 46 28 8b 04 24 89 46 10 8d 87 e8 01 00 00 56 50 


>>EIP; c0192e14 <acpi_ds_load1_begin_op+161/192>   <=====

Trace; c019efa5 <acpi_ps_parse_loop+221/821>
Trace; c018ff92 <acpi_os_allocate+e/11>
Trace; c018ff92 <acpi_os_allocate+e/11>
Trace; c01a3e03 <acpi_ut_callocate+37/7c>
Trace; c01a3c78 <acpi_ut_acquire_from_cache+8f/9e>
Trace; c019f5f3 <acpi_ps_parse_aml+4e/17b>
Trace; c019d062 <acpi_ns_one_complete_parse+6e/7e>
Trace; c019d07f <acpi_ns_parse_table+d/22>
Trace; c019cafd <acpi_ns_load_table+69/8f>
Trace; c0105000 <_stext+0/0>
Trace; c019cb78 <acpi_ns_load_table_by_type+55/f2>
Trace; c0105000 <_stext+0/0>
Trace; c019cc2b <acpi_ns_load_namespace+16/2e>
Trace; c01a337a <acpi_load_tables+c2/11d>
Trace; c0105080 <init+10/110>
Trace; c01057cb <arch_kernel_thread+2b/40>
Trace; c0105070 <init+0/110>

Code;  c0192e14 <acpi_ds_load1_begin_op+161/192>
00000000 <_EIP>:
Code;  c0192e14 <acpi_ds_load1_begin_op+161/192>   <=====
   0:   8b 40 04                  mov    0x4(%eax),%eax   <=====
Code;  c0192e17 <acpi_ds_load1_begin_op+164/192>
   3:   89 46 28                  mov    %eax,0x28(%esi)
Code;  c0192e1a <acpi_ds_load1_begin_op+167/192>
   6:   8b 04 24                  mov    (%esp,1),%eax
Code;  c0192e1d <acpi_ds_load1_begin_op+16a/192>
   9:   89 46 10                  mov    %eax,0x10(%esi)
Code;  c0192e20 <acpi_ds_load1_begin_op+16d/192>
   c:   8d 87 e8 01 00 00         lea    0x1e8(%edi),%eax
Code;  c0192e26 <acpi_ds_load1_begin_op+173/192>
  12:   56                        push   %esi
Code;  c0192e27 <acpi_ds_load1_begin_op+174/192>
  13:   50                        push   %eax

 <0>Kernel panic: Attempted to kill init!

--0-649275233-1066611277=:46425--
