Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbUDLL6Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 07:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbUDLL6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 07:58:24 -0400
Received: from lara.gay-web.de ([212.1.48.19]:51679 "EHLO lara.gay-web.de")
	by vger.kernel.org with ESMTP id S262752AbUDLL6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 07:58:15 -0400
Delivery-date: Mon, 12 Apr 2004 13:58:15 +0200
Message-ID: <407A846B.6070807@hamburg.gay-web.de>
Date: Mon, 12 Apr 2004 13:58:35 +0200
From: Christian Kuehn <christian@hamburg.gay-web.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with ieee1394/sbp2 in kernel 2.6.5 (could be an older problem...)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned-By: AMaViS-ng with F-PROT Antivirus, CLAM Anti Virus on lara.gay-web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I try to connect my IOMEGA 120GB external drive via firewire to my
linux-box running 2.6.5.

Loading ieee1394.ko and ohci1394.ko works fine:

Apr 12 13:29:40 gandalf kernel: ohci1394: $Rev: 1172 $ Ben Collins
<bcollins@debian.org>
Apr 12 13:29:40 gandalf kernel: PCI: Found IRQ 10 for device 0000:02:02.0
Apr 12 13:29:40 gandalf kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI):
IRQ=[10]  MMIO=[dfefa800-dfefafff]  Max Packet=[2048]
Apr 12 13:29:41 gandalf kernel: ieee1394: Current remote IRM is not
1394a-2000 compliant, resetting...
Apr 12 13:29:42 gandalf kernel: ieee1394: Node added: ID:BUS[0-00:1023]
  GUID[00d0b80e78009476]
Apr 12 13:29:42 gandalf kernel: ieee1394: Host added: ID:BUS[0-01:1023]
  GUID[0800285600000054]
Apr 12 13:29:42 gandalf kernel: ieee1394: unsolicited response packet
received - no tlabel match



Then loading sbp2.ko :

Apr 12 13:29:46 gandalf kernel: ieee1394: sbp2: sbp2_module_init
Apr 12 13:29:46 gandalf kernel: sbp2: $Rev: 1170 $ Ben Collins
<bcollins@debian.org>
Apr 12 13:29:46 gandalf kernel: ieee1394: sbp2: sbp2_probe
Apr 12 13:29:46 gandalf kernel: ieee1394: sbp2: sbp2_alloc_device
Apr 12 13:29:46 gandalf kernel: ieee1394: sbp2: sbp2_alloc_device:
allocated hostinfo
Apr 12 13:29:46 gandalf kernel: scsi6 : SCSI emulation for IEEE-1394
SBP-2 Devices DEBUG
Apr 12 13:29:46 gandalf kernel: ieee1394: sbp2: sbp2_parse_unit_directory
Apr 12 13:29:46 gandalf kernel: ieee1394: sbp2:
sbp2_management_agent_addr = f0010000
Apr 12 13:29:46 gandalf kernel: ieee1394: sbp2:
sbp2_unit_characteristics = 4008
Apr 12 13:29:46 gandalf kernel: ieee1394: sbp2: sbp2_firmware_revision =
100102
Apr 12 13:29:46 gandalf kernel: ieee1394: sbp2: sbp2_command_set_spec_id
= 609e
Apr 12 13:29:46 gandalf kernel: ieee1394: sbp2: sbp2_command_set = 104d8
Apr 12 13:29:46 gandalf kernel: ieee1394: sbp2: sbp2_start_device
Apr 12 13:29:46 gandalf kernel: ieee1394: sbp2: New SBP-2 device
inserted, SCSI ID = 0
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_login_device
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_login_device:
password_hi/lo initialized
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_login_device:
login_response_hi/lo initialized
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_query_logins: set
lun to 0
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_login_device:
lun_misc initialized
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_login_device:
passwd_resp_lengths initialized
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_login_device:
status FIFO initialized
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_login_device: orb
byte-swapped
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_login_device:
login_response/status FIFO memset
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_login_device:
prepared to write to f0010000
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_handle_status_write
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_login_device: written
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: command_block_agent_hi =
ffc0ffff
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: command_block_agent_lo =
f0010020
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: Logged into SBP-2 device
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_set_busy_timeout
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_agent_reset
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_max_speed_and_size
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: Node 0-00:1023: Max
speed [S400] - Max payload [2048]
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2scsi_queuecommand
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_send_command
Apr 12 13:29:47 gandalf kernel: [scsi command]
Apr 12 13:29:47 gandalf kernel:    0x12 00 00 00 24 00
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: SCSI transfer size = 24
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: SCSI s/g elements = 0
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: No scatter/gather
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_check_sbp2_command
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_handle_status_write
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: Found status for command ORB
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: Completing SCSI command
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2scsi_complete_command
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: sbp2_check_sbp2_response
Apr 12 13:29:47 gandalf kernel: ieee1394: sbp2: Changing TYPE_SDAD to
TYPE_DISK
Apr 12 13:29:47 gandalf kernel:   Vendor: IC35L120  Model: AVV207-0
      Rev:
