Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUFEAer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUFEAer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 20:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266119AbUFEAer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 20:34:47 -0400
Received: from ms-1.rz.RWTH-Aachen.DE ([134.130.3.130]:9708 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S266115AbUFEAeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 20:34:44 -0400
Date: Sat, 05 Jun 2004 02:18:09 +0200
From: Sebastian Ley <ley@debian.org>
Subject: modprobe acpi segfaults
To: linux-kernel@vger.kernel.org
Message-id: <200406050218.09909.ley@debian.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

please CC me on replies as I am not subscribed, thank you.

I am running a Debian 2.6.6 kernel on a ASUS S5200N notebook. When I try to 
modprobe acpi I get a segmentation fault. dmesg output is:

-------------------------------->8-----------------------------------

Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c01af5b9
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c01af5b9>]    Not tainted
EFLAGS: 00210246   (2.6.6-1-686)
EIP is at acpi_ds_execute_arguments+0x91/0x118
eax: 00000000   ebx: 00000000   ecx: 00000009   edx: 00000001
esi: dd4b7000   edi: defb0d7c   ebp: d824681c   esp: d2af7c40
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2954, threadinfo=d2af6000 task=d3425350)
Stack: dd829584 d824681c 00000000 dea4a9b8 c01af6bb d824681c d824681c 00000000
       00000000 dd829584 c01b8e77 dd829584 00000000 dea4a9b8 dea4a800 d824681c
       00000000 c01b4c7b dea4a9b8 dea4a800 00000003 00000008 c01b6efc dea4a9b8
Call Trace:
 [<c01af6bb>] acpi_ds_get_buffer_arguments+0x49/0x4e
 [<c01b8e77>] acpi_ex_resolve_node_to_value+0x87/0xdc
 [<c01b4c7b>] acpi_ex_resolve_to_value+0x3b/0x46
 [<c01b6efc>] acpi_ex_resolve_operands+0x1ca/0x316
 [<c01af8ff>] acpi_ds_eval_buffer_field_operands+0x46/0x9c
 [<c01b0008>] acpi_ds_exec_end_op+0x15f/0x26b
 [<c01bd5e4>] acpi_ps_parse_loop+0x546/0x85f
 [<c01bd94b>] acpi_ps_parse_aml+0x4e/0x1af
 [<c01be1f6>] acpi_psx_execute+0x142/0x19c
 [<c01bb5c0>] acpi_ns_execute_control_method+0x43/0x52
 [<c01bb559>] acpi_ns_evaluate_by_handle+0x81/0xa5
 [<c01bb433>] acpi_ns_evaluate_relative+0xab/0xc9
 [<c01bad10>] acpi_evaluate_object+0x10f/0x1d1
 [<e04826a3>] acpi_processor_set_pdc+0x73/0x79 [processor]
 [<e048296a>] acpi_processor_get_performance_info+0x4a/0x71 [processor]
 [<e0482a0b>] acpi_processor_register_performance+0x78/0xb6 [processor]
 [<e0acf3c2>] acpi_cpufreq_cpu_init+0x62/0x320 [acpi]
 [<c010871b>] do_IRQ+0xfb/0x130
 [<c01069e8>] common_interrupt+0x18/0x20
 [<c0208521>] cpufreq_add_dev+0xd1/0x2b0
 [<c014cf98>] vfree+0x28/0x40
 [<c0131ab1>] load_module+0x831/0xab0
 [<c01ee555>] sysdev_driver_register+0x85/0xd0
 [<c0209216>] cpufreq_register_driver+0x86/0x120
 [<e0ac400f>] acpi_cpufreq_init+0xf/0x11 [acpi]
 [<c0131e30>] sys_init_module+0x100/0x210
 [<c010607b>] syscall_call+0x7/0xb

Code: 89 68 10 57 e8 c1 e7 00 00 6a 37 e8 0e ea 00 00 5e 89 c7 85

--------------------------------------8<-----------------------------

Let me know if you need to know more or if I can do something to investigste 
this.

Thanks and regards,
Sebastian

