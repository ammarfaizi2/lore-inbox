Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312831AbSDBQ27>; Tue, 2 Apr 2002 11:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312841AbSDBQ2u>; Tue, 2 Apr 2002 11:28:50 -0500
Received: from ma-northadams1b-31.bur.adelphia.net ([24.52.166.31]:4482 "EHLO
	ma-northadams1b-11.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S312831AbSDBQ2k>; Tue, 2 Apr 2002 11:28:40 -0500
Date: Tue, 2 Apr 2002 11:30:49 -0500
From: Eric Buddington <eric@ma-northadams1b-11.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.7 ACPI bug
Message-ID: <20020402113049.A2062@ma-northadams1b-11.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a ksymoops for an ACPI bug in 2.5.7 on an HP Omnibook
4100. The error occurs (repeatably) at boot time.

Share and enjoy.

-Eric

------------------------------------------
ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /packages/linux/2.5.7/PII/boot/System.map (specified)

kernel BUG at slab.c:1153!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0130cae>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013202
eax: 000001f0   ebx: 00000001   ecx: c105f0d0   edx: c0307780
esi: c105f0c0   edi: 000001f0   ebp: c105f0c0   esp: c0ed98fc
ds: 0018   es: 0018   ss: 0018
Stack: 00000113 c0ed9934 c02d0acb c02d0a32 00000000 00000000 00000000 c105f0c0 
       00003246 000001f0 c105f0c0 c01310c1 c105f0c0 000001f0 00100000 c02d3720 
       c02d36a0 00000000 c0ed9963 c1f98860 00000001 00000000 c01dcd1f 00000008 
Call Trace: [<c01310c1>] [<c01dcd1f>] [<c01ba8e8>] [<c01ba767>] [<c01bbe53>] 
   [<c01b321d>] [<c010865a>] [<c01b3210>] [<c010884c>] [<c010ad02>] [<c01dc880> 
   [<c01d6bea>] [<c01dceb1>] [<c01dcd70>] [<c01bb2cc>] [<c01bff9b>] [<c01bffc0> 
   [<c01c033d>] [<c01c075d>] [<c01bfa26>] [<c01bfa37>] [<c01c450c>] [<c01c46bf> 
   [<c01c4bfe>] [<c01b83cb>] [<c01cda73>] [<c01d6ccf>] [<c01b9d83>] [<c01ce166> 
   [<c01cedbc>] [<c01c9780>] [<c01c962e>] [<c01c93ab>] [<c01cc44c>] [<c01b40fe> 
   [<c01dcca5>] [<c01b36a8>] [<c01dcbd0>] [<c01056c6>] [<c01b3630>] 
Code: 0f 0b 81 04 07 03 2b c0 89 7c 24 04 b8 03 00 00 00 81 64 24 

>>EIP; c0130cae <kmem_cache_grow+4e/2a0>   <=====
Trace; c01310c0 <kmalloc+e0/120>
Trace; c01dcd1e <acpi_ec_gpe_handler+5e/a0>
Trace; c01ba8e8 <acpi_ev_gpe_dispatch+68/130>
Trace; c01ba766 <acpi_ev_gpe_detect+b6/e0>
Trace; c01bbe52 <acpi_ev_sci_handler+42/80>
Trace; c01b321c <acpi_irq+c/10>
Trace; c010865a <handle_IRQ_event+3a/80>
Trace; c01b3210 <acpi_irq+0/10>
Trace; c010884c <do_IRQ+8c/110>
Trace; c010ad02 <call_do_IRQ+6/c>
Trace; c01dc880 <acpi_ec_read+d0/170>
Trace; c01d6bea <acpi_ut_trace+2a/30>
Trace; c01dceb0 <acpi_ec_space_handler+140/150>
Trace; c01dcd70 <acpi_ec_space_handler+0/150>
Trace; c01bb2cc <acpi_ev_address_space_dispatch+cc/270>
Trace; c01bff9a <acpi_ex_access_region+ba/170>
Trace; c01bffc0 <acpi_ex_access_region+e0/170>
Trace; c01c033c <acpi_ex_field_datum_io+2ac/2f0>
Trace; c01c075c <acpi_ex_extract_from_field+fc/320>
Trace; c01bfa26 <acpi_ex_read_data_from_field+106/220>
Trace; c01bfa36 <acpi_ex_read_data_from_field+116/220>
Trace; c01c450c <acpi_ex_resolve_node_to_value+29c/3d0>
Trace; c01c46be <acpi_ex_resolve_to_value+7e/e0>
Trace; c01c4bfe <acpi_ex_resolve_operands+14e/720>
Trace; c01b83ca <acpi_ds_exec_end_op+2ea/410>
Trace; c01cda72 <acpi_ps_parse_loop+592/a40>
Trace; c01d6cce <acpi_ut_exit+1e/30>
Trace; c01b9d82 <acpi_ds_delete_walk_state+112/120>
Trace; c01ce166 <acpi_ps_parse_aml+246/270>
Trace; c01cedbc <acpi_psx_execute+1fc/300>
Trace; c01c9780 <acpi_ns_execute_control_method+e0/130>
Trace; c01c962e <acpi_ns_evaluate_by_handle+de/150>
Trace; c01c93aa <acpi_ns_evaluate_relative+15a/1b0>
Trace; c01cc44c <acpi_evaluate_object+24c/2d0>
Trace; c01b40fe <acpi_evaluate+8e/1e0>
Trace; c01dcca4 <acpi_ec_gpe_query+d4/f0>
Trace; c01b36a8 <acpi_os_queue_exec+78/a0>
Trace; c01dcbd0 <acpi_ec_gpe_query+0/f0>
Trace; c01056c6 <kernel_thread+26/30>
Trace; c01b3630 <acpi_os_queue_exec+0/a0>
Code;  c0130cae <kmem_cache_grow+4e/2a0>
00000000 <_EIP>:
Code;  c0130cae <kmem_cache_grow+4e/2a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0130cb0 <kmem_cache_grow+50/2a0>
   2:   81 04 07 03 2b c0 89      addl   $0x89c02b03,(%edi,%eax,1)
Code;  c0130cb6 <kmem_cache_grow+56/2a0>
   9:   7c 24                     jl     2f <_EIP+0x2f> c0130cdc <kmem_cache_gro
w+7c/2a0>
Code;  c0130cb8 <kmem_cache_grow+58/2a0>
   b:   04 b8                     add    $0xb8,%al
Code;  c0130cba <kmem_cache_grow+5a/2a0>
   d:   03 00                     add    (%eax),%eax
Code;  c0130cbc <kmem_cache_grow+5c/2a0>
   f:   00 00                     add    %al,(%eax)
Code;  c0130cbe <kmem_cache_grow+5e/2a0>
  11:   81 64 24 00 00 00 00      andl   $0x0,0x0(%esp,1)
Code;  c0130cc6 <kmem_cache_grow+66/2a0>
  18:   00 

 <0>Kernel panic: Aiee, killing interrupt handler!
