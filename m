Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVBDJFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVBDJFL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 04:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVBDJFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 04:05:10 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:19121 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262950AbVBDJDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 04:03:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=KZ7UVZj7+lIWIQmf3QgZrF1xOA/C9ExV5xBrHcGoZ4EZpwpZgRl3HCTQ2uhhYlOdwsXCqwhaIdaspB0pzqAHZbYR41Tb8J4Hso+UfH5WXG3Oo8VWu1nxH+Nmlz1DuMCAL7xQDKSdOt1tUUaP42meths3oEW09+UDnDrvd7JYELM=
Message-ID: <5a2cf1f605020401037aa610b9@mail.gmail.com>
Date: Fri, 4 Feb 2005 10:03:47 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
Reply-To: jerome lacoste <jerome.lacoste@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Huge unreliability - does Linux have something to do with it?
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_6_7094440.1107507827665"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_6_7094440.1107507827665
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[Sorry for the sensational title]

I have had this laptop for three years. It ran Linux (Debian unstable)
from the start and its hardware has been very unreliable: I changed
hard disks twice and the motherboard thrice. My DVD drive started
failing some days ago (this one is 'original', 3 years old). But I
don't mind as I am not under warranty anymore... This morning the
machine booted with fsck errors on my hard disk. I am not sure if I
did the right thing, but I said clear the inodes, and I ended up
loosing some programs(*) (du, dircolors, etc..). The day starts well
isn't it? Sounds like I will have to switch disks again...

I halted the machine correctly yesterday night. I never dropped the
box in 3 years. Am I just being unlucky? Or could the fact that I am
using Linux on the box affect the reliability in some ways on that
particular hardware (Dell Inspiron 8100)? I run Linux on 3 other
computers and never had single problems with them.

How can the file system (ext3) be messed up the way it was this
morning after I stopped the machine correctly yesterday?
Could a hardware failure look like bad sectors to fsck?

Attached the output of smartctl -a /dev/hda, whatever that helps.

Jerome

(*) I accept tips on discovering and maybe recovering which files have
been taken out of my system...

------=_Part_6_7094440.1107507827665
Content-Type: text/x-log; name="smartctl.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="smartctl.log"

smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     HITACHI_DK23FB-60
Serial Number:    1ZX822
Firmware Version: 00M0A0C1
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   5
ATA Standard is:  ATA/ATAPI-5 T13 1321D revision 3
Local Time is:    Fri Feb  4 09:53:50 2005 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x80)=09Offline data collection activity
=09=09=09=09=09was never started.
=09=09=09=09=09Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)=09The previous self-test routine co=
mpleted
=09=09=09=09=09without error or no self-test has ever=20
=09=09=09=09=09been run.
Total time to complete Offline=20
data collection: =09=09 (2150) seconds.
Offline data collection
capabilities: =09=09=09 (0x5b) SMART execute Offline immediate.
=09=09=09=09=09Auto Offline data collection on/off support.
=09=09=09=09=09Suspend Offline collection upon new
=09=09=09=09=09command.
=09=09=09=09=09Offline surface scan supported.
=09=09=09=09=09Self-test supported.
=09=09=09=09=09No Conveyance Self-test supported.
=09=09=09=09=09Selective Self-test supported.
SMART capabilities:            (0x0003)=09Saves SMART data before entering
=09=09=09=09=09power-saving mode.
=09=09=09=09=09Supports SMART auto save timer.
Error logging capability:        (0x01)=09Error logging supported.
=09=09=09=09=09No General Purpose Logging support.
Short self-test routine=20
recommended polling time: =09 (   2) minutes.
Extended self-test routine
recommended polling time: =09 (  37) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  =
WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000d   091   090   050    Pre-fail  Offline  =
    -       412316862542
  2 Throughput_Performance  0x0005   100   092   050    Pre-fail  Offline  =
    -       3140
  3 Spin_Up_Time            0x0007   100   100   050    Pre-fail  Always   =
    -       0
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always   =
    -       388
  5 Reallocated_Sector_Ct   0x0033   095   095   010    Pre-fail  Always   =
    -       142
  7 Seek_Error_Rate         0x000f   100   100   050    Pre-fail  Always   =
    -       651
  8 Seek_Time_Performance   0x0005   100   100   050    Pre-fail  Offline  =
    -       1125
  9 Power_On_Minutes        0x0032   095   095   000    Old_age   Always   =
    -       2512h+02m
 10 Spin_Retry_Count        0x0013   100   100   050    Pre-fail  Always   =
    -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always   =
    -       361
191 G-Sense_Error_Rate      0x000a   100   068   000    Old_age   Always   =
    -       17536255
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always   =
    -       25
193 Load_Cycle_Count        0x0032   092   092   000    Old_age   Always   =
    -       53398/53372
194 Temperature_Celsius     0x0022   072   036   000    Old_age   Always   =
    -       54 (Lifetime Min/Max 72/13)
195 Hardware_ECC_Recovered  0x001a   100   001   000    Old_age   Always   =
    -       4189
196 Reallocated_Event_Count 0x0032   086   086   000    Old_age   Always   =
    -       142
197 Current_Pending_Sector  0x0032   097   094   000    Old_age   Always   =
    -       3
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline  =
    -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always   =
    -       0
200 Multi_Zone_Error_Rate   0x0013   100   100   050    Pre-fail  Always   =
    -       0
201 Soft_Read_Error_Rate    0x0012   100   100   000    Old_age   Always   =
    -       1
223 Load_Retry_Count        0x0012   100   100   000    Old_age   Always   =
    -       0
230 Head_Amplitude          0x0032   096   096   000    Old_age   Always   =
    -       141669
250 Read_Error_Retry_Rate   0x000a   100   001   000    Old_age   Always   =
    -       837

