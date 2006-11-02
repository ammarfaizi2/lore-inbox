Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWKBPa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWKBPa6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 10:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWKBPa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 10:30:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:62784 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751010AbWKBPa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 10:30:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=I1ytqFCKzE0tMUKJAipzZDFdR5FBw1A15gpVmKxlxdPXZL9ljIbnH/qV0aQxb4Zfq0GeCTZfY31zMbnpxyqLvkBHj+6ck75a2WhiALcmbrc0Bq0ZBzw19Fh6ha5uyMb8akWjGjNTPDR+DhNyDpkXCcgx6jjeL/tqYXe8TYiVDak=
Message-ID: <454A0F2B.5060603@gmail.com>
Date: Thu, 02 Nov 2006 19:30:51 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hdb lost interrupt
References: <4549B305.7040106@gmail.com> <1162473087.11965.182.camel@localhost.localdomain>
In-Reply-To: <1162473087.11965.182.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-11-02 am 12:57 +0400, ysgrifennodd Manu Abraham:
>> Any idea as to what could be causing the lost interrupt ?
> 
> It may have been a drive fault. Check the SMART information on the drive
> and see what the disk has logged recently.
> 
>

running smartctl -a gave me this ..

[root@Orbit01 ~]# smartctl -a /dev/hdb
smartctl version 5.33 [i386-redhat-linux-gnu] Copyright (C) 2002-4 Bruce
Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD2500BB-00DWA0
Serial Number:    WD-WMAEH2436571
Firmware Version: 15.05R15
User Capacity:    250,059,350,016 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   6
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Thu Nov  2 19:08:15 2006 GST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                        was completed without error.
                                        Auto Offline Data Collection:
Enabled.
Self-test execution status:      (   0) The previous self-test routine
completed
                                        without error or no self-test
has ever
                                        been run.
Total time to complete Offline
data collection:                 (7599) seconds.
Offline data collection
capabilities:                    (0x79) SMART execute Offline immediate.
                                        No Auto Offline data collection
support.
                                        Suspend Offline collection upon new
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        Conveyance Self-test supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        No General Purpose Logging support.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        (  95) minutes.
Conveyance self-test routine
recommended polling time:        (   5) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000b   200   200   051    Pre-fail  Always
      -       0
  3 Spin_Up_Time            0x0007   152   119   021    Pre-fail  Always
      -       2933
  4 Start_Stop_Count        0x0032   100   100   040    Old_age   Always
      -       127
  5 Reallocated_Sector_Ct   0x0033   199   199   140    Pre-fail  Always
      -       1
  7 Seek_Error_Rate         0x000b   200   200   051    Pre-fail  Always
      -       0
  9 Power_On_Hours          0x0032   083   083   000    Old_age   Always
      -       12676
 10 Spin_Retry_Count        0x0013   100   100   051    Pre-fail  Always
      -       0
 11 Calibration_Retry_Count 0x0013   100   253   051    Pre-fail  Always
      -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always
      -       97
194 Temperature_Celsius     0x0022   118   253   000    Old_age   Always
      -       32
196 Reallocated_Event_Count 0x0032   199   199   000    Old_age   Always
      -       1
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always
      -       5
198 Offline_Uncorrectable   0x0012   200   200   000    Old_age   Always
      -       0
199 UDMA_CRC_Error_Count    0x000a   200   253   000    Old_age   Always
      -       0
200 Multi_Zone_Error_Rate   0x0009   200   155   051    Pre-fail
Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]


SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.


[root@Orbit01 ~]# smartctl -H /dev/hdb
smartctl version 5.33 [i386-redhat-linux-gnu] Copyright (C) 2002-4 Bruce
Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED




After which i ran,

[root@Orbit01 ~]# smartctl -t long /dev/hdb

This started to give the same click's as earlier, dmesg, has quite some
info ..



[17207074.632000] hdd: command error: status=0x51 { DriveReady
SeekComplete Error }
[17207074.632000] hdd: command error: error=0x54 { AbortedCommand
LastFailedSense=0x05 }
[17207074.632000] ide: failed opcode was: unknown
[17207074.632000] end_request: I/O error, dev hdd, sector 0
[17207074.632000] Buffer I/O error on device hdd, logical block 0
[17207074.632000] hdd: command error: status=0x51 { DriveReady
SeekComplete Error }
[17207074.632000] hdd: command error: error=0x54 { AbortedCommand
LastFailedSense=0x05 }
[17207074.632000] ide: failed opcode was: unknown
[17207074.632000] end_request: I/O error, dev hdd, sector 0
[17207074.632000] Buffer I/O error on device hdd, logical block 0
[17207074.636000] hdd: command error: status=0x51 { DriveReady
SeekComplete Error }
[17207074.636000] hdd: command error: error=0x54 { AbortedCommand
LastFailedSense=0x05 }
[17207074.636000] ide: failed opcode was: unknown
[17207074.636000] end_request: I/O error, dev hdd, sector 0
[17207074.636000] Buffer I/O error on device hdd, logical block 0
[17207074.636000] hdd: command error: status=0x51 { DriveReady
SeekComplete Error }
[17207074.636000] hdd: command error: error=0x54 { AbortedCommand
LastFailedSense=0x05 }
[17207074.636000] ide: failed opcode was: unknown
[17207074.636000] end_request: I/O error, dev hdd, sector 0
[17207074.636000] Buffer I/O error on device hdd, logical block 0
[17207074.640000] hdd: command error: status=0x51 { DriveReady
SeekComplete Error }
[17207074.640000] hdd: command error: error=0x54 { AbortedCommand
LastFailedSense=0x05 }
[17207074.640000] ide: failed opcode was: unknown
[17207074.640000] end_request: I/O error, dev hdd, sector 0
[17207074.640000] Buffer I/O error on device hdd, logical block 0

..

[17207074.796000] end_request: I/O error, dev hdd, sector 0
[17207074.796000] hdd: command error: status=0x51 { DriveReady
SeekComplete Error }
[17207074.796000] hdd: command error: error=0x54 { AbortedCommand
LastFailedSense=0x05 }
[17207074.796000] ide: failed opcode was: unknown
[17207074.796000] end_request: I/O error, dev hdd, sector 0
[17207293.072000] ISO 9660 Extensions: Microsoft Joliet Level 3
[17207293.108000] ISO 9660 Extensions: RRIP_1991A
[17207531.412000] hdb: dma_intr: status=0x30 { DeviceFault SeekComplete }
[17207531.412000] ide: failed opcode was: unknown
[17207531.412000] hda: DMA disabled
[17207531.412000] hdb: DMA disabled
[17207534.628000] ide0: reset: success
[17208781.840000] hdb: drive_cmd: status=0x30 { DeviceFault SeekComplete }
[17208781.840000] ide: failed opcode was: 0xb0


stopping smartctrl (-X) caused the clicks to go away.


Regards,
Manu