Apr 12 13:29:47 gandalf kernel:   Type:   Direct-Access
      ANSI SCSI revision: 06
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2scsi_queuecommand
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2_send_command
Apr 12 13:30:30 gandalf kernel: [scsi command]
Apr 12 13:30:30 gandalf kernel:    0x00 00 00 00 00 00
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: SCSI transfer size = 0
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: SCSI s/g elements = 0
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: No data transfer
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2_check_sbp2_command
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2_handle_status_write
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: Found status for command ORB
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: Completing SCSI command
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2scsi_complete_command
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2_check_sbp2_response
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2scsi_queuecommand
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2_send_command
Apr 12 13:30:30 gandalf kernel: [scsi command]
Apr 12 13:30:30 gandalf kernel:    0x25 00 00 00 00 00 00 00 00 00
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: SCSI transfer size = 8
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: SCSI s/g elements = 0
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: No scatter/gather
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2_check_sbp2_command
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2_handle_status_write
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: Found status for command ORB
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: Completing SCSI command
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2scsi_complete_command
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2_check_sbp2_response
Apr 12 13:30:30 gandalf kernel: SCSI device sda: 241254720 512-byte hdwr
sectors (123522 MB)

This looks good, put the problem starts now when I load the
SCSI-disk-driver sd_mod.ko :

Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2scsi_queuecommand
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2_send_command
Apr 12 13:30:30 gandalf kernel: [scsi command]
Apr 12 13:30:30 gandalf kernel:    0x1a 00 08 00 04 00
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: SCSI transfer size = 4
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: SCSI s/g elements = 0
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: No scatter/gather
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2_check_sbp2_command
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: Convert MODE_SENSE_6 to
MODE_SENSE_10
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2_handle_status_write
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: Found status for command ORB
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: Completing SCSI command
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2scsi_complete_command
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2_check_sbp2_response
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: Modify mode sense
response (10 byte version)
Apr 12 13:30:30 gandalf kernel: sda: asking for cache data failed
Apr 12 13:30:30 gandalf kernel: sda: assuming drive cache: write through
Apr 12 13:30:30 gandalf kernel:  sda:<3>ieee1394: sbp2:
sbp2scsi_queuecommand
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2_send_command
Apr 12 13:30:30 gandalf kernel: [scsi command]
Apr 12 13:30:30 gandalf kernel:    0x28 00 00 00 00 00 00 00 08 00
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: SCSI transfer size = 1000
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: SCSI s/g elements = 1
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: Use scatter/gather
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: Only one s/g element
Apr 12 13:30:30 gandalf kernel: ieee1394: sbp2: sbp2_check_sbp2_command
Apr 12 13:31:00 gandalf kernel: ieee1394: sbp2: aborting sbp2 command
Apr 12 13:31:00 gandalf kernel: 0x28 00 00 00 00 00 00 00 08 00
Apr 12 13:31:00 gandalf kernel: ieee1394: sbp2: Found command to abort
Apr 12 13:31:00 gandalf kernel: ieee1394: sbp2: sbp2_agent_reset
Apr 12 13:31:00 gandalf kernel: ieee1394: sbp2:
sbp2scsi_complete_all_commands
Apr 12 13:31:00 gandalf kernel: ieee1394: sbp2: sbp2scsi_queuecommand
Apr 12 13:31:00 gandalf kernel: ieee1394: sbp2: sbp2_send_command
Apr 12 13:31:00 gandalf kernel: [scsi command]
Apr 12 13:31:00 gandalf kernel:    0x00 00 00 00 00 00
Apr 12 13:31:00 gandalf kernel: ieee1394: sbp2: SCSI transfer size = 0
Apr 12 13:31:00 gandalf kernel: ieee1394: sbp2: SCSI s/g elements = 0
Apr 12 13:31:00 gandalf kernel: ieee1394: sbp2: No data transfer
Apr 12 13:31:00 gandalf kernel: ieee1394: sbp2: sbp2_check_sbp2_command
Apr 12 13:31:10 gandalf kernel: ieee1394: sbp2: aborting sbp2 command
Apr 12 13:31:10 gandalf kernel: 0x00 00 00 00 00 00
Apr 12 13:31:10 gandalf kernel: ieee1394: sbp2: Found command to abort
Apr 12 13:31:10 gandalf kernel: ieee1394: sbp2: sbp2_agent_reset
Apr 12 13:31:10 gandalf kernel: ieee1394: sbp2:
sbp2scsi_complete_all_commands
Apr 12 13:31:10 gandalf kernel: ieee1394: sbp2: reset requested
Apr 12 13:31:10 gandalf kernel: ieee1394: sbp2: Generating sbp2 fetch
agent reset
Apr 12 13:31:10 gandalf kernel: ieee1394: sbp2: sbp2_agent_reset
Apr 12 13:31:10 gandalf kernel: ieee1394: sbp2: sbp2scsi_queuecommand
Apr 12 13:31:10 gandalf kernel: ieee1394: sbp2: sbp2_send_command
Apr 12 13:31:10 gandalf kernel: [scsi command]
Apr 12 13:31:10 gandalf kernel:    0x00 00 00 00 00 00
Apr 12 13:31:10 gandalf kernel: ieee1394: sbp2: SCSI transfer size = 0
Apr 12 13:31:10 gandalf kernel: ieee1394: sbp2: SCSI s/g elements = 0
Apr 12 13:31:10 gandalf kernel: ieee1394: sbp2: No data transfer
Apr 12 13:31:10 gandalf kernel: ieee1394: sbp2: sbp2_check_sbp2_command
Apr 12 13:31:20 gandalf kernel: ieee1394: sbp2: aborting sbp2 command
Apr 12 13:31:20 gandalf kernel: 0x00 00 00 00 00 00
Apr 12 13:31:20 gandalf kernel: ieee1394: sbp2: Found command to abort
Apr 12 13:31:20 gandalf kernel: ieee1394: sbp2: sbp2_agent_reset
Apr 12 13:31:20 gandalf kernel: ieee1394: sbp2:
sbp2scsi_complete_all_commands
Apr 12 13:31:20 gandalf kernel: ieee1394: sbp2: reset requested
Apr 12 13:31:20 gandalf kernel: ieee1394: sbp2: Generating sbp2 fetch
agent reset
Apr 12 13:31:20 gandalf kernel: ieee1394: sbp2: sbp2_agent_reset
Apr 12 13:31:30 gandalf kernel: ieee1394: sbp2: sbp2scsi_queuecommand
Apr 12 13:31:30 gandalf kernel: ieee1394: sbp2: sbp2_send_command
Apr 12 13:31:30 gandalf kernel: [scsi command]
Apr 12 13:31:30 gandalf kernel:    0x00 00 00 00 00 00
Apr 12 13:31:30 gandalf kernel: ieee1394: sbp2: SCSI transfer size = 0
Apr 12 13:31:30 gandalf kernel: ieee1394: sbp2: SCSI s/g elements = 0
Apr 12 13:31:30 gandalf kernel: ieee1394: sbp2: No data transfer
Apr 12 13:31:30 gandalf kernel: ieee1394: sbp2: sbp2_check_sbp2_command
Apr 12 13:31:40 gandalf kernel: ieee1394: sbp2: aborting sbp2 command
Apr 12 13:31:40 gandalf kernel: 0x00 00 00 00 00 00
Apr 12 13:31:40 gandalf kernel: ieee1394: sbp2: Found command to abort
Apr 12 13:31:40 gandalf kernel: ieee1394: sbp2: sbp2_agent_reset
Apr 12 13:31:40 gandalf kernel: ieee1394: sbp2:
sbp2scsi_complete_all_commands
Apr 12 13:31:40 gandalf kernel: ieee1394: sbp2: reset requested
Apr 12 13:31:40 gandalf kernel: ieee1394: sbp2: Generating sbp2 fetch
agent reset
Apr 12 13:31:40 gandalf kernel: ieee1394: sbp2: sbp2_agent_reset
Apr 12 13:31:50 gandalf kernel: ieee1394: sbp2: sbp2scsi_queuecommand
Apr 12 13:31:50 gandalf kernel: ieee1394: sbp2: sbp2_send_command
Apr 12 13:31:50 gandalf kernel: [scsi command]
Apr 12 13:31:50 gandalf kernel:    0x00 00 00 00 00 00
Apr 12 13:31:50 gandalf kernel: ieee1394: sbp2: SCSI transfer size = 0
Apr 12 13:31:50 gandalf kernel: ieee1394: sbp2: SCSI s/g elements = 0
Apr 12 13:31:50 gandalf kernel: ieee1394: sbp2: No data transfer
Apr 12 13:31:50 gandalf kernel: ieee1394: sbp2: sbp2_check_sbp2_command
Apr 12 13:32:00 gandalf kernel: ieee1394: sbp2: aborting sbp2 command
Apr 12 13:32:00 gandalf kernel: 0x00 00 00 00 00 00
Apr 12 13:32:00 gandalf kernel: ieee1394: sbp2: Found command to abort
Apr 12 13:32:00 gandalf kernel: ieee1394: sbp2: sbp2_agent_reset
Apr 12 13:32:00 gandalf kernel: ieee1394: sbp2:
sbp2scsi_complete_all_commands
Apr 12 13:32:00 gandalf kernel: scsi: Device offlined - not ready after
error recovery: host 6 channel 0 id 0 lun 0
Apr 12 13:32:00 gandalf kernel: SCSI error : <6 0 0 0> return code = 0x50000
Apr 12 13:32:00 gandalf kernel: end_request: I/O error, dev sda, sector 0
Apr 12 13:32:00 gandalf kernel: Buffer I/O error on device sda, logical
block 0
Apr 12 13:32:00 gandalf kernel: scsi6 (0:0): rejecting I/O to offline device
Apr 12 13:32:00 gandalf kernel: Buffer I/O error on device sda, logical
block 0
Apr 12 13:32:00 gandalf kernel:  unable to read partition table
Apr 12 13:32:00 gandalf kernel: Attached scsi disk sda at scsi6, channel
0, id 0, lun 0


It is a problem in sbp2 or in sd_mod (or scsi generally) ??

Any ideas ?


Best Regards
Christian


