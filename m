Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261850AbSJVAwY>; Mon, 21 Oct 2002 20:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbSJVAwY>; Mon, 21 Oct 2002 20:52:24 -0400
Received: from mimas.island.net ([199.60.19.4]:1804 "EHLO mimas.island.net")
	by vger.kernel.org with ESMTP id <S261850AbSJVAwK>;
	Mon, 21 Oct 2002 20:52:10 -0400
Date: Mon, 21 Oct 2002 17:58:04 -0700 (PDT)
From: andy barlak <andyb@island.net>
Reply-To: <andyb@island.net>
To: Patrick Mansfield <patmans@us.ibm.com>
cc: Mike Anderson <andmike@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi_error device offline fix
In-Reply-To: <20021021155236.A10032@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.30.0210211739330.2010-100000@tosko.alm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, Patrick Mansfield wrote:
> Can you turn on all scsi logging - with CONFIG_SCSI_LOGGING enabled,
> on your boot command line add a "scsi_logging=1" and send
> the output.
>
> -- Patrick Mansfield

Sure.  large dmesg buffer required.  This produced a 55k file that
I will pare down to what I consider informative.

SCSI subsystem driver Revision: 1.00
PCI: Assigned IRQ 10 for device 00:08.0
scsi: ***** BusLogic SCSI Driver Version 2.1.16 of 18 July 2002 *****
scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
Wake up parent
Error handler sleeping
scsi0: Configuring BusLogic Model BT-958 PCI Wide Ultra SCSI Host Adapter
scsi0:   Firmware Version: 5.06J, I/O Address: 0xE800, IRQ Channel: 10/Level
scsi0:   PCI Bus: 0, Device: 8, Address: 0xED001000, Host Adapter SCSI ID: 7
scsi0:   Parity Checking: Disabled, Extended Translation: Disabled
scsi0:   Synchronous Negotiation: FFFFSFF#FFFFFFFF, Wide Negotiation: YYYYNYY#YY
YYYYYY
scsi0:   Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
scsi0:   Scatter/Gather Limit: 128 of 8192 segments, Mailboxes: 211
scsi0:   Driver Queue Depth: 211, Host Adapter Queue Depth: 192
scsi0:   Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
scsi0:   Error Recovery Strategy: Default, SCSI Bus Reset: Disabled
scsi0:   SCSI Bus Termination: High Enabled, SCAM: Disabled
scsi0: *** BusLogic BT-958 Initialized Successfully ***
scsi0 : BusLogic BT-958
scsi scan: INQUIRY to host 0 channel 0 id 0 lun 0
scsi_do_req (host = 0, channel = 0 target = 0, buffer =c03a9060, bufflen = 36, d
one = c01e425c, timeout = 6000, retries = 3)
command : 12  00  00  00  24  00
Activating command for device 0 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c134f000, time: 6000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 0, command = c134f064, buffe
r = c03a9060,
bufflen = 36, done = c01e425c)
queuecommand : routine at c01eda7c
leaving scsi_dispatch_cmnd()
Leaving scsi_do_req()
scsi_delete_timer: scmd: c134f000, rtn: 1
Command finished 1 0 0x0
Notifying upper driver of completion for device 0 0
Deactivating command for device 0 (active=0, failed=0)
scsi scan: 1st INQUIRY successful with code 0x0
  Vendor: CONNER    Model: CFP2107E  2.14GB  Rev: 1423
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi_do_req (host = 0, channel = 0 target = 0, buffer =c03a9160, bufflen = 255,
done = c01e425c, timeout = 6000, retries = 3)
command : 12  01  00  00  ff  00
Activating command for device 0 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c134f000, time: 6000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 0, command = c134f064, buffe
r = c03a9160,
bufflen = 255, done = c01e425c)
queuecommand : routine at c01eda7c
leaving scsi_dispatch_cmnd()
Leaving scsi_do_req()
scsi_delete_timer: scmd: c134f000, rtn: 1
Command finished 1 0 0x0
Notifying upper driver of completion for device 0 0
Deactivating command for device 0 (active=0, failed=0)
scsi_do_req (host = 0, channel = 0 target = 0, buffer =c03a9260, bufflen = 255,
done = c01e425c, timeout = 6000, retries = 3)
command : 12  01  80  00  ff  00
Activating command for device 0 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c134f000, time: 6000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 0, command = c134f064, buffe
r = c03a9260,
bufflen = 255, done = c01e425c)
queuecommand : routine at c01eda7c
leaving scsi_dispatch_cmnd()
Leaving scsi_do_req()
scsi_delete_timer: scmd: c134f000, rtn: 1
Command finished 1 0 0x0
Notifying upper driver of completion for device 0 0
Deactivating command for device 0 (active=0, failed=0)
scsi scan: host 0 channel 0 id 0 lun 0 name/id: 'SCONNER  CFP2107E  2.14GBEG95Z9
W '
scsi scan: Sequential scan of host 0 channel 0 id 0
scsi scan: INQUIRY to host 0 channel 0 id 1 lun 0
scsi_do_req (host = 0, channel = 0 target = 1, buffer =c03a9060, bufflen = 36, d
one = c01e425c, timeout = 6000, retries = 3)
command : 12  00  00  00  24  00
Activating command for device 1 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c134f000, time: 6000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 1, command = c134f064, buffe
r = c03a9060,
bufflen = 36, done = c01e425c)
queuecommand : routine at c01eda7c
leaving scsi_dispatch_cmnd()
Leaving scsi_do_req()
scsi_delete_timer: scmd: c134f000, rtn: 1
Command finished 1 0 0x0
Notifying upper driver of completion for device 1 0
Deactivating command for device 1 (active=0, failed=0)
scsi scan: 1st INQUIRY successful with code 0x0
scsi_do_req (host = 0, channel = 0 target = 1, buffer =c03a9060, bufflen = 144,
done = c01e425c, timeout = 6000, retries = 3)
command : 12  00  00  00  90  00
Activating command for device 1 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c134f000, time: 6000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 1, command = c134f064, buffe
r = c03a9060,
bufflen = 144, done = c01e425c)
queuecommand : routine at c01eda7c
leaving scsi_dispatch_cmnd()
Leaving scsi_do_req()
scsi_delete_timer: scmd: c134f000, rtn: 1
Command finished 1 0 0x0
Notifying upper driver of completion for device 1 0
Deactivating command for device 1 (active=0, failed=0)
scsi scan: 2nd INQUIRY successful with code 0x0
  Vendor: SEAGATE   Model: SX423451W         Rev: 9E18
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi_do_req (host = 0, channel = 0 target = 1, buffer =c03a9160, bufflen = 255,
done = c01e425c, timeout = 6000, retries = 3)
command : 12  01  00  00  ff  00
Activating command for device 1 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c134f000, time: 6000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 1, command = c134f064, buffe
r = c03a9160,
bufflen = 255, done = c01e425c)
queuecommand : routine at c01eda7c
leaving scsi_dispatch_cmnd()
Leaving scsi_do_req()
Waking error handler thread
Command timed out active=1 busy=1  failed=1
Error handler waking up
scsi_eh_prt_fail_stats: 0:0:1:0 cmds failed: 0, timedout: 1
Total of 1 commands on 1 devices require eh work       <<<<<<<<<<<<<<<
scsi_eh_get_sense: checking to see if we need to request sense
scsi_eh_abort_cmd: checking to see if we need to abort cmd
scsi_eh_bus_device_reset: Trying BDR
scsi_eh_bus_host_reset: Try Bus/Host RST
scsi_try_bus_reset: Snd Bus RST
scsi_try_host_reset: Snd Host RST
scsi: Device offlined - not ready or command retry failed after error recovery:
host 0 channel 0 id 1 lun 0
scsi_add_timer: scmd: c134f000, time: 100, (c01e91dc)
scsi_delete_timer: scmd: c134f000, rtn: 1
scsi_restart_operations: waking up host to restart
Error handler sleeping
scsi_decide_disposition: device offline - report as SUCCESS
Command finished 1 0 0x6000000
Notifying upper driver of completion for device 1 6000000
Deactivating command for device 1 (active=0, failed=0)
scsi_do_req (host = 0, channel = 0 target = 1, buffer =c03a9160, bufflen = 255,
done = c01e425c, timeout = 6000, retries = 3)
command : 12  01  80  00  ff  00
Activating command for device 1 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c134f000, time: 6000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 1, command = c134f064, buffe
r = c03a9160,
bufflen = 255, done = c01e425c)
queuecommand : routine at c01eda7c
leaving scsi_dispatch_cmnd()
Leaving scsi_do_req()
Waking error handler thread
Command timed out active=1 busy=1  failed=1
Error handler waking up
scsi_eh_prt_fail_stats: 0:0:1:0 cmds failed: 0, timedout: 1
Total of 1 commands on 1 devices require eh work            <<<<<<<<<<<<<
scsi_eh_get_sense: checking to see if we need to request sense
scsi_eh_abort_cmd: checking to see if we need to abort cmd
scsi_eh_bus_device_reset: Trying BDR
scsi_eh_bus_host_reset: Try Bus/Host RST
scsi_try_bus_reset: Snd Bus RST
scsi_try_host_reset: Snd Host RST
scsi: Device offlined - not ready or command retry failed after error recovery:
host 0 channel 0 id 1 lun 0
scsi_add_timer: scmd: c134f000, time: 100, (c01e91dc)
scsi_delete_timer: scmd: c134f000, rtn: 1
scsi_restart_operations: waking up host to restart
Error handler sleeping
scsi_decide_disposition: device offline - report as SUCCESS
Command finished 1 0 0x6000000
Notifying upper driver of completion for device 1 6000000
Deactivating command for device 1 (active=0, failed=0)
scsi scan: host 0 channel 0 id 1 lun 0 name/id: ''
scsi scan: Sequential scan of host 0 channel 0 id 1
scsi scan: INQUIRY to host 0 channel 0 id 2 lun 0
scsi_do_req (host = 0, channel = 0 target = 2, buffer =c03a9060, bufflen = 36, d
one = c01e425c, timeout = 6000, retries = 3)
command : 12  00  00  00  24  00
Activating command for device 2 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c134f000, time: 6000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 2, command = c134f064, buffe
r = c03a9060,
bufflen = 36, done = c01e425c)
queuecommand : routine at c01eda7c
leaving scsi_dispatch_cmnd()
Leaving scsi_do_req()
Waking error handler thread
Command timed out active=1 busy=1  failed=1
Error handler waking up
scsi_eh_prt_fail_stats: 0:0:2:0 cmds failed: 0, timedout: 1
Total of 1 commands on 1 devices require eh work
scsi_eh_get_sense: checking to see if we need to request sense
scsi_eh_abort_cmd: checking to see if we need to abort cmd
scsi_eh_bus_device_reset: Trying BDR
scsi_eh_bus_host_reset: Try Bus/Host RST
scsi_try_bus_reset: Snd Bus RST
scsi_try_host_reset: Snd Host RST
scsi: Device offlined - not ready or command retry failed after error recovery:
host 0 channel 0 id 2 lun 0
scsi_add_timer: scmd: c134f000, time: 100, (c01e91dc)
scsi_delete_timer: scmd: c134f000, rtn: 1
scsi_restart_operations: waking up host to restart
Error handler sleeping
scsi_decide_disposition: device offline - report as SUCCESS
Command finished 1 0 0x6000000
Notifying upper driver of completion for device 2 6000000
Deactivating command for device 2 (active=0, failed=0)
scsi scan: 1st INQUIRY failed with code 0x6000000
scsi scan: INQUIRY to host 0 channel 0 id 3 lun 0
scsi_do_req (host = 0, channel = 0 target = 3, buffer =c03a9060, bufflen = 36, d
one = c01e425c, timeout = 6000, retries = 3)
command : 12  00  00  00  24  00
Activating command for device 3 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c134f000, time: 6000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 3, command = c134f064, buffe
r = c03a9060,
bufflen = 36, done = c01e425c)
queuecommand : routine at c01eda7c
leaving scsi_dispatch_cmnd()
Leaving scsi_do_req()
Waking error handler thread
Command timed out active=1 busy=1  failed=1
Error handler waking up
scsi_eh_prt_fail_stats: 0:0:3:0 cmds failed: 0, timedout: 1
Total of 1 commands on 1 devices require eh work
scsi_eh_get_sense: checking to see if we need to request sense
scsi_eh_abort_cmd: checking to see if we need to abort cmd
scsi_eh_bus_device_reset: Trying BDR
scsi_eh_bus_host_reset: Try Bus/Host RST
scsi_try_bus_reset: Snd Bus RST
scsi_try_host_reset: Snd Host RST
scsi: Device offlined - not ready or command retry failed after error recovery:
host 0 channel 0 id 3 lun 0
scsi_add_timer: scmd: c134f000, time: 100, (c01e91dc)
scsi_delete_timer: scmd: c134f000, rtn: 1
scsi_restart_operations: waking up host to restart
Error handler sleeping
scsi_decide_disposition: device offline - report as SUCCESS
Command finished 1 0 0x6000000
Notifying upper driver of completion for device 3 6000000
Deactivating command for device 3 (active=0, failed=0)
scsi scan: 1st INQUIRY failed with code 0x6000000
scsi scan: INQUIRY to host 0 channel 0 id 4 lun 0
scsi_do_req (host = 0, channel = 0 target = 4, buffer =c03a9060, bufflen = 36, d
one = c01e425c, timeout = 6000, retries = 3)
command : 12  00  00  00  24  00
Activating command for device 4 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c134f000, time: 6000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 4, command = c134f064, buffe
r = c03a9060,
bufflen = 36, done = c01e425c)
queuecommand : routine at c01eda7c
leaving scsi_dispatch_cmnd()
Leaving scsi_do_req()
Waking error handler thread
Command timed out active=1 busy=1  failed=1
Error handler waking up
scsi_eh_prt_fail_stats: 0:0:4:0 cmds failed: 0, timedout: 1
Total of 1 commands on 1 devices require eh work
scsi_eh_get_sense: checking to see if we need to request sense
scsi_eh_abort_cmd: checking to see if we need to abort cmd
scsi_eh_bus_device_reset: Trying BDR
scsi_eh_bus_host_reset: Try Bus/Host RST
scsi_try_bus_reset: Snd Bus RST
scsi_try_host_reset: Snd Host RST
scsi: Device offlined - not ready or command retry failed after error recovery:
host 0 channel 0 id 4 lun 0
scsi_add_timer: scmd: c134f000, time: 100, (c01e91dc)
scsi_delete_timer: scmd: c134f000, rtn: 1
scsi_restart_operations: waking up host to restart
Error handler sleeping
scsi_decide_disposition: device offline - report as SUCCESS
Command finished 1 0 0x6000000
Notifying upper driver of completion for device 4 6000000
Deactivating command for device 4 (active=0, failed=0)
scsi scan: 1st INQUIRY failed with code 0x6000000
.
.
.
.
Deactivating command for device 15 (active=0, failed=0)
scsi scan: 1st INQUIRY failed with code 0x6000000
st: Version 20021015, fixed bufsize 32768, wrt 30720, s/g segs 256
init_sd: sd driver entry point
sd_detect: type=0
sd_detect: type=0
sd_init: dev_noticed=2
sd_attach: scsi device: <0,0,0,0>
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sd_attach: scsi device: <0,0,1,0>
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
sd_finish:
sd_init_onedisk: disk=sda
scsi_do_req (host = 0, channel = 0 target = 0, buffer =c0003000, bufflen = 0, do
ne = c01e425c, timeout = 30000, retries = 5)
command : 00  00  00  00  00  00
Activating command for device 0 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c134f400, time: 30000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 0, command = c134f464, buffe
r = c0003000,
bufflen = 0, done = c01e425c)
queuecommand : routine at c01eda7c
leaving scsi_dispatch_cmnd()
Leaving scsi_do_req()
Waking error handler thread
Command timed out active=1 busy=1  failed=1
Error handler waking up
scsi_eh_prt_fail_stats: 0:0:0:0 cmds failed: 0, timedout: 1
Total of 1 commands on 1 devices require eh work
scsi_eh_get_sense: checking to see if we need to request sense
scsi_eh_abort_cmd: checking to see if we need to abort cmd
scsi_eh_bus_device_reset: Trying BDR
scsi_eh_bus_host_reset: Try Bus/Host RST
scsi_try_bus_reset: Snd Bus RST
scsi_try_host_reset: Snd Host RST
scsi: Device offlined - not ready or command retry failed after error recovery:
host 0 channel 0 id 0 lun 0
scsi_add_timer: scmd: c134f400, time: 100, (c01e91dc)
scsi_delete_timer: scmd: c134f400, rtn: 1
scsi_restart_operations: waking up host to restart
Error handler sleeping
scsi_decide_disposition: device offline - report as SUCCESS
Command finished 1 0 0x6000000
Notifying upper driver of completion for device 0 6000000
Deactivating command for device 0 (active=0, failed=0)
scsi_do_req (host = 0, channel = 0 target = 0, buffer =c0003000, bufflen = 128,
done = c01e425c, timeout = 30000, retries = 5)
command : 1a  08  08  00  80  00
Activating command for device 0 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c134fe00, time: 30000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 0, command = c134fe64, buffe
r = c0003000,
bufflen = 128, done = c01e425c)
queuecommand : routine at c01eda7c
leaving scsi_dispatch_cmnd()
Leaving scsi_do_req()
Waking error handler thread
Command timed out active=1 busy=1  failed=1
Error handler waking up
scsi_eh_prt_fail_stats: 0:0:0:0 cmds failed: 0, timedout: 1
Total of 1 commands on 1 devices require eh work
scsi_eh_get_sense: checking to see if we need to request sense
scsi_eh_abort_cmd: checking to see if we need to abort cmd
scsi_eh_bus_device_reset: Trying BDR
scsi_eh_bus_host_reset: Try Bus/Host RST
scsi_try_bus_reset: Snd Bus RST
scsi_try_host_reset: Snd Host RST
scsi: Device offlined - not ready or command retry failed after error recovery:
host 0 channel 0 id 0 lun 0
scsi_add_timer: scmd: c134fe00, time: 100, (c01e91dc)
scsi_delete_timer: scmd: c134fe00, rtn: 1
scsi_restart_operations: waking up host to restart
Error handler sleeping
scsi_decide_disposition: device offline - report as SUCCESS
Command finished 1 0 0x6000000
Notifying upper driver of completion for device 0 6000000
Deactivating command for device 0 (active=0, failed=0)
scsi_do_req (host = 0, channel = 0 target = 0, buffer =c0003000, bufflen = 128,
done = c01e425c, timeout = 30000, retries = 5)
command : 1a  08  08  00  80  00
Activating command for device 0 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: cfdf4000, time: 30000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 0, command = cfdf4064, buffe
r = c0003000,
bufflen = 128, done = c01e425c)
.
.
.
scsi: Device offlined - not ready or command retry failed after error recovery:
host 0 channel 0 id 0 lun 0
scsi_add_timer: scmd: cfdf4800, time: 100, (c01e91dc)
scsi_delete_timer: scmd: cfdf4800, rtn: 1
scsi_restart_operations: waking up host to restart
Error handler sleeping
scsi_decide_disposition: device offline - report as SUCCESS
Command finished 1 0 0x6000000
Notifying upper driver of completion for device 0 6000000
Deactivating command for device 0 (active=0, failed=0)
sda : READ CAPACITY failed.
sda : status=0, message=00, host=0, driver=06
sda : sense not available.
sd_open: disk=sda
scsi_block_when_processing_errors: rtn: 0
sd_init_onedisk: disk=sdb
scsi_do_req (host = 0, channel = 0 target = 1, buffer =c0003000, bufflen = 0, do
ne = c01e425c, timeout = 30000, retries = 5)
command : 00  00  00  00  00  00
Activating command for device 1 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c134f600, time: 30000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 1, command = c134f664,
buffer = c0003000,
bufflen = 0, done = c01e425c)
queuecommand : routine at c01eda7c
leaving scsi_dispatch_cmnd()
Leaving scsi_do_req()
Waking error handler thread
Command timed out active=1 busy=1  failed=1
Error handler waking up
scsi_eh_prt_fail_stats: 0:0:1:0 cmds failed: 0, timedout: 1
Total of 1 commands on 1 devices require eh work
scsi_eh_get_sense: checking to see if we need to request sense
scsi_eh_abort_cmd: checking to see if we need to abort cmd
scsi_eh_bus_device_reset: Trying BDR
scsi_eh_bus_host_reset: Try Bus/Host RST
scsi_try_bus_reset: Snd Bus RST
scsi_try_host_reset: Snd Host RST
scsi: Device offlined - not ready or command retry failed after error recovery:
host 0 channel 0 id 1 lun 0
scsi_add_timer: scmd: c134f600, time: 100, (c01e91dc)
scsi_delete_timer: scmd: c134f600, rtn: 1
scsi_restart_operations: waking up host to restart
Error handler sleeping
scsi_decide_disposition: device offline - report as SUCCESS
Command finished 1 0 0x6000000
Notifying upper driver of completion for device 1 6000000
Deactivating command for device 1 (active=0, failed=0)
scsi_do_req (host = 0, channel = 0 target = 1, buffer =c0003000, bufflen = 128,
done = c01e425c, timeout = 30000, retries = 5)
command : 1a  08  08  00  80  00
Activating command for device 1 (1)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: cfdf4c00, time: 30000, (c01e8e00)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 1, command = cfdf4c64, buffe
r = c0003000,
bufflen = 128, done = c01e425c)
queuecommand : routine at c01eda7c
leaving scsi_dispatch_cmnd()
Leaving scsi_do_req()
Waking error handler thread
Command timed out active=1 busy=1  failed=1
Error handler waking up
scsi_eh_prt_fail_stats: 0:0:1:0 cmds failed: 0, timedout: 1
Total of 1 commands on 1 devices require eh work
scsi_eh_get_sense: checking to see if we need to request sense
scsi_eh_abort_cmd: checking to see if we need to abort cmd


