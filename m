Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263069AbTC1RZJ>; Fri, 28 Mar 2003 12:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263070AbTC1RZJ>; Fri, 28 Mar 2003 12:25:09 -0500
Received: from smtp5.arnet.com.ar ([200.45.191.23]:53168 "HELO
	smtp5.arnet.com.ar") by vger.kernel.org with SMTP
	id <S263069AbTC1RZG>; Fri, 28 Mar 2003 12:25:06 -0500
Date: Fri, 28 Mar 2003 14:36:19 -0300
From: Horacio de Oro <hgdeoro@yahoo.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.66-mm1] Debug: sleeping function called from illegal context
 at mm/slab.c:1658
Message-Id: <20030328143619.37848d26.hgdeoro@yahoo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened when I did 'shutdown' from gdm (but not every shutdown).

Mar 27 09:47:46 corralito gconfd (horacio-402): Received signal 15, shutting down cleanly
Mar 27 09:47:46 corralito gconfd (horacio-402): Exiting
Mar 27 09:47:47 corralito modprobe: FATAL: Module char_major_10_134 not found. 
Mar 27 09:47:54 corralito kernel: mtrr: MTRR 4 not used
Mar 27 09:47:54 corralito kernel: mtrr: MTRR 4 not used
Mar 27 09:47:54 corralito gdm[346]: gdm_child_action: Master halting...
Mar 27 09:47:55 corralito kernel: Debug: sleeping function called from illegal context at mm/slab.c:1658
Mar 27 09:47:55 corralito kernel: Call Trace:
Mar 27 09:47:55 corralito kernel:  [__might_sleep+95/112] __might_sleep+0x5f/0x70
Mar 27 09:47:55 corralito kernel:  [kmalloc+136/144] kmalloc+0x88/0x90
Mar 27 09:47:55 corralito kernel:  [accel_cursor+238/816] accel_cursor+0xee/0x330
Mar 27 09:47:55 corralito kernel:  [bio_destructor+56/96] bio_destructor+0x38/0x60
Mar 27 09:47:55 corralito kernel:  [write_boundary_block+79/96] write_boundary_block+0x4f/0x60
Mar 27 09:47:55 corralito kernel:  [fb_vbl_handler+136/176] fb_vbl_handler+0x88/0xb0
Mar 27 09:47:55 corralito kernel:  [end_that_request_last+78/128] end_that_request_last+0x4e/0x80
Mar 27 09:47:55 corralito kernel:  [scheduler_tick+923/928] scheduler_tick+0x39b/0x3a0
Mar 27 09:47:55 corralito kernel:  [elv_queue_empty+31/48] elv_queue_empty+0x1f/0x30
Mar 27 09:47:55 corralito kernel:  [update_process_times+70/96] update_process_times+0x46/0x60
Mar 27 09:47:55 corralito kernel:  [cursor_timer_handler+0/64] cursor_timer_handler+0x0/0x40
Mar 27 09:47:55 corralito kernel:  [cursor_timer_handler+31/64] cursor_timer_handler+0x1f/0x40
Mar 27 09:47:55 corralito kernel:  [run_timer_softirq+141/368] run_timer_softirq+0x8d/0x170
Mar 27 09:47:55 corralito kernel:  [timer_interrupt+82/320] timer_interrupt+0x52/0x140
Mar 27 09:47:55 corralito kernel:  [do_softirq+156/160] do_softirq+0x9c/0xa0
Mar 27 09:47:55 corralito kernel:  [do_IRQ+277/336] do_IRQ+0x115/0x150
Mar 27 09:47:55 corralito kernel:  [acpi_processor_idle+0/459] acpi_processor_idle+0x0/0x1cb
Mar 27 09:47:55 corralito kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 27 09:47:55 corralito kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Mar 27 09:47:55 corralito kernel:  [acpi_processor_idle+0/459] acpi_processor_idle+0x0/0x1cb
Mar 27 09:47:55 corralito kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 27 09:47:55 corralito kernel:  [acpi_processor_idle+75/459] acpi_processor_idle+0x4b/0x1cb
Mar 27 09:47:55 corralito kernel:  [acpi_processor_idle+69/459] acpi_processor_idle+0x45/0x1cb
Mar 27 09:47:55 corralito kernel:  [acpi_processor_idle+0/459] acpi_processor_idle+0x0/0x1cb
Mar 27 09:47:55 corralito kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 27 09:47:55 corralito kernel:  [cpu_idle+46/64] cpu_idle+0x2e/0x40
Mar 27 09:47:55 corralito kernel:  [rest_init+0/96] _stext+0x0/0x60
Mar 27 09:47:55 corralito kernel: 
Mar 27 09:47:55 corralito init: Switching to runlevel: 0
Mar 27 09:47:56 corralito kernel: Debug: sleeping function called from illegal context at mm/slab.c:1658
Mar 27 09:47:56 corralito kernel: Call Trace:
Mar 27 09:47:56 corralito kernel:  [__might_sleep+95/112] __might_sleep+0x5f/0x70
Mar 27 09:47:56 corralito kernel:  [kmalloc+136/144] kmalloc+0x88/0x90
Mar 27 09:47:56 corralito kernel:  [accel_cursor+238/816] accel_cursor+0xee/0x330
Mar 27 09:47:56 corralito kernel:  [fb_vbl_handler+136/176] fb_vbl_handler+0x88/0xb0
Mar 27 09:47:56 corralito kernel:  [init_stall_timer+66/80] init_stall_timer+0x42/0x50
Mar 27 09:47:56 corralito kernel:  [update_process_times+70/96] update_process_times+0x46/0x60
Mar 27 09:47:56 corralito kernel:  [cursor_timer_handler+0/64] cursor_timer_handler+0x0/0x40
Mar 27 09:47:56 corralito kernel:  [cursor_timer_handler+31/64] cursor_timer_handler+0x1f/0x40
Mar 27 09:47:56 corralito kernel:  [run_timer_softirq+141/368] run_timer_softirq+0x8d/0x170
Mar 27 09:47:56 corralito kernel:  [timer_interrupt+82/320] timer_interrupt+0x52/0x140
Mar 27 09:47:56 corralito kernel:  [do_softirq+156/160] do_softirq+0x9c/0xa0
Mar 27 09:47:56 corralito kernel:  [do_IRQ+277/336] do_IRQ+0x115/0x150
Mar 27 09:47:56 corralito kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 27 09:47:56 corralito kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Mar 27 09:47:56 corralito kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 27 09:47:56 corralito kernel:  [acpi_processor_idle+316/459] acpi_processor_idle+0x13c/0x1cb
Mar 27 09:47:56 corralito kernel:  [acpi_processor_idle+69/459] acpi_processor_idle+0x45/0x1cb
Mar 27 09:47:56 corralito kernel:  [acpi_processor_idle+0/459] acpi_processor_idle+0x0/0x1cb
Mar 27 09:47:56 corralito kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 27 09:47:56 corralito kernel:  [cpu_idle+46/64] cpu_idle+0x2e/0x40
Mar 27 09:47:56 corralito kernel:  [rest_init+0/96] _stext+0x0/0x60
Mar 27 09:47:56 corralito kernel: 
Mar 27 09:47:57 corralito kernel: Debug: sleeping function called from illegal context at mm/slab.c:1658
Mar 27 09:47:57 corralito kernel: Call Trace:
Mar 27 09:47:57 corralito kernel:  [__might_sleep+95/112] __might_sleep+0x5f/0x70
Mar 27 09:47:57 corralito kernel:  [kmalloc+136/144] kmalloc+0x88/0x90
Mar 27 09:47:57 corralito kernel:  [accel_cursor+238/816] accel_cursor+0xee/0x330
Mar 27 09:47:57 corralito kernel:  [fb_vbl_handler+136/176] fb_vbl_handler+0x88/0xb0
Mar 27 09:47:57 corralito kernel:  [init_stall_timer+66/80] init_stall_timer+0x42/0x50
Mar 27 09:47:57 corralito kernel:  [i8042_timer_func+0/64] i8042_timer_func+0x0/0x40
Mar 27 09:47:57 corralito kernel:  [cursor_timer_handler+0/64] cursor_timer_handler+0x0/0x40
Mar 27 09:47:57 corralito kernel:  [cursor_timer_handler+31/64] cursor_timer_handler+0x1f/0x40
Mar 27 09:47:57 corralito kernel:  [run_timer_softirq+141/368] run_timer_softirq+0x8d/0x170
Mar 27 09:47:57 corralito kernel:  [timer_interrupt+82/320] timer_interrupt+0x52/0x140
Mar 27 09:47:58 corralito kernel:  [do_softirq+156/160] do_softirq+0x9c/0xa0
Mar 27 09:47:58 corralito kernel:  [do_IRQ+277/336] do_IRQ+0x115/0x150
Mar 27 09:47:58 corralito kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 27 09:47:58 corralito kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Mar 27 09:47:58 corralito kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 27 09:47:58 corralito kernel:  [acpi_processor_idle+316/459] acpi_processor_idle+0x13c/0x1cb
Mar 27 09:47:58 corralito kernel:  [acpi_processor_idle+69/459] acpi_processor_idle+0x45/0x1cb
Mar 27 09:47:58 corralito kernel:  [acpi_processor_idle+0/459] acpi_processor_idle+0x0/0x1cb
Mar 27 09:47:58 corralito kernel:  [default_idle+0/48] default_idle+0x0/0x30
Mar 27 09:47:58 corralito kernel:  [cpu_idle+46/64] cpu_idle+0x2e/0x40
Mar 27 09:47:58 corralito kernel:  [rest_init+0/96] _stext+0x0/0x60
Mar 27 09:47:58 corralito kernel: 
Mar 27 09:47:59 corralito kernel: Debug: sleeping function called from illegal context at mm/slab.c:1658
(...)
Mar 27 09:48:00 corralito kernel: Debug: sleeping function called from illegal context at mm/slab.c:1658
(...)
Mar 27 09:48:01 corralito kernel: Debug: sleeping function called from illegal context at mm/slab.c:1658
(...)
Mar 27 09:48:02 corralito kernel: Debug: sleeping function called from illegal context at mm/slab.c:1658
(...)
Mar 27 09:48:03 corralito kernel: Debug: sleeping function called from illegal context at mm/slab.c:1658
(...)