SMART Error Log Version: 1
ATA Error Count: 108 (device log contains only the most recent five errors)
=09CR =3D Command Register [HEX]
=09FR =3D Features Register [HEX]
=09SC =3D Sector Count Register [HEX]
=09SN =3D Sector Number Register [HEX]
=09CL =3D Cylinder Low Register [HEX]
=09CH =3D Cylinder High Register [HEX]
=09DH =3D Device/Head Register [HEX]
=09DC =3D Device Command Register [HEX]
=09ER =3D Error register [HEX]
=09ST =3D Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=3Ddays, hh=3Dhours, mm=3Dminutes,
SS=3Dsec, and sss=3Dmillisec. It "wraps" after 49.710 days.

Error 108 occurred at disk power-on lifetime: 2511 hours (104 days + 15 hou=
rs)
  When the command that caused the error occurred, the device was active or=
 idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 07 60 08 fb e1  Error: UNC 7 sectors at LBA =3D 0x01fb0860 =3D 3322=
8896

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 08 5f 08 fb e1 00      00:02:32.020  READ DMA
  c8 00 08 57 08 fb e1 00      00:02:32.010  READ DMA
  c8 00 08 4f 08 fb e1 00      00:02:32.010  READ DMA
  c8 00 08 47 08 fb e1 00      00:02:31.980  READ DMA
  c8 00 08 3f 08 fb e1 00      00:02:31.880  READ DMA

Error 107 occurred at disk power-on lifetime: 2511 hours (104 days + 15 hou=
rs)
  When the command that caused the error occurred, the device was active or=
 idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 01 3d 08 fb e1  Error: UNC 1 sectors at LBA =3D 0x01fb083d =3D 3322=
8861

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 06 38 08 fb e1 00      00:01:33.860  READ DMA
  c8 00 07 37 08 fb e1 00      00:01:31.960  READ DMA
  c8 00 01 3e 08 fb e1 00      00:01:31.830  READ DMA
  c8 00 02 3d 08 fb e1 00      00:01:30.120  READ DMA
  c8 00 03 3c 08 fb e1 00      00:01:28.350  READ DMA

Error 106 occurred at disk power-on lifetime: 2511 hours (104 days + 15 hou=
rs)
  When the command that caused the error occurred, the device was active or=
 idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 07 37 08 fb e1  Error: UNC 7 sectors at LBA =3D 0x01fb0837 =3D 3322=
8855

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 07 37 08 fb e1 00      00:01:31.960  READ DMA
  c8 00 01 3e 08 fb e1 00      00:01:31.830  READ DMA
  c8 00 02 3d 08 fb e1 00      00:01:30.120  READ DMA
  c8 00 03 3c 08 fb e1 00      00:01:28.350  READ DMA
  c8 00 04 3b 08 fb e1 00      00:01:26.090  READ DMA

Error 105 occurred at disk power-on lifetime: 2511 hours (104 days + 15 hou=
rs)
  When the command that caused the error occurred, the device was active or=
 idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 02 3d 08 fb e1  Error: UNC 2 sectors at LBA =3D 0x01fb083d =3D 3322=
8861

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 02 3d 08 fb e1 00      00:01:30.120  READ DMA
  c8 00 03 3c 08 fb e1 00      00:01:28.350  READ DMA
  c8 00 04 3b 08 fb e1 00      00:01:26.090  READ DMA
  c8 00 05 3a 08 fb e1 00      00:01:24.160  READ DMA
  c8 00 06 39 08 fb e1 00      00:01:21.870  READ DMA

Error 104 occurred at disk power-on lifetime: 2511 hours (104 days + 15 hou=
rs)
  When the command that caused the error occurred, the device was active or=
 idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 02 3d 08 fb e1  Error: UNC 2 sectors at LBA =3D 0x01fb083d =3D 3322=
8861

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 03 3c 08 fb e1 00      00:01:28.350  READ DMA
  c8 00 04 3b 08 fb e1 00      00:01:26.090  READ DMA
  c8 00 05 3a 08 fb e1 00      00:01:24.160  READ DMA
  c8 00 06 39 08 fb e1 00      00:01:21.870  READ DMA
  c8 00 07 38 08 fb e1 00      00:01:19.790  READ DMA

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)=
  LBA_of_first_error
# 1  Short offline       Completed without error       00%      2488       =
  -
# 2  Short offline       Completed without error       00%      2464       =
  -
# 3  Short offline       Completed without error       00%      2441       =
  -
# 4  Extended offline    Completed: read failure       20%      2408       =
  92491576
# 5  Short offline       Completed without error       00%      2407       =
  -
# 6  Short offline       Completed without error       00%      2383       =
  -
# 7  Short offline       Completed without error       00%      2296       =
  -
# 8  Extended offline    Completed: read failure       20%      2273       =
  92491576
# 9  Short offline       Completed without error       00%      2272       =
  -
#10  Short offline       Completed without error       00%      2237       =
  -
#11  Short offline       Completed without error       00%      2221       =
  -
#12  Short offline       Completed without error       00%      2190       =
  -
#13  Short offline       Completed without error       00%      2171       =
  -
#14  Short offline       Completed without error       00%      2137       =
  -
#15  Short offline       Completed without error       00%      2113       =
  -
#16  Short offline       Completed without error       00%      2090       =
  -
#17  Extended offline    Completed: read failure       20%      2067       =
  92491576
#18  Short offline       Completed without error       00%      2066       =
  -
#19  Short offline       Completed without error       00%      2044       =
  -
#20  Short offline       Completed without error       00%      2020       =
  -
#21  Short offline       Completed without error       00%      1996       =
  -

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


------=_Part_6_7094440.1107507827665--