and so on.







> On Mon, Oct 21, 2002 at 01:01:26PM -0700, andy barlak wrote:
> >
> > Sorry,  used the wrong dmesg file for the copy and paste of the error message.
> >
> > yes the printk error message issued is:
> >
> > scsi: Device offlined - not ready or command retry failed after error recovery:
> > host 0 channel 0 id 0 lun 0
> >
> > over and over through all ids, existing or not.
> > Patch was successfully applied to 2.5.44.
>
> I thought it could be one of the INQUIRY related commands to get the
> id/serial numbers, since in your (previous) dmesg output, the failure
> occured after the print_inquiry() call on the same target before any
> upper level attaches.
>
> But now you are getting nothing at all, not even any of the print_inquiry()
> output?
>
> Like you got just before the failures in your original message:
>
> Vendor: CONNER    Model: CFP2107E  2.14GB  Rev: 1423
> Type:   Direct-Access                      ANSI SCSI revision: 02
> Vendor: SEAGATE   Model: SX423451W         Rev: 9E18
> Type:   Direct-Access                      ANSI SCSI revision: 02
>
> Can you turn on all scsi logging - with CONFIG_SCSI_LOGGING enabled,
> on your boot command line add a "scsi_logging=1" and send
> the output.
>
> -- Patrick Mansfield
>

-- 

 Andy Barlak


