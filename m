Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751728AbWBMK3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWBMK3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbWBMK3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:29:35 -0500
Received: from lucidpixels.com ([66.45.37.187]:947 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751728AbWBMK3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:29:34 -0500
Date: Mon, 13 Feb 2006 05:29:33 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: smartmontools-support@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: WD 400GB SATA Drive In Constant Smart Testing?
Message-ID: <Pine.LNX.4.64.0602130524350.13160@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I write to this disk for a while, I see this in dmesg (only once so 
far):

[31230.223504] ata6: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
0xb/00/00
[31230.223511] ata6: status=0x51 { DriveReady SeekComplete Error }
[31230.223515] ata6: error=0x04 { DriveStatusError }


Is there some sort of smart testing going on constantly?  I only get 
26-27MB/s on this 400GB/SATA/16MB/7200RPM drive.  I use smartmontools to 
do a daily test.  However, even with smart disabled, I get:

# hdparm -t /dev/sde
/dev/sde:
  Timing buffered disk reads:   78 MB in  3.06 seconds =  25.46 MB/sec

Does anyone know if this drive has problems in Linux or something?

[    6.895914]   Vendor: ATA       Model: WDC WD4000KD-00N  Rev: 01.0


It just seems to be that drive that has issues.

Here is a 400GB seagate ata/100:
/dev/hde:
  Timing buffered disk reads:  172 MB in  3.02 seconds =  56.91 MB/sec

Here is a 74GB raptor SATA/150:
/dev/sda:
  Timing buffered disk reads:  204 MB in  3.03 seconds =  67.38 MB/sec

Both drives above are on the same system, so my question is what exactly 
is wrong with the WD drive?  Is it a Linux issue, a drive issue, or?

Does anyone else use this drive, what rates do they get?

What is up with the error in dmesg?


# smartctl -d ata -l selftest /dev/sde
smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF READ SMART DATA SECTION ===
SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining 
LifeTime(hours)  LBA
_of_first_error
# 1  Short offline       Completed without error       00%      1094 
-
# 2  Offline             Completed without error       00%         0 
-
# 3  Offline             Completed without error       00%         0 
-
# 4  Offline             Completed without error       00%         0 
-
# 5  Offline             Completed without error       00%         0 
-
# 6  Offline             Completed without error       00%         0 
-
# 7  Offline             Completed without error       00%         0 
-
# 8  Offline             Completed without error       00%         1 
-
# 9  Short offline       Completed without error       00%       810 
-
#10  Vendor offline      Completed without error       30%     65280 
-
#11  Offline             Self-test routine in progress 150%     65535 
-
#12  Vendor offline      Self-test routine in progress 150%       255 
-
#13  Vendor offline      Completed without error       00%         0 
-
#14  Offline             Completed without error       00%         0 
-
#15  Offline             Completed without error       00%         0 
-
#16  Offline             Completed without error       00%         0 
-
#17  Offline             Completed without error       00%         0 
-
#18  Offline             Completed without error       00%         0 
-
#19  Offline             Completed without error       00%         0 
-
#20  Offline             Completed without error       00%         0 
-
#21  Offline             Completed without error       00%         1 
-


