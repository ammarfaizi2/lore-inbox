Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbSJRPS6>; Fri, 18 Oct 2002 11:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265188AbSJRPS5>; Fri, 18 Oct 2002 11:18:57 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:17810 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265187AbSJRPSu>;
	Fri, 18 Oct 2002 11:18:50 -0400
Subject: Machine hang - OOPS
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFA89B065D.094716E2-ON85256C56.0053A8E2@pok.ibm.com>
From: "David F Barrera" <dbarrera@us.ibm.com>
Date: Fri, 18 Oct 2002 10:24:44 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/18/2002 11:24:45 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My machine 'hanged' last night while running the Database Opensource Test
Suite (DOTS) with DB2 on a standard Red Hat Linux release 7.3 (Valhalla),
Kernel 2.4.18-3bigmem on an i686 installation. The machine appears hang,
although it replies to a ping.

I captured the following oops and ran it through ksymoops.  Does anyone
have an idea what might have gone  wrong?  If so, please respond to me
directly.

Thanks.

David F Barrera

ksymoops output:

ksymoops 2.4.4 on i686 2.4.18-3bigmem.  Options used
     -v /boot/vmlinux-2.4.18-3bigmem (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-3bigmem/ (default)
     -m /boot/System.map-2.4.18-3bigmem (specified)

Error (expand_objects): cannot stat(/lib/ips.o) for ips
Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c01ce610, vmlinux says c0168d00.  Ignoring ksyms_base entry
wait_on_irq, CPU 6:
irq:  0 [ 0 0 0 0 0 0 0 0 ]
bh:   1 [ 1 0 0 0 1 0 0 0 ]
Stack dumps:
CPU 0:00000000 00000000 0000e4c3 0000e4c4 0000e4c5 00000000 00000000
00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000        00000000 000fde67 00000000 00000000 00000000 00000000
00000000 00000000 Call Trace:
CPU 1:00000000 00000000 f568ba80 edccc9a8 c02f0bec 00000013 f690be00
00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000        00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 Call Trace:
CPU 2:00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
       00000001 01000000 00000012 f6e89c00 f6e89c00 00000000 c8ecee00
c8ecee00        00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 Call Trace:
CPU 3:00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000        00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 Call Trace:
CPU 4:00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000        00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 Call Trace: [<f898d88a>] speedo_start_xmit [eepro100]
0x17a
[<c01e67f4>] qdisc_restart [kernel] 0x14
[<c01dd7fe>] dev_queue_xmit [kernel] 0x14e
[<c01d965c>] alloc_skb [kernel] 0xfc
[<c01f46d5>] ip_output [kernel] 0x105
[<c0205e80>] tcp_make_synack [kernel] 0x20
[<c01f432a>] ip_build_and_send_pkt [kernel] 0x1aa
[<c02079bd>] tcp_reset_keepalive_timer [kernel] 0x1d
[<f898d88a>] speedo_start_xmit [eepro100] 0x17a
[<c01e67f4>] qdisc_restart [kernel] 0x14
[<c01dd7fe>] dev_queue_xmit [kernel] 0x14e
[<f898d88a>] speedo_start_xmit [eepro100] 0x17a
[<c01f46d5>] ip_output [kernel] 0x105
[<c01e67f4>] qdisc_restart [kernel] 0x14
[<c01f4ae8>] ip_queue_xmit [kernel] 0x398
[<c01dd7fe>] dev_queue_xmit [kernel] 0x14e
[<c01f4ae8>] ip_queue_xmit [kernel] 0x398
[<c01f46d5>] ip_output [kernel] 0x105
[<c02093ee>] tcp_v4_send_check [kernel] 0x6e
[<c01f4ae8>] ip_queue_xmit [kernel] 0x398
[<c02093ee>] tcp_v4_send_check [kernel] 0x6e
[<c0204295>] tcp_transmit_skb [kernel] 0x565
[<c01daa64>] skb_checksum [kernel] 0x54
[<c01daa64>] skb_checksum [kernel] 0x54
[<c0119279>] __wake_up [kernel] 0x39
[<c020a87c>] tcp_v4_rcv [kernel] 0x3cc
[<c01daa64>] skb_checksum [kernel] 0x54
[<c011929e>] __wake_up [kernel] 0x5e
[<c020a87c>] tcp_v4_rcv [kernel] 0x3cc
[<c010de4f>] timer_interrupt [kernel] 0xaf
[<c01250e5>] update_process_times [kernel] 0x25
[<c01250e5>] update_process_times [kernel] 0x25
[<c0116079>] smp_apic_timer_interrupt [kernel] 0xa9
[<c012119b>] do_softirq [kernel] 0x7b
[<c012170f>] ksoftirqd [kernel] 0xaf
[<c0107286>] kernel_thread [kernel] 0x26
[<c0121660>] ksoftirqd [kernel] 0x0
CPU 5:00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000        00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 Call Trace:
CPU 7:00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000        00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 Call Trace: [<c0181fa1>] add_timer_randomness [kernel]
0xd1
[<c0182511>] extract_entropy [kernel] 0x381
[<f898d88a>] speedo_start_xmit [eepro100] 0x17a
[<f898d88a>] speedo_start_xmit [eepro100] 0x17a
[<c01e67f4>] qdisc_restart [kernel] 0x14
[<c01dd7fe>] dev_queue_xmit [kernel] 0x14e
[<c01d965c>] alloc_skb [kernel] 0xfc
[<c0209798>] tcp_v4_route_req [kernel] 0x78
[<c0118c60>] scheduler_tick [kernel] 0x80
[<c01250e5>] update_process_times [kernel] 0x25
[<c0116079>] smp_apic_timer_interrupt [kernel] 0xa9
[<c01250e5>] update_process_times [kernel] 0x25
[<f898d88a>] speedo_start_xmit [eepro100] 0x17a
[<c01e67f4>] qdisc_restart [kernel] 0x14
[<c01d965c>] alloc_skb [kernel] 0xfc
[<c01dd7e5>] dev_queue_xmit [kernel] 0x135
[<c01f46d5>] ip_output [kernel] 0x105
[<c01f4ae8>] ip_queue_xmit [kernel] 0x398
[<c010a52e>] handle_IRQ_event [kernel] 0x5e
[<c010a76d>] do_IRQ [kernel] 0xdd
[<c02093ee>] tcp_v4_send_check [kernel] 0x6e
[<c0204295>] tcp_transmit_skb [kernel] 0x565
[<c0204d67>] tcp_write_xmit [kernel] 0x157
[<c0119279>] __wake_up [kernel] 0x39
[<c02021b2>] __tcp_data_snd_check [kernel] 0x52
[<c020215c>] tcp_new_space [kernel] 0x7c
[<c020260c>] tcp_rcv_established [kernel] 0x11c
[<f8815890>] scsi_request_fn [scsi_mod] 0x1b0
[<c01daa64>] skb_checksum [kernel] 0x54
[<c020a2af>] tcp_v4_checksum_init [kernel] 0x7f
[<c020a571>] tcp_v4_rcv [kernel] 0xc1
[<f8815454>] scsi_io_completion_Rsmp_7e059b86 [scsi_mod] 0x2a4
[<c01f19ac>] ip_local_deliver [kernel] 0x12c
[<f881213f>] scsi_delete_timer_Rsmp_16aab775 [scsi_mod] 0xf
[<f880def1>] scsi_done [scsi_mod] 0xc1
[<f88580a1>] ips_done [ips] 0x4b1
[<f88588be>] ips_chkstatus [ips] 0x12e
[<f8854fb4>] ips_intr_copperhead [ips] 0x84
[<c0125410>] do_timer [kernel] 0x20
[<c010de4f>] timer_interrupt [kernel] 0xaf
[<c011862b>] wake_up_process [kernel] 0xb
[<c010a76d>] do_IRQ [kernel] 0xdd
[<c0106e70>] default_idle [kernel] 0x0
[<c0106e70>] default_idle [kernel] 0x0
[<c0106ef9>] cpu_idle [kernel] 0x29
[<c011cbf8>] printk [kernel] 0x128
CPU 6:c8ee7f28 c02423a4 00000006 00000000 ffffffff 00000006 c010a362
c02423b9
       00000001 f6380000 00000001 c017d3fe f6380368 c02f5044 c8ee7f74
c8ee665c
       c8ee6000 c012164d f6380000 f6380130 c02f5044 c8ee6000 00000000
c012a075
Call Trace: [<c010a362>] __global_cli [kernel] 0xe2
[<c017d3fe>] flush_to_ldisc [kernel] 0x9e
[<c012164d>] __run_task_queue [kernel] 0x5d
[<c012a075>] context_thread [kernel] 0x145
[<c0129f30>] context_thread [kernel] 0x0
[<c0105000>] stext [kernel] 0x0
[<c0107286>] kernel_thread [kernel] 0x26
[<c0129f30>] context_thread [kernel] 0x0
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c010a362 <__global_cli+e2/170>
Trace; c017d3fe <flush_to_ldisc+9e/120>
Trace; c012164d <__run_task_queue+5d/70>
Trace; c012a075 <context_thread+145/200>
Trace; c0129f30 <context_thread+0/200>
Trace; c0105000 <_stext+0/0>
Trace; c0107286 <kernel_thread+26/30>
Trace; c0129f30 <context_thread+0/200>


2 warnings and 4 errors issued.  Results may not be reliable.


