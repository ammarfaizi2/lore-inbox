Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSJYUla>; Fri, 25 Oct 2002 16:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSJYUla>; Fri, 25 Oct 2002 16:41:30 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:40148 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S261573AbSJYUl1>; Fri, 25 Oct 2002 16:41:27 -0400
Message-ID: <3DB9AEAC.4070804@drugphish.ch>
Date: Fri, 25 Oct 2002 22:50:52 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Possible broken IBM IDE disk (Dell I8k Laptop)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andre,

Could you once again give me your expert advice, please? I think this 
drive is going to drop dead soon as it starts making weird noises after 
a few hours of working. If I shut down the laptop for roughly 2-4 hours 
I can work again with it. What is your opinion on the drive's status? Do 
you need any other information?

laphish:~ # tail /var/log/kernlog
Oct 25 17:42:00 s_int@laphish NVRM: AGPGART: aperture: 64M @ 0xe8000000
Oct 25 17:42:00 s_int@laphish NVRM: AGPGART: aperture mapped from 
0xe8000000 to 0xe39e6000
Oct 25 17:42:00 s_int@laphish NVRM: AGPGART: mode 4x
Oct 25 17:42:00 s_int@laphish NVRM: AGPGART: allocated 16 pages
Oct 25 17:55:13 s_int@laphish hda: timeout waiting for DMA
Oct 25 17:55:13 s_int@laphish ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
Oct 25 17:55:13 s_int@laphish hda: status timeout: status=0xd0 { Busy }
Oct 25 17:55:13 s_int@laphish hdb: DMA disabled
Oct 25 17:55:13 s_int@laphish hda: drive not ready for command
Oct 25 17:55:15 s_int@laphish ide0: reset: success
laphish:~ # smartctl -a /dev/hda
Device: IBM-DJSA-232  Supports ATA Version 5
Drive supports S.M.A.R.T. and is enabled
Check S.M.A.R.T. Passed.

General Smart Values:
Off-line data collection status: (0x04) Offline data collection activity was
                                         suspended by an interrupting 
command

Self-test execution status:      (   0) The previous self-test routine 
completed
                                         without error or no self-test 
has ever
                                         been run

Total time to complete off-line
data collection:                 ( 550) Seconds

Offline data collection
Capabilities:                    (0x1b)SMART EXECUTE OFF-LINE IMMEDIATE
                                         Automatic timer ON/OFF support
                                         Suspend Offline Collection upon new
                                         command
                                         Offline surface scan supported
                                         Self-test supported

Smart Capablilities:           (0x0003) Saves SMART data before entering
                                         power-saving mode
                                         Supports SMART auto save timer

Error logging capability:        (0x01) Error logging supported

Short self-test routine
recommended polling time:        (   2) Minutes

Extended self-test routine
recommended polling time:        (  41) Minutes

Vendor Specific SMART Attributes with Thresholds:
Revision Number: 16
Attribute                    Flag     Value Worst Threshold Raw Value
(  1)Raw Read Error Rate     0x000b   100   100   062       0
(  2)Throughput Performance  0x0005   100   100   040       0
(  3)Spin Up Time            0x0007   152   152   033       31
(  4)Start Stop Count        0x0012   100   100   000       816
(  5)Reallocated Sector Ct   0x0033   100   100   005       0
(  7)Seek Error Rate         0x000b   100   100   067       0
(  8)Seek Time Preformance   0x0005   100   100   040       0
(  9)Power On Hours          0x0012   085   085   000       6647
( 10)Spin Retry Count        0x0013   100   100   060       0
( 12)Power Cycle Count       0x0032   100   100   000       692
(191)Gsense Error Rate       0x000a   100   100   000       0
(192)Power-Off Retract Count 0x0032   100   100   000       17
(193)Load Cycle Count        0x0012   030   030   000       708476
(196)Reallocated Event Count 0x0032   100   100   000       48
(197)Current Pending Sector  0x0022   100   100   000       0
(198)Offline Uncorrectable   0x0008   100   100   000       0
(199)UDMA CRC Error Count    0x000a   200   200   000       0
SMART Error Log:
SMART Error Logging Version: 1
Error Log Data Structure Pointer: 03
ATA Error Count: 3
Non-Fatal Count: 0

