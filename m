Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVIRSyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVIRSyp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 14:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVIRSyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 14:54:45 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:63432 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S932166AbVIRSyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 14:54:44 -0400
Message-ID: <432DB7F2.8090306@bootc.net>
Date: Sun, 18 Sep 2005 19:54:42 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050911)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: libata patches and log spam?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've started using Jeff's libata patches from 
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/, mostly so 
I can check the SMART status of a few drives that seem to be on their 
way out. I've only just noticed that recently, my kernel has been 
spewing out messages like the following every minute or so:

Sep 18 19:34:55 [kernel] [4376428.164000] ata1: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:34:55 [kernel] [4376428.216000] ata1: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:34:55 [kernel] [4376428.216000] ata2: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:34:55 [kernel] [4376428.268000] ata2: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:34:55 [kernel] [4376428.268000] ata3: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:34:55 [kernel] [4376428.319000] ata3: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:34:55 [kernel] [4376428.320000] ata4: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:34:55 [kernel] [4376428.374000] ata4: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:36:00 [kernel] [4376493.196000] ata1: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:36:00 [kernel] [4376493.266000] ata1: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:36:00 [kernel] [4376493.273000] ata2: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:36:00 [kernel] [4376493.324000] ata2: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:36:00 [kernel] [4376493.327000] ata3: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:36:00 [kernel] [4376493.378000] ata3: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:36:00 [kernel] [4376493.388000] ata4: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep 18 19:36:00 [kernel] [4376493.440000] ata4: translated ATA stat/err 
0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00

These messages don't seem to cause any trouble and I don't get any other 
errors. Is this just because of increased verbosity due to the patches? 
Can these messages be safely ignored / nuked?

I'm using 2.6.13-ck5 + 2.6.13-rc7-libata1.patch + 
reiser4-for-2.6.12-3.patch.gz + vesafb-tng-0.9-rc7-r1-2.6.13-rc6.patch. 
ata{1,2} are on a sata_sil controller, ata{3,4} are on sata_via.

It also has to be noted that I get similar errors when I try to 
enable/disable SMART automatic offline tests (and other similar 
settings) on a drive:

[4377001.595000] ata1: PIO error, drv_stat 0x51
[4377001.595000] ata1: translated ATA stat/err 0xb0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
[4377001.595000] ata1: status=0xb0 { Busy }
[4377001.596000] ata1: PIO error, drv_stat 0x51
[4377001.596000] ata1: translated ATA stat/err 0xb0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
[4377001.596000] ata1: status=0xb0 { Busy }
[4377001.596000] ata1: PIO error, drv_stat 0x51
[4377001.596000] ata1: translated ATA stat/err 0xb0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
[4377001.596000] ata1: status=0xb0 { Busy }
[4377001.597000] ata1: PIO error, drv_stat 0x51
[4377001.597000] ata1: translated ATA stat/err 0xb0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
[4377001.597000] ata1: status=0xb0 { Busy }
[4377001.597000] ata1: PIO error, drv_stat 0x51
[4377001.597000] ata1: translated ATA stat/err 0xb0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
[4377001.597000] ata1: status=0xb0 { Busy }

I'm getting similar messages when playing with SMART on another machine 
with vanilla 2.6.13.1 + 2.6.13-rc7-libata1.patch, but not the regular, 
minute-by-minute messages on that machine. This one has two drives on a 
sata_piix controller.

Other than that, no trouble. Thanks for the patches, they're really 
handy! :-)

PS: I'm willing to apply patches to, and reboot at will, the first 
machine, but not the second since it's my production web server.

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/

