Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268916AbTGJFHf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 01:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268931AbTGJFHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 01:07:34 -0400
Received: from co239024-a.almel1.ov.home.nl ([217.120.226.100]:2180 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268916AbTGJFGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 01:06:47 -0400
Date: Thu, 10 Jul 2003 07:23:32 +0200 (CEST)
From: Aschwin Marsman <a.marsman@aYniK.com>
X-X-Sender: marsman@localhost.localdomain
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre4
In-Reply-To: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0307100717570.18695-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003, Marcelo Tosatti wrote:

> Hi,
> 
> Here goes -pre4. It contains a lot of updates and fixes.
> 
> We decided to include this new code quota code which allows usage of
> quotas with 32bit UID/GIDs.
> 
> Most Toshibas should work now due to an important ACPI fix.
> 
> Please help and test.

I use -pre3 with succes, only power down is currently not working
(only the discs shutdown, no real poweroff). That's why I disabled
apm and enabled apm in the kernel with -pre4, but that gives:

cd /lib/modules/2.4.21; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.21; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.21/kernel/drivers/acpi/ospm/ac_adapter/ospm_ac_adapter.o
depmod:         bm_osl_generate_event_R7dc74281
depmod:         acpi_os_free_R43b9bbb4
depmod:         acpi_get_name_R739160a5
depmod:         acpi_ut_status_exit_R0b687984
depmod:         acpi_ut_trace_R8d457864
depmod:         bm_get_device_info_Rfaeb2303
depmod:         bm_register_driver_R53392fa7
depmod:         acpi_os_callocate_R112250e2
depmod:         bm_evaluate_simple_integer_R24e881a5
depmod:         acpi_ut_debug_print_raw_Re9aabc61
depmod:         acpi_ut_debug_print_Rac38b5ca
depmod:         bm_unregister_driver_R40fde1ec
depmod:         acpi_get_object_info_R1f1c0bf5
depmod:         bm_proc_root_R4cd2bdc3
depmod: *** Unresolved symbols in /lib/modules/2.4.21/kernel/drivers/acpi/ospm/battery/ospm_battery.o
depmod:         bm_osl_generate_event_R7dc74281
depmod:         bm_evaluate_object_Rba8b2406
depmod:         bm_extract_package_data_R4f1d6ef7
depmod:         acpi_os_free_R43b9bbb4
depmod:         acpi_get_name_R739160a5
depmod:         acpi_ut_status_exit_R0b687984
depmod:         acpi_ut_trace_R8d457864
depmod:         bm_get_device_info_Rfaeb2303
depmod:         bm_get_device_status_R336289aa
depmod:         bm_register_driver_R53392fa7
depmod:         acpi_os_callocate_R112250e2
depmod:         acpi_ut_debug_print_raw_Re9aabc61
depmod:         acpi_ut_debug_print_Rac38b5ca
depmod:         bm_unregister_driver_R40fde1ec
depmod:         bm_cast_buffer_Rb5d8e04e
depmod:         bm_proc_root_R4cd2bdc3
depmod: *** Unresolved symbols in /lib/modules/2.4.21/kernel/drivers/acpi/ospm/button/ospm_button.o
depmod:         bm_osl_generate_event_R7dc74281
depmod:         acpi_os_free_R43b9bbb4
depmod:         acpi_remove_fixed_event_handler_R2005e68a
depmod:         acpi_get_name_R739160a5
depmod:         acpi_ut_status_exit_R0b687984
depmod:         acpi_ut_trace_R8d457864
depmod:         bm_get_device_info_Rfaeb2303
depmod:         bm_register_driver_R53392fa7
depmod:         acpi_os_callocate_R112250e2
depmod:         acpi_ut_debug_print_raw_Re9aabc61
depmod:         acpi_ut_debug_print_Rac38b5ca
depmod:         bm_unregister_driver_R40fde1ec
depmod:         acpi_install_fixed_event_handler_R5ac376a5
depmod:         bm_proc_root_R4cd2bdc3
depmod: *** Unresolved symbols in /lib/modules/2.4.21/kernel/drivers/acpi/ospm/ec/ospm_ec.o
depmod:         acpi_os_create_semaphore_R9f8733e2
depmod:         bm_evaluate_object_Rba8b2406
depmod:         acpi_ut_exit_R4403d3ee
depmod:         acpi_os_write_port_R09b33830
depmod:         acpi_os_printf_R3f6e4e15
depmod:         acpi_remove_gpe_handler_Rb73b58d2
depmod:         acpi_os_free_R43b9bbb4
depmod:         acpi_get_name_R739160a5
depmod:         acpi_ut_status_exit_R0b687984
depmod:         acpi_acquire_global_lock_R4c66e50f
depmod:         acpi_ut_trace_R8d457864
depmod:         acpi_os_delete_semaphore_Re65a005c
depmod:         bm_get_device_info_Rfaeb2303
depmod:         bm_register_driver_R53392fa7
depmod:         acpi_remove_address_space_handler_Re1d5f864
depmod:         acpi_os_read_port_Rba23b567
depmod:         acpi_install_address_space_handler_Re37edf75
depmod:         acpi_os_callocate_R112250e2
depmod:         acpi_os_stall_R69005013
depmod:         bm_evaluate_simple_integer_R24e881a5
depmod:         acpi_os_wait_semaphore_R21625bfa
depmod:         acpi_release_global_lock_Rfe5dad1b
depmod:         acpi_install_gpe_handler_Raca91f91
depmod:         acpi_ut_debug_print_raw_Re9aabc61
depmod:         acpi_os_signal_semaphore_R8cdbc08d
depmod:         acpi_os_queue_for_execution_R173029e0
depmod:         acpi_ut_debug_print_Rac38b5ca
depmod:         bm_unregister_driver_R40fde1ec
depmod:         acpi_get_current_resources_R2cd1ca5d
depmod:         bm_cast_buffer_Rb5d8e04e
depmod:         bm_proc_root_R4cd2bdc3
depmod: *** Unresolved symbols in /lib/modules/2.4.21/kernel/drivers/acpi/ospm/processor/ospm_processor.o
depmod:         acpi_get_timer_duration_Rf0e32829
depmod:         acpi_get_timer_Rc632950f
depmod:         bm_osl_generate_event_R7dc74281
depmod:         bm_copy_to_buffer_R7c44a383
depmod:         acpi_os_write_port_R09b33830
depmod:         acpi_os_free_R43b9bbb4
depmod:         acpi_get_name_R739160a5
depmod:         acpi_ut_status_exit_R0b687984
depmod:         acpi_hw_register_bit_access_R5477a41e
depmod:         acpi_ut_trace_R8d457864
depmod:         bm_get_device_info_Rfaeb2303
depmod:         bm_register_driver_R53392fa7
depmod:         acpi_os_read_port_Rba23b567
depmod:         acpi_evaluate_object_Red2bc50a
depmod:         acpi_os_callocate_R112250e2
depmod:         acpi_ut_debug_print_raw_Re9aabc61
depmod:         acpi_ut_debug_print_Rac38b5ca
depmod:         bm_unregister_driver_R40fde1ec
depmod:         acpi_fadt_Re06d275f
depmod:         bm_cast_buffer_Rb5d8e04e
depmod:         bm_proc_root_R4cd2bdc3
depmod: *** Unresolved symbols in /lib/modules/2.4.21/kernel/drivers/acpi/ospm/system/ospm_system.o
depmod:         acpi_get_system_info_R10162128
depmod:         acpi_set_firmware_waking_vector_Rd611232e
depmod:         acpi_os_free_R43b9bbb4
depmod:         acpi_get_name_R739160a5
depmod:         acpi_ut_status_exit_R0b687984
depmod:         acpi_hw_register_bit_access_R5477a41e
depmod:         acpi_ut_trace_R8d457864
depmod:         bm_get_device_info_Rfaeb2303
depmod:         bm_register_driver_R53392fa7
depmod:         acpi_os_callocate_R112250e2
depmod:         acpi_get_table_R8b39872c
depmod:         acpi_gbl_FADT_R25e8cc23
depmod:         acpi_ut_debug_print_raw_Re9aabc61
depmod:         acpi_ut_debug_print_Rac38b5ca
depmod:         bm_unregister_driver_R40fde1ec
depmod:         acpi_leave_sleep_state_Rce4904a4
depmod:         acpi_enter_sleep_state_Rfe047ce6
depmod:         bm_proc_root_R4cd2bdc3
depmod:         acpi_hw_register_read_Rfb3ac6f4
depmod:         acpi_hw_obtain_sleep_type_register_data_Rb6158f6c
depmod: *** Unresolved symbols in /lib/modules/2.4.21/kernel/drivers/acpi/ospm/thermal/ospm_thermal.o
depmod:         bm_osl_generate_event_R7dc74281
depmod:         acpi_ut_exit_R4403d3ee
depmod:         bm_evaluate_reference_list_R40476eee
depmod:         acpi_os_free_R43b9bbb4
depmod:         bm_set_device_power_state_R0ecbe631
depmod:         acpi_get_name_R739160a5
depmod:         bm_request_R93dcc82b
depmod:         acpi_ut_status_exit_R0b687984
depmod:         acpi_ut_trace_R8d457864
depmod:         bm_get_device_info_Rfaeb2303
depmod:         bm_register_driver_R53392fa7
depmod:         acpi_evaluate_object_Red2bc50a
depmod:         acpi_os_callocate_R112250e2
depmod:         bm_evaluate_simple_integer_R24e881a5
depmod:         acpi_ut_debug_print_raw_Re9aabc61
depmod:         acpi_os_queue_for_execution_R173029e0
depmod:         acpi_ut_debug_print_Rac38b5ca
depmod:         bm_unregister_driver_R40fde1ec
depmod:         bm_proc_root_R4cd2bdc3

Relevant part of .config:
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUSMGR=y
CONFIG_ACPI_SYS=m
CONFIG_ACPI_CPU=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_AC=m
CONFIG_ACPI_EC=m
CONFIG_ACPI_CMBATT=m
CONFIG_ACPI_THERMAL=m
# CONFIG_APM is not set
 
Have fun,
 
Aschwin Marsman
 
--
aYniK Software Solutions         all You need is Knowledge
P.O. box 134                     NL-7600 AC Almelo - the Netherlands
a.marsman@aYniK.com              http://www.aYniK.com

