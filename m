Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTDPRH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbTDPRH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:07:26 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:38149 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264454AbTDPRHZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:07:25 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x Problem with cd writing
Date: Wed, 16 Apr 2003 19:19:08 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200304161919.08615.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've problems with CD-writing since about a half year on various
2.4 kernels (2.4.18 (maybe, I don't remember exactly), 2.4.19, 2.4.2x)

While my writer writes TOC or fixes CD (doesn't write real data-stream),
the whole ide-disk interface of the system is frozen. Kernel ist still
working and all programs run correctly, until they need harddisk
access. No harddisk or CD-ROM access is possible.
After the writer finishes TOC or fixating, the ide-disk interface
defrosts.

mb@lfs:~> cdrecord -scanbus
Cdrecord 1.11a40 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
Linux sg driver version: 3.1.24
Using libscg version 'schily-0.7'
scsibus0:
        0,0,0     0) 'LG      ' 'DVD-ROM DRD8160B' '1.01' Removable CD-ROM
        0,1,0     1) 'TEAC    ' 'CD-W54E         ' '1.0Y' Removable CD-ROM   << (my writer)
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *

(I've tried various versions of cdrecord and it occurs in cdrdao, too)

root@lfs:/proc> hdparm /dev/hdd

/dev/hdd:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 BLKRAGET failed: Invalid argument
 HDIO_GETGEO failed: Invalid argument

root@lfs:/proc> cat /proc/version 
Linux version 2.4.21-pre6 (root@lfs) (gcc version 3.2.2) #3 Sam Apr 5 20:23:37 CEST 2003


-- 
Regards Michael Buesch.
http://www.8ung.at/tuxsoft

$ cat /dev/zero > /dev/null
/dev/null: That's *not* funny! :(

