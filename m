Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129906AbRA1RTE>; Sun, 28 Jan 2001 12:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129445AbRA1RS4>; Sun, 28 Jan 2001 12:18:56 -0500
Received: from [62.122.6.65] ([62.122.6.65]:9476 "EHLO penny")
	by vger.kernel.org with ESMTP id <S130335AbRA1RSp>;
	Sun, 28 Jan 2001 12:18:45 -0500
To: linux-kernel@vger.kernel.org
Subject: troubles with devfs ?
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 28 Jan 2001 18:21:52 +0100
Message-ID: <87r91nbnin.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This happens on a freshly booted 2.4.0 macine, with devfs and devfsd
running.

I got the oops by doing
# cd /dev
# ls -las
(segmentation fault)

The first oops causes the death of devfsd.


I still can do 
# ls -als /dev/sc*
   0 lr-xr-xr-x    1 root     root            3 Jan 28 18:10 /dev/scd0-> sr0
   0 lr-xr-xr-x    1 root     root            3 Jan 28 18:10 /dev/scd1-> sr1
   0 lr-xr-xr-x    1 root     root            3 Jan 28 18:10 /dev/scd2-> sr2
   0 lr-xr-xr-x    1 root     root            3 Jan 28 18:10 /dev/scd3-> sr3
   0 lr-xr-xr-x    1 root     root            3 Jan 28 18:10 /dev/scd4-> sr4
   0 lr-xr-xr-x    1 root     root            3 Jan 28 18:10 /dev/scd5-> sr5
   0 lr-xr-xr-x    1 root     root            3 Jan 28 18:10 /dev/scd6-> sr6
   0 lr-xr-xr-x    1 root     root            3 Jan 28 18:10 /dev/scd7-> sr7

/dev/scsi:
total 0
   0 drwxr-xr-x    1 root     root            0 Jan  1  1970 .
   0 drwxr-xr-x    1 root     root            0 Jan  1  1970 ..
   0 drwxr-xr-x    1 root     root            0 Jan  1  1970 host0

or whatever else... Just "ls /dev" doesn't work any more.

It worked until ... er...  a few days ago, I suppose. I've updated a bunch
of libraries in the meantime, including libc.



ksymoops complains about System.map not matching the kernel, but I'm
sure it comes from the same compilation.


--------------------------------------------------------------------

ksymoops 2.3.7 on i686 2.4.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /boot/System.map-2.4.0 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol acpi_clear_event_R__ver_acpi_clear_event not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_cm_memcpy_R__ver_acpi_cm_memcpy not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_cm_memset_R__ver_acpi_cm_memset not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_cm_strncmp_R__ver_acpi_cm_strncmp not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_dbg_layer_R__ver_acpi_dbg_layer not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_dbg_level_R__ver_acpi_dbg_level not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_disable_event_R__ver_acpi_disable_event not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_enable_event_R__ver_acpi_enable_event not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_evaluate_object_R__ver_acpi_evaluate_object not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_current_resources_R__ver_acpi_get_current_resources not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_handle_R__ver_acpi_get_handle not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_name_R__ver_acpi_get_name not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_next_object_R__ver_acpi_get_next_object not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_object_info_R__ver_acpi_get_object_info not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_parent_R__ver_acpi_get_parent not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_possible_resources_R__ver_acpi_get_possible_resources not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_processor_cx_info_R__ver_acpi_get_processor_cx_info not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_processor_throttling_info_R__ver_acpi_get_processor_throttling_info not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_processor_throttling_state_R__ver_acpi_get_processor_throttling_state not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_type_R__ver_acpi_get_type not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_install_address_space_handler_R__ver_acpi_install_address_space_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_install_gpe_handler_R__ver_acpi_install_gpe_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_install_notify_handler_R__ver_acpi_install_notify_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_breakpoint_R__ver_acpi_os_breakpoint not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_callocate_R__ver_acpi_os_callocate not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_free_R__ver_acpi_os_free not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_in8_R__ver_acpi_os_in8 not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_out8_R__ver_acpi_os_out8 not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_printf_R__ver_acpi_os_printf not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_queue_for_execution_R__ver_acpi_os_queue_for_execution not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_sleep_R__ver_acpi_os_sleep not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_sleep_usec_R__ver_acpi_os_sleep_usec not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_processor_sleep_R__ver_acpi_processor_sleep not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_remove_address_space_handler_R__ver_acpi_remove_address_space_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_remove_gpe_handler_R__ver_acpi_remove_gpe_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_remove_notify_handler_R__ver_acpi_remove_notify_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_set_current_resources_R__ver_acpi_set_current_resources not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_set_processor_sleep_state_R__ver_acpi_set_processor_sleep_state not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_set_processor_throttling_state_R__ver_acpi_set_processor_throttling_state not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol debug_print_prefix_R__ver_debug_print_prefix not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol debug_print_raw_R__ver_debug_print_raw not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol function_exit_R__ver_function_exit not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol function_status_exit_R__ver_function_status_exit not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol function_trace_R__ver_function_trace not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol function_value_exit_R__ver_function_value_exit not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c013a9e9
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013a9e9>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010217
eax: 00000000   ebx: c7b8bfa4   ecx: 000006f6   edx: c0307a60
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c7b8bf10
ds: 0018   es: 0018   ss: 0018
Process devfsd (pid: 33, stackpage=c7b8b000)
Stack: c7b8bfa4 00000000 c7c02820 c7b8bfa4 00000000 c015a1e3 c7b8bfa4 00000000
       c7b8a000 c01385d9 c7c02820 c7b8bfa4 c5c47040 c7a88000 00000000 c7b8bfa4
       00000000 00000001 00000000 c7b8bfa8 00000009 c7c02820 c7a88005 00000004
