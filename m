Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTJZMRg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 07:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTJZMRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 07:17:36 -0500
Received: from web40907.mail.yahoo.com ([66.218.78.204]:36915 "HELO
	web40907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263071AbTJZMR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 07:17:27 -0500
Message-ID: <20031026121726.47887.qmail@web40907.mail.yahoo.com>
Date: Sun, 26 Oct 2003 04:17:26 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: [WARNING WARNING] Lots and Lots of ACPI Debug Messages with 2.6.0-test9!
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a rude wakeup call when I checked my logs after booting 2.6.0-test9. I have
gotten so many debug messages that the dmesg is overflowing with them!

Here is the current dmesg output:

Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c01218ee>] __might_sleep+0xab/0xcd
 [<c0153355>] __kmalloc+0x204/0x216
 [<c021adba>] acpi_os_allocate+0xe/0x11
 [<c022ea61>] acpi_ut_callocate+0x3c/0x7b
 [<c02283bd>] acpi_ns_internalize_name+0x3b/0x77
 [<c028e85a>] atapi_output_bytes+0x3b/0x7c
 [<c0227d07>] acpi_ns_evaluate_relative+0x2f/0xb4
 [<c0226686>] acpi_hw_low_level_read+0x9a/0x9f
 [<c0226686>] acpi_hw_low_level_read+0x9a/0x9f
 [<c02275b2>] acpi_evaluate_object+0x75/0x1d7
 [<c023347b>] acpi_ec_gpe_query+0x180/0x1e6
 [<c0220667>] acpi_ev_gpe_dispatch+0x101/0x122
 [<c02204a6>] acpi_ev_gpe_detect+0x10e/0x116
 [<c021f035>] acpi_ev_sci_xrupt_handler+0x11/0x18
 [<c021aee6>] acpi_irq+0xc/0x16
 [<c010c5e1>] handle_IRQ_event+0x3a/0x64
 [<c021aeda>] acpi_irq+0x0/0x16
 [<c010cbdd>] do_IRQ+0x137/0x39b
 [<c01307b9>] update_process_times+0x46/0x52
 [<c0130633>] update_wall_time+0xd/0x36
 [<c010ab38>] common_interrupt+0x18/0x20
 [<c012b0b8>] do_softirq+0x40/0x97
 [<c010ccf2>] do_IRQ+0x24c/0x39b
 [<c0226686>] acpi_hw_low_level_read+0x9a/0x9f
 [<c010ab38>] common_interrupt+0x18/0x20
 [<c023007b>] acpi_ut_copy_simple_object+0xb7/0xee
 [<c0232fce>] acpi_ec_write+0xf3/0x1e9
 [<c02335b9>] acpi_ec_space_handler+0x86/0xa7
 [<c0233533>] acpi_ec_space_handler+0x0/0xa7
 [<c021edfd>] acpi_ev_address_space_dispatch+0xd7/0x14f
 [<c0222543>] acpi_ex_access_region+0x4a/0x4f
 [<c02226ea>] acpi_ex_field_datum_io+0x167/0x185
 [<c02227a1>] acpi_ex_write_with_update_rule+0x99/0x102
 [<c0222be0>] acpi_ex_insert_into_field+0xfe/0x276
 [<c0221472>] acpi_ex_write_data_to_field+0xdd/0x237
 [<c0225323>] acpi_ex_store_object_to_node+0x50/0x8d
 [<c0222f00>] acpi_ex_opcode_1A_1T_1R+0xc7/0x53d
 [<c0223abf>] acpi_ex_resolve_operands+0xf4/0x359
 [<c021cfa8>] acpi_ds_exec_end_op+0x23a/0x242
 [<c0229e4c>] acpi_ps_parse_loop+0x39f/0x883
 [<c022f77d>] acpi_ut_acquire_mutex+0x4b/0x6d
 [<c022e7d8>] acpi_ut_release_to_cache+0x24/0x85
 [<c022f7f6>] acpi_ut_release_mutex+0x57/0x6e
 [<c022f93a>] acpi_ut_delete_generic_state+0xb/0xe
 [<c0230514>] acpi_ut_update_object_reference+0xa9/0x24b
 [<c02306f7>] acpi_ut_remove_reference+0x23/0x28
 [<c021d326>] acpi_ds_call_control_method+0x154/0x16f
 [<c022a4d1>] acpi_ps_parse_aml+0x1a1/0x1ac
 [<c022ac84>] acpi_psx_execute+0x140/0x1a8
 [<c0227ee3>] acpi_ns_execute_control_method+0x37/0x54
 [<c0227e98>] acpi_ns_evaluate_by_handle+0x81/0x95
 [<c0227d76>] acpi_ns_evaluate_relative+0x9e/0xb4
 [<c02275b2>] acpi_evaluate_object+0x75/0x1d7
 [<c015b555>] zap_pmd_range+0x47/0x63
 [<c0231b3a>] acpi_battery_get_info+0x62/0x11b
 [<c0231f2e>] acpi_battery_read_info+0xa4/0x277
 [<c0231e8a>] acpi_battery_read_info+0x0/0x277
 [<c01b8100>] proc_file_read+0xd7/0x28f
 [<c017265c>] vfs_read+0xbc/0x127
 [<c01728e7>] sys_read+0x42/0x63
 [<c010a179>] sysenter_past_esp+0x52/0x71

    ACPI-0094: *** Error: Could not acquire interpreter mutex
Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c01218ee>] __might_sleep+0xab/0xcd
 [<c0153355>] __kmalloc+0x204/0x216
 [<c0225d5a>] acpi_hw_enable_gpe+0x3a/0x3f
 [<c021adba>] acpi_os_allocate+0xe/0x11
 [<c022ea61>] acpi_ut_callocate+0x3c/0x7b
 [<c02283bd>] acpi_ns_internalize_name+0x3b/0x77
 [<c0227d07>] acpi_ns_evaluate_relative+0x2f/0xb4
 [<c0226686>] acpi_hw_low_level_read+0x9a/0x9f
 [<c0226686>] acpi_hw_low_level_read+0x9a/0x9f
 [<c02275b2>] acpi_evaluate_object+0x75/0x1d7
 [<c023347b>] acpi_ec_gpe_query+0x180/0x1e6
 [<c0220667>] acpi_ev_gpe_dispatch+0x101/0x122
 [<c02204a6>] acpi_ev_gpe_detect+0x10e/0x116
 [<c021f035>] acpi_ev_sci_xrupt_handler+0x11/0x18
 [<c021aee6>] acpi_irq+0xc/0x16
 [<c010c5e1>] handle_IRQ_event+0x3a/0x64
 [<c021aeda>] acpi_irq+0x0/0x16
 [<c010cbdd>] do_IRQ+0x137/0x39b
 [<c0226686>] acpi_hw_low_level_read+0x9a/0x9f
 [<c010ab38>] common_interrupt+0x18/0x20
 [<c0232de9>] acpi_ec_read+0xfd/0x1ef
 [<c02335cb>] acpi_ec_space_handler+0x98/0xa7
 [<c0233533>] acpi_ec_space_handler+0x0/0xa7
 [<c021edfd>] acpi_ev_address_space_dispatch+0xd7/0x14f
 [<c0222543>] acpi_ex_access_region+0x4a/0x4f
 [<c02226ea>] acpi_ex_field_datum_io+0x167/0x185
 [<c022292f>] acpi_ex_extract_from_field+0x88/0x23b
 [<c02212a0>] acpi_ex_read_data_from_field+0x74/0x169
 [<c0225ac9>] acpi_ex_resolve_node_to_value+0xb1/0xe0
 [<c0221ad3>] acpi_ex_resolve_to_value+0x33/0x4a
 [<c0223a89>] acpi_ex_resolve_operands+0xbe/0x359
 [<c021cf8b>] acpi_ds_exec_end_op+0x21d/0x242
 [<c0229e4c>] acpi_ps_parse_loop+0x39f/0x883
 [<c022f77d>] acpi_ut_acquire_mutex+0x4b/0x6d
 [<c022e7d8>] acpi_ut_release_to_cache+0x24/0x85
 [<c022f7f6>] acpi_ut_release_mutex+0x57/0x6e
 [<c022f93a>] acpi_ut_delete_generic_state+0xb/0xe
 [<c0230514>] acpi_ut_update_object_reference+0xa9/0x24b
 [<c02306f7>] acpi_ut_remove_reference+0x23/0x28
 [<c021d326>] acpi_ds_call_control_method+0x154/0x16f
 [<c022a4d1>] acpi_ps_parse_aml+0x1a1/0x1ac
 [<c022ac84>] acpi_psx_execute+0x140/0x1a8
 [<c0227ee3>] acpi_ns_execute_control_method+0x37/0x54
 [<c0227e98>] acpi_ns_evaluate_by_handle+0x81/0x95
 [<c0227d76>] acpi_ns_evaluate_relative+0x9e/0xb4
 [<c02275b2>] acpi_evaluate_object+0x75/0x1d7
 [<c015b555>] zap_pmd_range+0x47/0x63
 [<c0231b3a>] acpi_battery_get_info+0x62/0x11b
 [<c0231f2e>] acpi_battery_read_info+0xa4/0x277
 [<c0231e8a>] acpi_battery_read_info+0x0/0x277
 [<c01b8100>] proc_file_read+0xd7/0x28f
 [<c017265c>] vfs_read+0xbc/0x127
 [<c01728e7>] sys_read+0x42/0x63
 [<c010a179>] sysenter_past_esp+0x52/0x71

Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c01218ee>] __might_sleep+0xab/0xcd
 [<c0153355>] __kmalloc+0x204/0x216
 [<c021adba>] acpi_os_allocate+0xe/0x11
 [<c022ea61>] acpi_ut_callocate+0x3c/0x7b
 [<c02283bd>] acpi_ns_internalize_name+0x3b/0x77
 [<c0227d07>] acpi_ns_evaluate_relative+0x2f/0xb4
 [<c0226686>] acpi_hw_low_level_read+0x9a/0x9f
 [<c010ab38>] common_interrupt+0x18/0x20
 [<c02275b2>] acpi_evaluate_object+0x75/0x1d7
 [<c0233226>] acpi_ec_query+0xec/0x1c1
 [<c023347b>] acpi_ec_gpe_query+0x180/0x1e6
 [<c0220667>] acpi_ev_gpe_dispatch+0x101/0x122
 [<c02204a6>] acpi_ev_gpe_detect+0x10e/0x116
 [<c021f035>] acpi_ev_sci_xrupt_handler+0x11/0x18
 [<c021aee6>] acpi_irq+0xc/0x16
 [<c010c5e1>] handle_IRQ_event+0x3a/0x64
 [<c021aeda>] acpi_irq+0x0/0x16
 [<c010cbdd>] do_IRQ+0x137/0x39b
 [<c01307b9>] update_process_times+0x46/0x52
 [<c0130633>] update_wall_time+0xd/0x36
 [<c010ab38>] common_interrupt+0x18/0x20
 [<c012b0b8>] do_softirq+0x40/0x97
 [<c010ccf2>] do_IRQ+0x24c/0x39b
 [<c0226686>] acpi_hw_low_level_read+0x9a/0x9f
 [<c010ab38>] common_interrupt+0x18/0x20
 [<c023007b>] acpi_ut_copy_simple_object+0xb7/0xee
 [<c0232fce>] acpi_ec_write+0xf3/0x1e9
 [<c02335b9>] acpi_ec_space_handler+0x86/0xa7
 [<c0233533>] acpi_ec_space_handler+0x0/0xa7
 [<c021edfd>] acpi_ev_address_space_dispatch+0xd7/0x14f
 [<c0222543>] acpi_ex_access_region+0x4a/0x4f
 [<c02226ea>] acpi_ex_field_datum_io+0x167/0x185
 [<c02227a1>] acpi_ex_write_with_update_rule+0x99/0x102
 [<c0222be0>] acpi_ex_insert_into_field+0xfe/0x276
 [<c0221472>] acpi_ex_write_data_to_field+0xdd/0x237
 [<c0225323>] acpi_ex_store_object_to_node+0x50/0x8d
 [<c0222f00>] acpi_ex_opcode_1A_1T_1R+0xc7/0x53d
 [<c0223abf>] acpi_ex_resolve_operands+0xf4/0x359
 [<c021cfa8>] acpi_ds_exec_end_op+0x23a/0x242
 [<c0229e4c>] acpi_ps_parse_loop+0x39f/0x883
 [<c022f77d>] acpi_ut_acquire_mutex+0x4b/0x6d
 [<c022e7d8>] acpi_ut_release_to_cache+0x24/0x85
 [<c022f7f6>] acpi_ut_release_mutex+0x57/0x6e
 [<c022f93a>] acpi_ut_delete_generic_state+0xb/0xe
 [<c0230514>] acpi_ut_update_object_reference+0xa9/0x24b
 [<c02306f7>] acpi_ut_remove_reference+0x23/0x28
 [<c021d326>] acpi_ds_call_control_method+0x154/0x16f
 [<c022a4d1>] acpi_ps_parse_aml+0x1a1/0x1ac
 [<c022ac84>] acpi_psx_execute+0x140/0x1a8
 [<c0227ee3>] acpi_ns_execute_control_method+0x37/0x54
 [<c0227e98>] acpi_ns_evaluate_by_handle+0x81/0x95
 [<c0227d76>] acpi_ns_evaluate_relative+0x9e/0xb4
 [<c02275b2>] acpi_evaluate_object+0x75/0x1d7
 [<c015b555>] zap_pmd_range+0x47/0x63
 [<c0231b3a>] acpi_battery_get_info+0x62/0x11b
 [<c0231f2e>] acpi_battery_read_info+0xa4/0x277
 [<c0231e8a>] acpi_battery_read_info+0x0/0x277
 [<c01b8100>] proc_file_read+0xd7/0x28f
 [<c017265c>] vfs_read+0xbc/0x127
 [<c01728e7>] sys_read+0x42/0x63
 [<c010a179>] sysenter_past_esp+0x52/0x71

Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c01218ee>] __might_sleep+0xab/0xcd
 [<c0153355>] __kmalloc+0x204/0x216
 [<c021adba>] acpi_os_allocate+0xe/0x11
 [<c022ea61>] acpi_ut_callocate+0x3c/0x7b
 [<c02283bd>] acpi_ns_internalize_name+0x3b/0x77
 [<c0227d07>] acpi_ns_evaluate_relative+0x2f/0xb4
 [<c0226686>] acpi_hw_low_level_read+0x9a/0x9f
 [<c010ab38>] common_interrupt+0x18/0x20
 [<c02275b2>] acpi_evaluate_object+0x75/0x1d7
 [<c0233226>] acpi_ec_query+0xec/0x1c1
 [<c023347b>] acpi_ec_gpe_query+0x180/0x1e6
 [<c0220667>] acpi_ev_gpe_dispatch+0x101/0x122
 [<c02204a6>] acpi_ev_gpe_detect+0x10e/0x116
 [<c021f035>] acpi_ev_sci_xrupt_handler+0x11/0x18
 [<c021aee6>] acpi_irq+0xc/0x16
 [<c010c5e1>] handle_IRQ_event+0x3a/0x64
 [<c021aeda>] acpi_irq+0x0/0x16
 [<c010cbdd>] do_IRQ+0x137/0x39b
 [<c0226686>] acpi_hw_low_level_read+0x9a/0x9f
 [<c010ab38>] common_interrupt+0x18/0x20
 [<c023007b>] acpi_ut_copy_simple_object+0xb7/0xee
 [<c0232fce>] acpi_ec_write+0xf3/0x1e9
 [<c02335b9>] acpi_ec_space_handler+0x86/0xa7
 [<c0233533>] acpi_ec_space_handler+0x0/0xa7
 [<c021edfd>] acpi_ev_address_space_dispatch+0xd7/0x14f
 [<c0222543>] acpi_ex_access_region+0x4a/0x4f
 [<c02226ea>] acpi_ex_field_datum_io+0x167/0x185
 [<c02227a1>] acpi_ex_write_with_update_rule+0x99/0x102
 [<c0222be0>] acpi_ex_insert_into_field+0xfe/0x276
 [<c0221472>] acpi_ex_write_data_to_field+0xdd/0x237
 [<c0225323>] acpi_ex_store_object_to_node+0x50/0x8d
 [<c0222f00>] acpi_ex_opcode_1A_1T_1R+0xc7/0x53d
 [<c0223abf>] acpi_ex_resolve_operands+0xf4/0x359
 [<c021cfa8>] acpi_ds_exec_end_op+0x23a/0x242
 [<c0229e4c>] acpi_ps_parse_loop+0x39f/0x883
 [<c022f77d>] acpi_ut_acquire_mutex+0x4b/0x6d
 [<c022e7d8>] acpi_ut_release_to_cache+0x24/0x85
 [<c022f7f6>] acpi_ut_release_mutex+0x57/0x6e
 [<c022f93a>] acpi_ut_delete_generic_state+0xb/0xe
 [<c0230514>] acpi_ut_update_object_reference+0xa9/0x24b
 [<c02306f7>] acpi_ut_remove_reference+0x23/0x28
 [<c021d326>] acpi_ds_call_control_method+0x154/0x16f
 [<c022a4d1>] acpi_ps_parse_aml+0x1a1/0x1ac
 [<c022ac84>] acpi_psx_execute+0x140/0x1a8
 [<c0227ee3>] acpi_ns_execute_control_method+0x37/0x54
 [<c0227e98>] acpi_ns_evaluate_by_handle+0x81/0x95
 [<c0227d76>] acpi_ns_evaluate_relative+0x9e/0xb4
 [<c02275b2>] acpi_evaluate_object+0x75/0x1d7
 [<c015b555>] zap_pmd_range+0x47/0x63
 [<c0231b3a>] acpi_battery_get_info+0x62/0x11b
 [<c0231f2e>] acpi_battery_read_info+0xa4/0x277
 [<c0231e8a>] acpi_battery_read_info+0x0/0x277
 [<c01b8100>] proc_file_read+0xd7/0x28f
 [<c017265c>] vfs_read+0xbc/0x127
 [<c01728e7>] sys_read+0x42/0x63
 [<c010a179>] sysenter_past_esp+0x52/0x71

Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c01218ee>] __might_sleep+0xab/0xcd
 [<c0153355>] __kmalloc+0x204/0x216
 [<c021adba>] acpi_os_allocate+0xe/0x11
 [<c022ea61>] acpi_ut_callocate+0x3c/0x7b
 [<c02283bd>] acpi_ns_internalize_name+0x3b/0x77
 [<c0227d07>] acpi_ns_evaluate_relative+0x2f/0xb4
 [<c0226686>] acpi_hw_low_level_read+0x9a/0x9f
 [<c010ab38>] common_interrupt+0x18/0x20
 [<c02275b2>] acpi_evaluate_object+0x75/0x1d7
 [<c0233226>] acpi_ec_query+0xec/0x1c1
 [<c023347b>] acpi_ec_gpe_query+0x180/0x1e6
 [<c0220667>] acpi_ev_gpe_dispatch+0x101/0x122
 [<c02204a6>] acpi_ev_gpe_detect+0x10e/0x116
 [<c021f035>] acpi_ev_sci_xrupt_handler+0x11/0x18
 [<c021aee6>] acpi_irq+0xc/0x16
 [<c010c5e1>] handle_IRQ_event+0x3a/0x64
 [<c021aeda>] acpi_irq+0x0/0x16
 [<c010cbdd>] do_IRQ+0x137/0x39b
 [<c0226686>] acpi_hw_low_level_read+0x9a/0x9f
 [<c010ab38>] common_interrupt+0x18/0x20
 [<c023007b>] acpi_ut_copy_simple_object+0xb7/0xee
 [<c0232fce>] acpi_ec_write+0xf3/0x1e9
 [<c02335b9>] acpi_ec_space_handler+0x86/0xa7
 [<c0233533>] acpi_ec_space_handler+0x0/0xa7
 [<c021edfd>] acpi_ev_address_space_dispatch+0xd7/0x14f
 [<c0222543>] acpi_ex_access_region+0x4a/0x4f
 [<c02226ea>] acpi_ex_field_datum_io+0x167/0x185
 [<c02227a1>] acpi_ex_write_with_update_rule+0x99/0x102
 [<c0222be0>] acpi_ex_insert_into_field+0xfe/0x276
 [<c0221472>] acpi_ex_write_data_to_field+0xdd/0x237
 [<c0225323>] acpi_ex_store_object_to_node+0x50/0x8d
 [<c0222f00>] acpi_ex_opcode_1A_1T_1R+0xc7/0x53d
 [<c0223abf>] acpi_ex_resolve_operands+0xf4/0x359
 [<c021cfa8>] acpi_ds_exec_end_op+0x23a/0x242
 [<c0229e4c>] acpi_ps_parse_loop+0x39f/0x883
 [<c022f77d>] acpi_ut_acquire_mutex+0x4b/0x6d
 [<c022e7d8>] acpi_ut_release_to_cache+0x24/0x85
 [<c022f7f6>] acpi_ut_release_mutex+0x57/0x6e
 [<c022f93a>] acpi_ut_delete_generic_state+0xb/0xe
 [<c0230514>] acpi_ut_update_object_reference+0xa9/0x24b
 [<c02306f7>] acpi_ut_remove_reference+0x23/0x28
 [<c021d326>] acpi_ds_call_control_method+0x154/0x16f
 [<c022a4d1>] acpi_ps_parse_aml+0x1a1/0x1ac
 [<c022ac84>] acpi_psx_execute+0x140/0x1a8
 [<c0227ee3>] acpi_ns_execute_control_method+0x37/0x54
 [<c0227e98>] acpi_ns_evaluate_by_handle+0x81/0x95
 [<c0227d76>] acpi_ns_evaluate_relative+0x9e/0xb4
 [<c02275b2>] acpi_evaluate_object+0x75/0x1d7
 [<c015b555>] zap_pmd_range+0x47/0x63
 [<c0231b3a>] acpi_battery_get_info+0x62/0x11b
 [<c0231f2e>] acpi_battery_read_info+0xa4/0x277
 [<c0231e8a>] acpi_battery_read_info+0x0/0x277
 [<c01b8100>] proc_file_read+0xd7/0x28f
 [<c017265c>] vfs_read+0xbc/0x127
 [<c01728e7>] sys_read+0x42/0x63
 [<c010a179>] sysenter_past_esp+0x52/0x71

Shutting down applications which access the ACPI subsystem via /proc (gkrellm
and akpi) do not cause the debug messages to cease; syslogd is getting them from
klogd approximately once a minute!

Is there a way to fix this?

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
