Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315268AbSEAAFh>; Tue, 30 Apr 2002 20:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315269AbSEAAFg>; Tue, 30 Apr 2002 20:05:36 -0400
Received: from the-penguin.otak.com ([216.122.56.136]:21632 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S315268AbSEAAFg>; Tue, 30 Apr 2002 20:05:36 -0400
Date: Tue, 30 Apr 2002 17:05:24 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.10 and 2.5.11 not booting
Message-ID: <20020501000524.GA1500@the-penguin.otak.com>
In-Reply-To: <20020429190248.GA3325@the-penguin.otak.com> <20020430130445.B22842@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.5.8-pre1 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones [davej@suse.de] wrote:
<snip>
> This dump is useless to anyone, as the addresses need to be converted
> to symbol names. The EIP being the more important one, followed by the
> call trace.
> 
Here is the new and improved opps run through ksymoops, minus a _lot_ of warnings.! 


unable to handle kernel null pointer deference at address 00000016
c0198147
CPU: 0
EIP: 0010:[<c0198147>] not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010213
EAX: 00000000 EBX: c17p4ac0 ECX: c17fec00 EDX: 00000088
Warning (Oops_set_regs): garbage 'EBX: c17p4ac0 ECX: c17fec00 EDX: 00000088' at end of register line ignored
ESI: 00000004 EDI: 00000008 EBX: c17f4ac0 ESP: c16e7dcc
DS: 0018 ES:0018 SS:0018
Stack: c17f4ac0 effe8bc0 00000000 c17fec00 00000006 c019b52c c17fec00
c16e7e00 c17fed60 c17fec00 00000000 00000000 c019b651 c17fedb0
c17fec00 00000001 effe8bc0 c019ba3b c17fedb0 c17fec00 c16cefc0 effe8c0
call trace: [<c01a0935>] [<c01a6co7>] [<c01a0d1a>] [<c0193pbp>] [<c0194512>]
[<c0194512>] [<c01a6c07>] [<c01a0cfd>] [<c01a0d1a>] [<c01935b6>] [<c01936ca>]
[<c019e08d>] [<c019f18e>] [<c019dff0>] [<c019f8bd>] [<c019dff0>] [,c019dfa6>]
[<c019dff0>] [<c01a73a3>] [<c0105027>] [<c0106fb8>]
code: 81 50 16 80 e2 04 b8 04 00 00 00 84 d2 0f 45 f8 39 fe 76 56


>>EIP; c0198147 <acpi_ex_read_data_from_field+57/150>   <=====

>>EBX; c17f4ac0 <_end+1491e6c/304d63ac>
>>ESP; c16e7dcc <_end+1385178/304d63ac>

Trace; c01a0935 <acpi_ps_parse_loop+595/920>
Trace; c0194512 <acpi_ds_exec_end_op+242/2d0>
Trace; c01a6c07 <acpi_ut_create_generic_state+7/20>
Trace; c01a0cfd <acpi_ps_parse_aml+3d/190>
Trace; c01a0d1a <acpi_ps_parse_aml+5a/190>
Trace; c01935b6 <acpi_ds_execute_arguments+106/120>
Trace; c01936ca <acpi_ds_get_region_arguments+3a/50>
Trace; c019e08d <acpi_ns_init_one_object+9d/e0>
Trace; c019f18e <acpi_ns_walk_namespace+8e/110>
Trace; c019dff0 <acpi_ns_init_one_object+0/e0>
Trace; c019f8bd <acpi_walk_namespace+4d/70>
Trace; c019dff0 <acpi_ns_init_one_object+0/e0>
Trace; c019dff0 <acpi_ns_init_one_object+0/e0>
Trace; c01a73a3 <acpi_enable_subsystem+63/80>
Trace; c0105027 <init+7/120>
Trace; c0106fb8 <kernel_thread+28/40>

Code;  c0198147 <acpi_ex_read_data_from_field+57/150>
00000000 <_EIP>:
Code;  c0198147 <acpi_ex_read_data_from_field+57/150>   <=====
   0:   81 50 16 80 e2 04 b8      adcl   $0xb804e280,0x16(%eax)   <=====
Code;  c019814e <acpi_ex_read_data_from_field+5e/150>
   7:   04 00                     add    $0x0,%al
Code;  c0198150 <acpi_ex_read_data_from_field+60/150>
   9:   00 00                     add    %al,(%eax)
Code;  c0198152 <acpi_ex_read_data_from_field+62/150>
   b:   84 d2                     test   %dl,%dl
Code;  c0198154 <acpi_ex_read_data_from_field+64/150>
   d:   0f 45 f8                  cmovne %eax,%edi
Code;  c0198157 <acpi_ex_read_data_from_field+67/150>
  10:   39 fe                     cmp    %edi,%esi
Code;  c0198159 <acpi_ex_read_data_from_field+69/150>
  12:   76 56                     jbe    6a <_EIP+0x6a> c01981b1 <acpi_ex_read_data_from_field+c1/150>

<0> kernel panic attepted to kill init!

1158 warnings issued.  Results may not be reliable.

-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


