Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265379AbUBJFQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 00:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUBJFQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 00:16:26 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:54207 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S265264AbUBJFQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 00:16:14 -0500
Reply-To: <vanami@india.hp.com>
From: "veeresh" <vanami@india.hp.com>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-scsi@vger.kernel.org>
Subject: Kernel panic on Redhat Linux AS2.1 with QLogic 2342 HBA
Date: Tue, 10 Feb 2004 10:45:59 +0530
Message-ID: <005601c3ef94$f8c9d140$3bda4c0f@nt21859>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting kernel panic under following configuration:
Machine: DL580 multiprocessor Intel Xeon 2GHZ processors(2); 32-bit
OS: Redhat Linux Advanced Server 2.1
Kernel Version:2.4.9-e25smp
HBA: Qlogic2342 FC HBA
Device connected: Ultrium FC interface tape drive.
Info of HBA from /proc/scsi/qla2300/0
QLogic PCI to Fibre Channel Host Adapter for QLA23xx:
Firmware version: 3.02.16, Driver version 6.06.10 Entry address = f8881060
HBA: QLA2312 , Serial# A00000
Request Queue = 0x36afc000, Response Queue = 0x36ae0000
Request Queue count= 128, Response Queue count= 512
Total number of active commands = 0
Total number of interrupts = 20146612
Total number of IOCBs (used/max) = (0/600)
Total number of queued commands = 0
Device queue depth = 0x20
Number of free request entries = 52
Number of mailbox timeouts = 0
Number of ISP aborts = 0
Number of loop resyncs = 0
Number of retries for empty slots = 0
Number of reqs in pending_q= 0, retry_q= 0, done_q= 0, scsi_retry_q= 0 Host
adapter:loop state= <READY>, flags= 0x2820813 Dpc flags = 0x0 MBX flags =
0x0 SRB Free Count = 4096 Link down Timeout = 060 Port down retry = 008
Login retry count = 008 Commands retried with dropped frame(s) = 0

SCSI Device Information: scsi-qla0-adapter-node=200000e08b000000;
scsi-qla0-adapter-port=200000e08b000000;
scsi-qla0-target-0=100000e00222623c;
scsi-qla0-target-1=100000e00242623c;
SCSI LUN Information:
(Id:Lun) * - indicates lun is not registered with the OS.
( 0: 0): Total reqs 95, Pending reqs 0, flags 0x0, 0:0:81,
( 0: 1): Total reqs 1622, Pending reqs 0, flags 0x0, 0:0:81,
( 0: 2): Total reqs 189, Pending reqs 0, flags 0x0, 0:0:81,
( 0: 3): Total reqs 4694518, Pending reqs 0, flags 0x0, 0:0:81, ( 1: 0):
Total reqs 95, Pending reqs 0, flags 0x0, 0:0:82, ( 1: 1): Total reqs
12850865, Pending reqs 0, flags 0x0, 0:0:82, ( 1: 2): Total reqs 2602072,
Pending reqs 0, flags 0x0, 0:0:82,
Kernel panic information:
kernel BUG at /usr/src/linux-2.4/include/asm/pci.h:145!
invalid operand: 0000
Kernel 2.4.9-e.25smp
CPU: 2
EIP: 0010:[<f8891658>] Tainted: P
EFLAGS: 00010086
EIP is at qla2x00_64bit_start_scsi [qla2300] 0x498
eax: 0000003b ebx: 00000002 ecx: c02f6744 edx: 000ce00a
esi: c7fb4000 edi: 00000011 ebp: f6afd868 esp: df15bc18
ds: 0018 es: 0018 ss: 0018
Process hp_ltt (pid: 26018, stackpage=df15b000)
Stack: f88a2f00 00000091 00000202 c02f87cc 00000000 c02f8394 c02f8394
c02f8d40
00000000 000000f0 00004000 f6afd840 00000002 00000000 00000001 0000006f
f55cf000 f6c20084 00000046 c02f8394 c02f8d40 00000000 00000020 f6afd840
Call Trace: [<f88a2f00>] .LC2 [qla2300] 0x0
[<f889a0f6>] qla2x00_next [qla2300] 0x206
[<f888bfbd>] qla2x00_queuecommand [qla2300] 0x3dd
[<f8800690>] scsi_dispatch_cmd [scsi_mod] 0x150
[<f8800d50>] scsi_done [scsi_mod] 0x0
[<f880878e>] scsi_request_fn [scsi_mod] 0x31e
[<f8807a34>] __scsi_insert_special [scsi_mod] 0x74
[<f8807a9a>] scsi_insert_special_req [scsi_mod] 0x1a
[<f880097b>] scsi_do_req_Rsmp_bdc72156 [scsi_mod] 0x14b
[<f89ede40>] sg_cmd_done_bh [sg] 0x0
[<f89ed05b>] sg_common_write [sg] 0x23b
[<f89ede40>] sg_cmd_done_bh [sg] 0x0
[<f89ecdee>] sg_new_write [sg] 0x1ce
[<f89ef9a1>] sg_build_reserve [sg] 0x51
[<f89ed330>] sg_ioctl [sg] 0x2b0
[<c013da56>] _wrapped_alloc_pages [kernel] 0x76
[<c012c612>] do_wp_page [kernel] 0x172
[<c012d19b>] do_no_page [kernel] 0x3b
[<c012d5f0>] handle_mm_fault [kernel] 0xf0
[<c0125893>] collect_signal [kernel] 0x93
[<c0117f80>] do_page_fault [kernel] 0x0
[<c0118126>] do_page_fault [kernel] 0x1a6
[<c0107086>] do_signal [kernel] 0x66
[<c0126ed3>] sys_rt_sigaction [kernel] 0x93
[<c0155887>] sys_ioctl [kernel] 0x257
[<c01073c3>] system_call [kernel] 0x33
Code: 0f 0b 8d b6 00 00 00 00 83 c4 08 8d 04 5b 8d 14 c5 00 00 00
<0>Kernel panic: not continuing
Could you please let me know the cause for this problem as early as
possible.....

Regards,
Veeresh

