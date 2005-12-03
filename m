Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVLCBRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVLCBRR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 20:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVLCBRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 20:17:16 -0500
Received: from pffamerica.com ([69.222.0.23]:51726 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S1751131AbVLCBRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 20:17:16 -0500
Date: Fri,  2 Dec 2005 19:18:01 -0600
Message-Id: <200512021918.AA134021646@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
CC: <greg@kroah.com>
Subject: RE: SMART over USB - problem
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SMART over USB - problem

usb--------------------------------------------------------
# smartctl -a -T verypermissive /dev/sde
smartctl version 5.33 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

Device: WDC WD25 00JB-00GVA0      Version: 08.0
scsiModePageOffset: response length too short, resp_len=4 offset=4 bd_len=0
>> Terminate command early due to bad response to IEC mode page

Error Counter logging not supported

Error Events logging not supported
scsiModePageOffset: response length too short, resp_len=4 offset=4 bd_len=0
Device does not support Self Test logging

# smartctl -a -T verypermissive /dev/sdd
smartctl version 5.33 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

Device: WDC WD30 00JB-00KFA0      Version: 08.0
scsiModePageOffset: response length too short, resp_len=4 offset=4 bd_len=0
>> Terminate command early due to bad response to IEC mode page

Error Counter logging not supported

Error Events logging not supported
scsiModePageOffset: response length too short, resp_len=4 offset=4 bd_len=0
Device does not support Self Test logging

ide----------------------------------------------------------
# smartctl -a -T verypermissive /dev/hda
smartctl version 5.33 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD1200BB-22CAA0
Serial Number:    WD-WMA8Cxxxxxxx
Firmware Version: 16.06V16
User Capacity:    120,034,123,776 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   5
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Thu Dec  1 14:17:57 2005 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                        was completed without error.
                                        Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test routine completed
                                        without error or no self-test has ever
                                        been run.
Total time to complete Offline
data collection:                 (4680) seconds.
Offline data collection
capabilities:                    (0x3b) SMART execute Offline immediate.
                                        Auto Offline data collection on/off supp ort.
                                        Suspend Offline collection upon new
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        Conveyance Self-test supported.
                                        No Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        No General Purpose Logging support.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        (  87) minutes.
Conveyance self-test routine
recommended polling time:        (   5) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_ FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000b   200   200   051    Pre-fail  Always       -        0
  3 Spin_Up_Time            0x0007   099   091   021    Pre-fail  Always       -        5841
  4 Start_Stop_Count        0x0032   100   100   040    Old_age   Always       -        708
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always       -        0
  7 Seek_Error_Rate         0x000b   200   200   051    Pre-fail  Always       -        0
  9 Power_On_Hours          0x0032   086   086   000    Old_age   Always       -        10517
10 Spin_Retry_Count        0x0013   100   100   051    Pre-fail  Always       -        0
11 Calibration_Retry_Count 0x0013   100   100   051    Pre-fail  Always       -        0
12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -        686
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always       -        0
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always       -        0
198 Offline_Uncorrectable   0x0012   200   200   000    Old_age   Always       -        0
199 UDMA_CRC_Error_Count    0x000a   200   253   000    Old_age   Always       -        0
200 Multi_Zone_Error_Rate   0x0009   200   200   051    Pre-fail  Offline      -        0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]


Device does not support Selective Self Tests/Logging
#
-----------------------------------------------------------------------

ide---works
usb---not

(USB-external-case) or (eide-usb-scsi conversion) ???

xboom 

--------------------------------------------------------------------------------------

On Fri, Dec 02, 2005 at 05:28:42PM -0600, art wrote:
> > SMART over USB - problem

Do you expect it to work?  USB storage is really scsi, so I doubt this
will ever work like you are expecting it to.

sorry,

greg k-h





SCSI-----------------------------------------------------------------------------------

# smartctl -a /dev/sdb
smartctl version 5.33 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

Device: COMPAQ   BF14688286       Version: HPB3
Serial number: 3KN04A1X0000xxxxxxxx
Device type: disk
Transport protocol: Parallel SCSI (SPI-4)
Local Time is: Fri Dec  2 19:00:19 2005 CST
Device supports SMART and is Enabled
Temperature Warning Enabled
SMART Health Status: OK

Current Drive Temperature:     38 C
Drive Trip Temperature:        68 C
Vendor (Seagate) cache information
  Blocks sent to initiator = 1682981317
  Blocks received from initiator = 330361456
  Blocks read from cache and sent to initiator = 84738089
  Number of read and write commands whose size <= segment size = 374742809
  Number of read and write commands whose size > segment size = 120394

Error counter log:
           Errors Corrected by           Total   Correction     Gigabytes    Total
               EEC          rereads/    errors   algorithm      processed    uncorrected
           fast | delayed   rewrites  corrected  invocations   [10^9 bytes]  errors
read:          0        0         0         0          0          0.000           0
write:         0        0         0         0          0          0.000           0

Non-medium error count:        0

Error Events logging not supported

SMART Self-test log
Num  Test              Status                 segment  LifeTime  LBA_first_err [SK ASC ASQ]
     Description                              number   (hours)
# 1  Background long   Interrupted ('-X' switch)   -   354                   - [-   -    -]
# 2  Background long   Interrupted ('-X' switch)   -   354                   - [-   -    -]
# 3  Background long   Interrupted ('-X' switch)   -   354                   - [-   -    -]
# 4  Background long   Interrupted ('-X' switch)   -   313                   - [-   -    -]
# 5  Background long   Interrupted ('-X' switch)   -   313                   - [-   -    -]
# 6  Background long   Interrupted ('-X' switch)   -   313                   - [-   -    -]
# 7  Background short  Completed                   -     0                   - [-   -    -]

Long (extended) Self Test duration: 2102 seconds [35.0 minutes]
#

greg

works on SCSI/IDE why not on IDE over USB/IEEE1394/iSCSI/SAN... ???

is the problem in my external usb box or in linux usb/scsi stack ???

xboom
