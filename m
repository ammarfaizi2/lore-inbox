Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWCaWQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWCaWQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 17:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWCaWQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 17:16:47 -0500
Received: from smtpout.mac.com ([17.250.248.89]:6116 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751418AbWCaWQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 17:16:46 -0500
In-Reply-To: <7647B5D6-5E19-4614-A765-B28F9D7ED992@mac.com>
References: <20060328090211.4D6F34C04A@penelope.moffetthome.net> <7647B5D6-5E19-4614-A765-B28F9D7ED992@mac.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9BA602B9-F1DB-4374-A35F-F68F8CB50326@mac.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
Date: Fri, 31 Mar 2006 17:16:23 -0500
To: LKML Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't received any response to this email over the last several  
days, so I'm resending it in hopes that someone can help me track  
down the problem.  Thanks!

On Mar 28, 2006, at 12:57:29, Kyle Moffett wrote:
> I'm getting the following errors in my syslog on a fairly regular  
> basis (1 or 2 per hour).  They seem to have started when I upgraded  
> from Debian 2.6.12-1-powerpc (with internal IDE patch) to Debian  
> 2.6.15-1-powerpc.  My best guess is for some reason the kernel  
> started issuing the command MULTWRITE_EXT that it didn't before,  
> and one of my drives doesn't like it.  Two of the drives are  
> attached to a Promise PDC20268 (Rebranded a couple times by  
> different manufacturers and with mac-bootable firmware), the third  
> is attached to the internal ATA66 bus in the 400MHz powermac G4.   
> My apologies if this problem is known and fixed in 2.6.16; if  
> necessary I'll wait until Debian testing gets a 2.6.16 kernel and  
> test that too.

A few extra notes:  The system is a Samba fileserver for a collection  
of Windows XP clients, but the pattern of errors does not seem to be  
triggered by load, including the daily backups.  The hourly smart  
checks also appear to have nothing to do with the error messages;  
sometimes I'll get 10 in the middle of the night, other times almost  
a full day of reasonable load will go by without a single message.

> Thanks for the help!
>
> Cheers,
> Kyle Moffett
>
> Begin forwarded message:
>> Security Events
>> =-=-=-=-=-=-=-=
>> Mar 28 03:15:13 penelope kernel: ide: failed opcode was: unknown
>> Mar 28 03:30:13 penelope kernel: ide: failed opcode was: unknown
>>
>> System Events
>> =-=-=-=-=-=-=
>> Mar 28 03:15:13 penelope kernel: hdi: status timeout: status=0xd0  
>> { Busy }
>> Mar 28 03:15:13 penelope kernel: PDC202XX: Secondary channel reset.
>> Mar 28 03:15:13 penelope kernel: hdi: no DRQ after issuing  
>> MULTWRITE_EXT
>> Mar 28 03:15:13 penelope kernel: ide4: reset: success
>> Mar 28 03:30:13 penelope kernel: hdi: status timeout: status=0xd0  
>> { Busy }
>> Mar 28 03:30:13 penelope kernel: PDC202XX: Secondary channel reset.
>> Mar 28 03:30:13 penelope kernel: hdi: no DRQ after issuing  
>> MULTWRITE_EXT
>> Mar 28 03:30:13 penelope kernel: ide4: reset: success
>
> smartctl -a:
>> smartctl version 5.34 [powerpc-unknown-linux-gnu] Copyright (C)  
>> 2002-5 Bruce Allen
>> Home page is http://smartmontools.sourceforge.net/
>>
>> === START OF INFORMATION SECTION ===
>> Device Model:     SAMSUNG SP0822N
>> Serial Number:    S06QJ10Y946116
>> Firmware Version: WA100-32
>> User Capacity:    80,060,424,192 bytes
>> Device is:        In smartctl database [for details use: -P show]
>> ATA Version is:   6
>> ATA Standard is:  ATA/ATAPI-6 T13 1410D revision 1
>> Local Time is:    Tue Mar 28 12:54:35 2006 EST
>> SMART support is: Available - device has SMART capability.
>> SMART support is: Enabled
>>
>> === START OF READ SMART DATA SECTION ===
>> SMART overall-health self-assessment test result: PASSED
>>
>> General SMART Values:
>> Offline data collection status:  (0x84) Offline data collection  
>> activity
>>                                         was suspended by an  
>> interrupting command from host.
>>                                         Auto Offline Data  
>> Collection: Enabled.
>> Self-test execution status:      (   0) The previous self-test  
>> routine completed
>>                                         without error or no self- 
>> test has ever
>>                                         been run.
>> Total time to complete Offline
>> data collection:                 (1980) seconds.
>> Offline data collection
>> capabilities:                    (0x5b) SMART execute Offline  
>> immediate.
>>                                         Auto Offline data  
>> collection on/off support.
>>                                         Suspend Offline collection  
>> upon new
>>                                         command.
>>                                         Offline surface scan  
>> supported.
>>                                         Self-test supported.
>>                                         No Conveyance Self-test  
>> supported.
>>                                         Selective Self-test  
>> supported.
>> SMART capabilities:            (0x0003) Saves SMART data before  
>> entering
>>                                         power-saving mode.
>>                                         Supports SMART auto save  
>> timer.
>> Error logging capability:        (0x01) Error logging supported.
>>                                         No General Purpose Logging  
>> support.
>> Short self-test routine
>> recommended polling time:        (   2) minutes.
>> Extended self-test routine
>> recommended polling time:        (  33) minutes.
>>
>> SMART Attributes Data Structure revision number: 17
>> Vendor Specific SMART Attributes with Thresholds:
>> ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE       
>> UPDATED  WHEN_FAILED RAW_VALUE
>>   1 Raw_Read_Error_Rate     0x000f   100   099   051    Pre-fail   
>> Always       -       0
>>   3 Spin_Up_Time            0x0007   252   252   011    Pre-fail   
>> Always       -       0
>>   4 Start_Stop_Count        0x0032   252   252   000    Old_age    
>> Always       -       0
>>   5 Reallocated_Sector_Ct   0x0033   252   252   011    Pre-fail   
>> Always       -       0
>>   7 Seek_Error_Rate         0x000f   252   252   051    Pre-fail   
>> Always       -       0
>>   8 Seek_Time_Performance   0x0025   092   092   015    Pre-fail   
>> Offline      -       3665
>>   9 Power_On_Half_Minutes   0x0032   099   099   000    Old_age    
>> Always       -       32h+43m
>> 10 Spin_Retry_Count        0x0033   252   252   051    Pre-fail   
>> Always       -       0
>> 11 Calibration_Retry_Count 0x0012   252   252   000    Old_age    
>> Always       -       0
>> 12 Power_Cycle_Count       0x0032   252   252   000    Old_age    
>> Always       -       0
>> 190 Unknown_Attribute       0x0022   154   133   000    Old_age    
>> Always       -       33
>> 194 Temperature_Celsius     0x0022   151   133   000    Old_age    
>> Always       -       34
>> 195 Hardware_ECC_Recovered  0x001a   100   100   000    Old_age    
>> Always       -       0
>> 196 Reallocated_Event_Count 0x0032   252   252   000    Old_age    
>> Always       -       0
>> 197 Current_Pending_Sector  0x0012   252   252   000    Old_age    
>> Always       -       0
>> 198 Offline_Uncorrectable   0x0030   252   252   000    Old_age    
>> Offline      -       0
>> 199 UDMA_CRC_Error_Count    0x003e   199   199   000    Old_age    
>> Always       -       173
>> 200 Multi_Zone_Error_Rate   0x000a   100   100   000    Old_age    
>> Always       -       0
>> 201 Soft_Read_Error_Rate    0x000a   100   100   000    Old_age    
>> Always       -       0
>>
>> Warning! SMART ATA Error Log Structure error: invalid SMART checksum.
>> SMART Error Log Version: 1
>> No Errors Logged
>>
>> SMART Self-test log structure revision number 0
>> Warning: ATA Specification requires self-test log structure  
>> revision number = 1
>> Num  Test_Description    Status                  Remaining   
>> LifeTime(hours)  LBA_of_first_error
>> # 1  Short offline       Completed without error       00%       
>> 3918         -
>> # 2  Short offline       Completed without error       00%       
>> 3894         -
>> # 3  Extended offline    Interrupted (host reset)      30%       
>> 3870         -
>> # 4  Short offline       Completed without error       00%       
>> 3846         -
>> # 5  Short offline       Completed without error       00%       
>> 3822         -
>> # 6  Short offline       Completed without error       00%       
>> 3798         -
>> # 7  Short offline       Completed without error       00%       
>> 3774         -
>> # 8  Short offline       Completed without error       00%       
>> 3750         -
>> # 9  Short offline       Completed without error       00%       
>> 3726         -
>> #10  Extended offline    Completed without error       00%       
>> 3703         -
>> #11  Short offline       Completed without error       00%       
>> 3678         -
>> #12  Short offline       Completed without error       00%       
>> 3654         -
>> #13  Short offline       Completed without error       00%       
>> 3630         -
>> #14  Short offline       Completed without error       00%       
>> 3606         -
>> #15  Short offline       Completed without error       00%       
>> 3582         -
>> #16  Short offline       Completed without error       00%       
>> 3558         -
>> #17  Extended offline    Completed without error       00%       
>> 3535         -
>> #18  Short offline       Completed without error       00%       
>> 3511         -
>> #19  Short offline       Completed without error       00%       
>> 3487         -
>> #20  Short offline       Completed without error       00%       
>> 3463         -
>> #21  Short offline       Completed without error       00%       
>> 3439         -
>>
>> SMART Selective Self-Test Log Data Structure Revision Number (0)  
>> should be 1
>> SMART Selective self-test log data structure revision number 0
>> Warning: ATA Specification requires selective self-test log data  
>> structure revision number = 1
>> SPAN          MIN_LBA          MAX_LBA  CURRENT_TEST_STATUS
>>     1                0                0  Not_testing
>>     2                0                0  Not_testing
>>     3  281479271677952                0  Not_testing
>>     4                0  281479271767952  Not_testing
>>     5           604800                4  Not_testing
>> Selective self-test flags (0x0):
>>   After scanning selected spans, do NOT read-scan remainder of disk.
>> If Selective self-test is pending on power-up, resume after 0  
>> minute delay.
