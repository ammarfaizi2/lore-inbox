Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTFKPXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTFKPXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:23:14 -0400
Received: from lucidpixels.com ([66.45.37.187]:64907 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262257AbTFKPXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:23:11 -0400
Date: Wed, 11 Jun 2003 11:36:54 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: linux-kernel@vger.kernel.org
cc: apiszcz@solarrain.com
Subject: WESTERN DIGITAL 200GB IDE DRIVES GO OFFLINE - HOW TO FIX
Message-ID: <Pine.LNX.4.53.0306111115530.14178@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've searched the archives, google and so on, many questions relating to
why the Western Digital drives go offline exist but with no answers.

PROBLEM: After extended periods of time, the HDD will simply go offline.

EXAMPLE LOG ENTRY:

Jun  2 02:07:26 l2 kernel: hdg: dma_intr: status=0x61 { DriveReady
DeviceFault Error }
Jun  2 02:07:26 l2 kernel: hdg: dma_intr: error=0x04 { DriveStatusError }
Jun  2 02:07:26 l2 kernel: hdg: DMA disabled
Jun  2 02:07:26 l2 kernel: PDC202XX: Secondary channel reset.
Jun  2 02:07:26 l2 kernel: ide3: reset: success
Jun  2 02:07:36 l2 kernel: hdg: irq timeout: status=0xd0 { Busy }
Jun  2 02:07:36 l2 kernel: PDC202XX: Secondary channel reset.
Jun  2 02:07:36 l2 kernel: ide3: reset: success
Jun  2 02:07:51 l2 kernel: hdg: irq timeout: status=0xd0 { Busy }
Jun  2 02:07:51 l2 kernel: end_request: I/O error, dev 22:01 (hdg), sector
234118272
Jun  2 02:07:51 l2 kernel: hdg: status timeout: status=0xd0 { Busy }
Jun  2 02:07:51 l2 kernel: PDC202XX: Secondary channel reset.
Jun  2 02:07:51 l2 kernel: hdg: drive not ready for command
Jun  2 02:07:51 l2 kernel: ide3: reset: success
Jun  2 02:08:01 l2 kernel: hdg: irq timeout: status=0xd0 { Busy }
Jun  2 02:08:01 l2 kernel: PDC202XX: Secondary channel reset.
Jun  2 02:08:06 l2 kernel: ide3: reset: success
Jun  2 02:08:21 l2 kernel: hdg: irq timeout: status=0xd0 { Busy }

Finally, I recently came upon a fix.

The fix states:

http://www.warp2search.net/article.php?sid=12540

Drivers: Western Digital Offers Update For
                      180GB & 200GB Harddrives
                      =>Posted by: Rancho*.
                      =>Thursday, June 05 @ 17:52:50 CEST
                                      Apparently
                                      Western Digital
                                      180GB & 200GB
                                      harddrives tend to
                      drop from an IDE RAID array after
                      several days or weeks of operation. The
                      company is offering a fix for this odd behaviour
                      deeply hidden in their FAQ's. Affected drives
                      are:

                        WD2000BB (WD Caviar 7200 2MB 200 GB)
                        WD2000JB (WD Caviar 7200 Special Edition
                      8MB 200 GB)
                        WD1800BB (WD Caviar 7200 2MB 180 GB)
                        WD1800JB (WD Caviar 7200 Special Edition

                      8MB 180 GB)

                      The problem is a result of a feature that reduces
                      idle acoustic noise in desktop drives. This
                      feature can cause a timeout in a IDE RAID
                      environment. To disable the feature, you can
                      run a simple Western Digital utility to turn off a
                      single bit in the drive.s run-time configuration.
                      Disabling of this feature will NOT impact normal
                      system operations in a RAID environment. No
                      firmware or hardware changes are required.

                        3Ware controller cards:
                      If you are using one or more 3Ware controller
                      cards your IDE RAID configuration, download
                      the IDE RAID Compatibility Upgrade Utility for
                      3Ware 7500-X controllers cards.

                        Non-3Ware controller cards:
                      If you are using a 3Ware controller card ALONG
                      with other controller cards in your RAID
                      configuration or if you are using only one
                      controller card that's not made by 3Ware,
                      download the IDE RAID Compatibility Upgrade
                      Utility for non-3Ware control


Here is the readme:

The instructions below apply to the contents of the .zip file named 'WD_CFG'.

The utility runs within DOS and is used to update WD drives connected
to a host system via the primary IDE controller on the system's motherboard.

Note:  The tool will NOT work on a DOS console that is running under Windows.

To update drives please see the following instructions:

1) Unzip WD_CFG.ZIP onto bootable medium (floppy, CD-RW, network drive, etc.)
2) Boot the system to be updated to the medium where the update files were unzipped to.
3) Run wdnewcfg.exe
4) The utility will proceed to update all the drive connected to the system's primary IDE port.
5) Once the update completes, re-boot the system.
6) Update is complete.

Here is what it looks like from a successful update:

WDNewCfg Version 1.03
Copyright (C) 2003 Western Digital Corp


Updating this drive:
Model:          WDC WD2000JB-00DUA0
Serial:         WD-WMACK1008916
FW Rev:         63.13F63


Drive has been updated.
Model:          WDC WD2000JB-00DUA0
Serial:         WD-WMACK1008916
FW Rev:         63.13F70



