Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUFVSjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUFVSjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUFVSjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:39:13 -0400
Received: from ool-44c1e325.dyn.optonline.net ([68.193.227.37]:54915 "HELO
	dyn.galis.org") by vger.kernel.org with SMTP id S265141AbUFVSel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 14:34:41 -0400
Mail-Followup-To: linux-kernel@vger.kernel.org
MBOX-Line: From george@galis.org  Tue Jun 22 14:34:37 2004
Date: Tue, 22 Jun 2004 14:34:36 -0400
From: George Georgalis <george@galis.org>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: SATA 3112 errors on 2.6.7
Message-ID: <20040622183436.GB17738@trot.local>
References: <Pine.GSO.4.33.0406181831180.25702-100000@sweetums.bluetronic.net> <200406192210.05455.rjwysocki@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406192210.05455.rjwysocki@sisk.pl>
X-Time: trot.local; @815; Tue, 22 Jun 2004 14:34:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 10:10:05PM +0200, R. J. Wysocki wrote:
>Apparently, we have:
>1) A serious error condition that occurs on Seagate SATA drives connected to 
>Silicon Image controllers.
>2) As of today we can say that it only occurs on Seagate drives (Ricky, do I 
>remember correctly that you see faulty behavior of such drives with a 3ware 
>RAID?).
>3) The error is reported by the kernel like that:
>
>ata1: DMA timeout, stat 0x1
>ATA: abnormal status 0x58 on port 0xCF819087
>scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 03 ca 47 00 00 00 
>00
>Current sda: sense key Medium Error
>Additional sense: Unrecovered read error - auto reallocate failed
>end_request: I/O error, dev sda, sector 248391
>
>Afterwards, the drive blocks its SATA bus in a "busy" mode and cannot be 
>accessed by any means (ie. hardware reset is necessary).
>4) The most "reliable" way to trigger this condition is to copy a lot of data 
>(eg. 2 GB) to the drive in one shot.

I can't speak for other hardware. Sounds the same for me though,
accept I'm not getting any error from console or /proc/kmsg...
http://marc.theaimsgroup.com/?l=linux-kernel&m=108792673031602&w=2

running hdparm -Tt in a loop doesn't cause any problem.

// George

-- 
George Georgalis, Architect and administrator, Linux services. IXOYE
http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631