I've seen the syslogs, and the first 6 lines are common to
all the 55 'Debug' messages I have:

Mar 27 13:30:25 corralito kernel: Debug: sleeping function called from illegal context at mm/slab.c:1658
Mar 27 13:30:25 corralito kernel: Call Trace:
Mar 27 13:30:25 corralito kernel:  [__might_sleep+95/112] __might_sleep+0x5f/0x70
Mar 27 13:30:25 corralito kernel:  [kmalloc+136/144] kmalloc+0x88/0x90
Mar 27 13:30:25 corralito kernel:  [accel_cursor+238/816] accel_cursor+0xee/0x330
Mar 27 13:30:25 corralito kernel:  [fb_vbl_handler+136/176] fb_vbl_handler+0x88/0xb0
[From here, the lines differs]

Maybe the switch to the console is causing this, and not
the shutdown from gdm/exit from X11? I don't know!

If needed, I could provide you the full log (109 kb) or any other information.

CONFIG_PREEMPT=y

CONFIG_FB=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_TABLE=y

Linux version 2.5.66-mm1 (horacio@corralito) (gcc version 3.2.3 20030316 (Debian prerelease)) #2 Wed Mar 26 11:52:24 ART 2003

processor       : 0             
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 7
model name      : mobile AMD Duron(tm) Processor
stepping        : 0
cpu MHz         : 946.576
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 1863.68

Hope this help!
Horacio
