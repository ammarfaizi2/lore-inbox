Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbTL0Mwb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 07:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbTL0Mwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 07:52:31 -0500
Received: from alfa.fastwebnet.it ([213.140.2.55]:60820 "EHLO
	alfa.fastwebnet.it") by vger.kernel.org with ESMTP id S264391AbTL0Mw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 07:52:27 -0500
Subject: Re: Ooops with kernel 2.4.22 and reiserfs
From: Carlo <devel@integra-sc.it>
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: dan carpenter <error27@email.com>, Oleg Drokin <green@linuxhacker.ru>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0312251946460.2554-100000@dirac.phys.uwm.edu>
References: <Pine.GSO.4.21.0312251946460.2554-100000@dirac.phys.uwm.edu>
Content-Type: text/plain
Message-Id: <1072529558.21200.111.camel@atena>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 13:52:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Il ven, 2003-12-26 alle 02:47, Bruce Allen ha scritto:
> > > > C> hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
> > > > C> DataRequest }
> > > > C> ide0: Drive 0 didn't accept speed setting. Oh, well.
> > > > C> hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> > > > C> hda: CHECK for good STATUS
> > > >
> > 
> > I would check for SMARTerrors:  smartctl -a /dev/hda 
> > Also you could try running badblocks on the drive.
> 
> Run some drive self-tests:
>    smartctl -t long /dev/hda
> and let them complete, then look again at
>    smartctl -a /dev/hda
> 
smartctl version 5.26 Copyright (C) 2002-3 Bruce Allen
Home page is http://smartmontools.sourceforge.net/
                                                                                                 
=== START OF INFORMATION SECTION ===
Device Model:     Maxtor 6Y120L0
Serial Number:    Y3K9Q2GE
Firmware Version: YAR41BW0
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
Local Time is:    Sat Dec 27 13:42:50 2003 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
                                                                                                 
=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED
                                                                                                 
General SMART Values:
Offline data collection status:  (0x80) Offline data collection activity
was
                                        never started.
                                        Auto Offline Data Collection:
Enabled.
Self-test execution status:      (   0) The previous self-test routine
completed
                                        without error or no self-test
has ever
                                        been run.
Total time to complete Offline
1data collection:                 ( 242) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                        Auto Offline data collection
on/off support.
                                        Suspend Offline collection upon
new
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        No Conveyance Self-test
supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        No General Purpose Logging
support.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        (  54) minutes.
                                                                                                 
SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE     
UPDATED  WHEN_FAILED RAW_VALUE
  3 Spin_Up_Time            0x0027   204   204   063    Pre-fail 
Always       -       5709
  4 Start_Stop_Count        0x0032   253   253   000    Old_age  
Always       -       28
  5 Reallocated_Sector_Ct   0x0033   253   253   063    Pre-fail 
Always       -       0
  6 Read_Channel_Margin     0x0001   253   253   100    Pre-fail 
Offline      -       0
  7 Seek_Error_Rate         0x000a   253   252   000    Old_age  
Always       -       0
  8 Seek_Time_Performance   0x0027   251   245   187    Pre-fail 
Always       -       57965
  9 Power_On_Minutes        0x0032   250   250   000    Old_age  
Always       -       1064h+20m
 10 Spin_Retry_Count        0x002b   253   252   157    Pre-fail 
Always       -       0
 11 Calibration_Retry_Count 0x002b   253   252   223    Pre-fail 
Always       -       0
 12 Power_Cycle_Count       0x0032   253   253   000    Old_age  
Always       -       53
192 Power-Off_Retract_Count 0x0032   253   253   000    Old_age  
Always       -       0
193 Load_Cycle_Count        0x0032   253   253   000    Old_age  
Always       -       0
194 Temperature_Celsius     0x0032   253   253   000    Old_age  
Always       -       31
195 Hardware_ECC_Recovered  0x000a   253   252   000    Old_age  
Always       -       6759
196 Reallocated_Event_Count 0x0008   253   253   000    Old_age  
Offline      -       0
197 Current_Pending_Sector  0x0008   253   253   000    Old_age  
Offline      -       0
198 Offline_Uncorrectable   0x0008   253   253   000    Old_age  
Offline      -       0
199 UDMA_CRC_Error_Count    0x0008   199   199   000    Old_age  
Offline      -       0
200 Multi_Zone_Error_Rate   0x000a   253   252   000    Old_age  
Always       -       0
201 Soft_Read_Error_Rate    0x000a   253   248   000    Old_age  
Always       -       2
202 TA_Increase_Count       0x000a   253   252   000    Old_age  
Always       -       0
203 Run_Out_Cancel          0x000b   253   252   180    Pre-fail 
Always       -       0
204 Shock_Count_Write_Opern 0x000a   253   252   000    Old_age  
Always       -       0
205 Shock_Rate_Write_Opern  0x000a   253   252   000    Old_age  
Always       -       0
207 Spin_High_Current       0x002a   253   252   000    Old_age  
Always       -       0
208 Spin_Buzz               0x002a   253   252   000    Old_age  
Always       -       0
209 Offline_Seek_Performnce 0x0024   197   197   000    Old_age  
Offline      -       0
 99 Unknown_Attribute       0x0004   253   253   000    Old_age  
Offline      -       0
100 Unknown_Attribute       0x0004   253   253   000    Old_age  
Offline      -       0
101 Unknown_Attribute       0x0004   253   253   000    Old_age  
Offline      -       0
                                                                                                 
SMART Error Log Version: 1
No Errors Logged
                                                                                                 
SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining 
LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%      
997         -
                                                                                                 
Some ideas??

Saluti Carlo!



> Cheers,
> 	Bruce
> 
> 