Error Log Structure 1:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
  00   ff   01   b9   ce   12    e0   c4     21
  00   ff   01   ba   ce   12    e0   c4     21
  00   ff   01   bb   ce   12    e0   c4     21
  00   ff   01   bc   ce   12    e0   c4     21
  00   ff   01   bd   ce   12    e0   c4     21
  00   40   09   b0   b2   38    e0   59     0
Error condition:   0    Error State:       3
Number of Hours in Drive Life: 6622 (life of the drive in hours)

Error Log Structure 2:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
  00   ff   01   af   ce   12    e0   c4     21
  00   ff   01   b0   ce   12    e0   c4     21
  00   ff   01   b1   ce   12    e0   c4     21
  00   ff   01   b2   ce   12    e0   c4     21
  00   ff   01   b3   ce   12    e0   c4     21
  00   40   0e   2b   b4   38    e0   59     0
Error condition:   0    Error State:       3
Number of Hours in Drive Life: 6622 (life of the drive in hours)

Error Log Structure 3:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
  04   ff   01   b4   ce   12    e0   c4     21
  00   ff   01   b5   ce   12    e0   c4     21
  00   ff   01   b6   ce   12    e0   c4     21
  00   ff   01   b7   ce   12    e0   c4     21
  00   ff   01   b8   ce   12    e0   c4     21
  00   01   0b   2e   b4   38    e0   59     0
Error condition:   0    Error State:       3
Number of Hours in Drive Life: 6622 (life of the drive in hours)
laphish:~ # cat /proc/ide/hda/settings
name                    value           min             max             mode
----                    -----           ---             ---             ----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                3890            0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
breada_readahead        8               0               255             rw
bswap                   0               0               1               r
current_speed           68              0               69              rw
failures                0               0               65535           rw
file_readahead          124             0               16384           rw
ide_scsi                0               0               1               rw
init_speed              68              0               69              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
max_kb_per_request      128             1               255             rw
multcount               0               0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw
wcache                  0               0               1               rw
laphish:~ # cat /proc/ide/piix

                                 Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel 
-------------
                  enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- 
drive1 ------
DMA enabled:    yes              no              yes               no
UDMA enabled:   yes              yes             no                no
UDMA enabled:   4                4               X                 X
UDMA
DMA
PIO
laphish:~ # hdparm -I /dev/hda

/dev/hda:

non-removable ATA device, with non-removable media
         Model Number:           IBM-DJSA-232
         Serial Number:                   48W48LW9933
         Firmware Revision:      JS8OAD0A
Standards:
         Used: ATA/ATAPI-5 T13 1321D revision 1
         Supported: 2 3 4 5
Configuration:
         Logical         max     current
         cylinders       16383   16383
         heads           16      16
         sectors/track   63      63
         bytes/track:    0               (obsolete)
         bytes/sector:   0               (obsolete)
         current sector capacity: 16514064
         LBA user addressable sectors = 62506080
Capabilities:
         LBA, IORDY(can be disabled)
         Buffer size: 1874.5kB   ECC bytes: 4    Queue depth: 1
         Standby timer values: spec'd by Vendor, no device specific minimum
         r/w multiple sector transfer: Max = 16  Current = 16
         Advanced power management level: 16512
         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
         Enabled Supported:
            *    NOP cmd
            *    READ BUFFER cmd
            *    WRITE BUFFER cmd
            *    Host Protected Area feature set
            *    look-ahead
            *    write cache
            *    Power Management feature set
                 Security Mode feature set
            *    SMART feature set
                 SET MAX security extension
                 Address offset used (large drive)
                 Power-Up In Standby feature set
            *    Advanced Power Management feature set
Security:
         Master password revision code = 65534
                 supported
         not     enabled
         not     locked
                 frozen
         not     expired: security count
         not     supported: enhanced erase
         42min for SECURITY ERASE UNIT.
HW reset results:
         CBLID- above Vih
         Device num = 0 determined by the jumper
Checksum: correct
laphish:~ # echo "6622/24" | bc -l
275.91666666666666666666
laphish:~ #

Hey, I mean, they must be kidding me, after close to 276 days this 
bloody thing stops working correctly?

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

