Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314377AbSEBLiH>; Thu, 2 May 2002 07:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314378AbSEBLiG>; Thu, 2 May 2002 07:38:06 -0400
Received: from bacchus.fh-brandenburg.de ([195.37.1.36]:46472 "HELO
	bacchus.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S314377AbSEBLiE>; Thu, 2 May 2002 07:38:04 -0400
Date: Thu, 2 May 2002 13:31:28 +0200
From: Markus Dahms <dahms@fh-brandenburg.de>
To: linux-kernel@vger.kernel.org
Subject: Oops on boot 2.5.8 - 2.5.12 i686 SMP (probably ACPI)
Message-ID: <20020502133128.A10382@zeus.fh-brandenburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks!

I have problems booting 2.5.{8,9,10,11,12} on my machine (2xP3). If I
believe ksymoops it is an ACPI problem. Is it known to be broken?
Output of ksymoops follows, boot log and .config are attached...

If you want quick answers, please CC me.

Markus

-------------------------------------------------------------------------------
ksymoops 2.4.5 on i686 2.4.18.  Options used
     -v /home/mad/src/linux-2.5/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.12/ (specified)
     -m /home/mad/src/linux-2.5/System.map (specified)

No modules in ksyms, skipping objects
cpu: 0, clocks: 1332854, slice: 444284
cpu: 1, clocks: 1332854, slice: 444284
Unable to handle kernel NULL pointer dereference at virtual address 00000016
c019867a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c019867a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: 00000000   ebx: 00000008   ecx: cfff5760   edx: cff5f8e0
esi: cfff5760   edi: 00000004   ebp: cff67c00   esp: cff71dc0
ds: 0018   es: 0018   ss: 0018
Stack: cff5f8e0 cfff5760 00000000 cff67c00 c019b98a cff67c00 cff5f8e0 cff71de0
       00000000 cff67db0 cff67c00 cff67db0 00000000 c019ba7a cff67db0 cff67c00
       00000001 cff67c00 c019bda8 cff67db0 cff67c00 00000000 11f67c00 00005b80
Call Trace: [<c019b98a>] [<c019ba7a>] [<c019bda8>] [<c0193e6c>] [<c01949c7>]
   [<c01a0d58>] [<c01a5636>] [<c01a12c6>] [<c0193a5e>] [<c0193b65>] [<c019e472>]
   [<c019f687>] [<c019e3c0>] [<c019fd99>] [<c019e3c0>] [<c019e378>] [<c019e3c0>]
   [<c0190000>] [<c0105000>] [<c01a7a05>] [<c010507f>] [<c0105000>] [<c01057b6>]
   [<c0105060>]
Code: f6 40 16 04 b8 04 00 00 00 0f 45 d8 39 df 0f 86 a2 00 00 00


>>EIP; c019867a <acpi_ex_read_data_from_field+3a/160>   <=====

>>ecx; cfff5760 <END_OF_CODE+fc71ef8/????>
>>edx; cff5f8e0 <END_OF_CODE+fbdc078/????>
>>esi; cfff5760 <END_OF_CODE+fc71ef8/????>
>>ebp; cff67c00 <END_OF_CODE+fbe4398/????>
>>esp; cff71dc0 <END_OF_CODE+fbee558/????>

Trace; c019b98a <acpi_ex_resolve_node_to_value+fa/1c0>
Trace; c019ba7a <acpi_ex_resolve_to_value+2a/50>
Trace; c019bda8 <acpi_ex_resolve_operands+a8/360>
Trace; c0193e6c <acpi_ds_eval_region_operands+3c/a0>
Trace; c01949c7 <acpi_ds_exec_end_op+1f7/2e0>
Trace; c01a0d58 <acpi_ps_parse_loop+4e8/8d0>
Trace; c01a5636 <acpi_ut_acquire_from_cache+66/c0>
Trace; c01a12c6 <acpi_ps_parse_aml+186/190>
Trace; c0193a5e <acpi_ds_execute_arguments+10e/120>
Trace; c0193b65 <acpi_ds_get_region_arguments+35/50>
Trace; c019e472 <acpi_ns_init_one_object+b2/100>
Trace; c019f687 <acpi_ns_walk_namespace+b7/120>
Trace; c019e3c0 <acpi_ns_init_one_object+0/100>
Trace; c019fd99 <acpi_walk_namespace+49/70>
Trace; c019e3c0 <acpi_ns_init_one_object+0/100>
Trace; c019e378 <acpi_ns_initialize_objects+28/30>
Trace; c019e3c0 <acpi_ns_init_one_object+0/100>
Trace; c0190000 <vsnprintf+70/480>
Trace; c0105000 <_stext+0/0>
Trace; c01a7a05 <acpi_enable_subsystem+55/c0>
Trace; c010507f <init+1f/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c01057b6 <kernel_thread+26/30>
Trace; c0105060 <init+0/1c0>

Code;  c019867a <acpi_ex_read_data_from_field+3a/160>
00000000 <_EIP>:
Code;  c019867a <acpi_ex_read_data_from_field+3a/160>   <=====
   0:   f6 40 16 04               testb  $0x4,0x16(%eax)   <=====
Code;  c019867e <acpi_ex_read_data_from_field+3e/160>
   4:   b8 04 00 00 00            mov    $0x4,%eax
Code;  c0198683 <acpi_ex_read_data_from_field+43/160>
   9:   0f 45 d8                  cmovne %eax,%ebx
Code;  c0198686 <acpi_ex_read_data_from_field+46/160>
   c:   39 df                     cmp    %ebx,%edi
Code;  c0198688 <acpi_ex_read_data_from_field+48/160>
   e:   0f 86 a2 00 00 00         jbe    b6 <_EIP+0xb6> c0198730 <acpi_ex_read_data_from_field+f0/160>

 <0>Kernel panic: Attempted to kill init!
-------------------------------------------------------------------------------
-- 
core error - bus dumped

--zYM0uCDKw75PZbzx
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--zYM0uCDKw75PZbzx
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="boot2512.txt.gz"
Content-Transfer-Encoding: base64

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

--zYM0uCDKw75PZbzx--