Call Trace: [<c015a1e3>] [<c01385d9>] [<c0138a8c>] [<c012dc02>] [<c0108d5f>]
Code: 80 3f 2f 0f 85 c2 00 00 00 53 e8 b0 d2 ff ff ba 00 e0 ff ff

>>EIP; c013a9e9 <vfs_follow_link+21/15c>   <=====
Trace; c015a1e3 <devfs_follow_link+1f/24>
Trace; c01385d9 <path_walk+6a5/7ac>
Trace; c0138a8c <__user_walk+3c/58>
Trace; c012dc02 <sys_chown+16/48>
Trace; c0108d5f <system_call+33/38>
Code;  c013a9e9 <vfs_follow_link+21/15c>
0000000000000000 <_EIP>:
Code;  c013a9e9 <vfs_follow_link+21/15c>   <=====
   0:   80 3f 2f                  cmpb   $0x2f,(%edi)   <=====
Code;  c013a9ec <vfs_follow_link+24/15c>
   3:   0f 85 c2 00 00 00         jne    cb <_EIP+0xcb> c013aab4 <vfs_follow_link+ec/15c>
Code;  c013a9f2 <vfs_follow_link+2a/15c>
   9:   53                        push   %ebx
Code;  c013a9f3 <vfs_follow_link+2b/15c>
   a:   e8 b0 d2 ff ff            call   ffffd2bf <_EIP+0xffffd2bf> c0137ca8 <path_release+0/3c>
Code;  c013a9f8 <vfs_follow_link+30/15c>
   f:   ba 00 e0 ff ff            mov    $0xffffe000,%edx

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c013a9e9
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013a9e9>]
EFLAGS: 00010217
eax: 00000000   ebx: c2e1dfa4   ecx: 000006f6   edx: c0307a60
esi: c7c02920   edi: 00000000   ebp: 00000000   esp: c2e1df10
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 1065, stackpage=c2e1d000)
Stack: c2e1dfa4 c7c02920 c7c02920 c2e1dfa4 00000000 c015a1e3 c2e1dfa4 00000000
       c2e1c000 c01385d9 c7c02920 c2e1dfa4 c5c47040 c43a2000 00000000 c2e1dfa4
       00000002 00000001 00000002 c0137b0a 00000009 c7c02920 c43a2000 00000004
Call Trace: [<c015a1e3>] [<c01385d9>] [<c0137b0a>] [<c0138a8c>] [<c0135b6e>] [<c0108d5f>]
Code: 80 3f 2f 0f 85 c2 00 00 00 53 e8 b0 d2 ff ff ba 00 e0 ff ff

>>EIP; c013a9e9 <vfs_follow_link+21/15c>   <=====
Trace; c015a1e3 <devfs_follow_link+1f/24>
Trace; c01385d9 <path_walk+6a5/7ac>
Trace; c0137b0a <getname+5a/98>
Trace; c0138a8c <__user_walk+3c/58>
Trace; c0135b6e <sys_stat64+16/78>
Trace; c0108d5f <system_call+33/38>
Code;  c013a9e9 <vfs_follow_link+21/15c>
0000000000000000 <_EIP>:
Code;  c013a9e9 <vfs_follow_link+21/15c>   <=====
   0:   80 3f 2f                  cmpb   $0x2f,(%edi)   <=====
Code;  c013a9ec <vfs_follow_link+24/15c>
   3:   0f 85 c2 00 00 00         jne    cb <_EIP+0xcb> c013aab4 <vfs_follow_link+ec/15c>
Code;  c013a9f2 <vfs_follow_link+2a/15c>
   9:   53                        push   %ebx
Code;  c013a9f3 <vfs_follow_link+2b/15c>
   a:   e8 b0 d2 ff ff            call   ffffd2bf <_EIP+0xffffd2bf> c0137ca8 <path_release+0/3c>
Code;  c013a9f8 <vfs_follow_link+30/15c>
   f:   ba 00 e0 ff ff            mov    $0xffffe000,%edx


46 warnings issued.  Results may not be reliable.






-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.0 #1 Sat Jan 6 14:27:38 CET 2001 i686 unknown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
