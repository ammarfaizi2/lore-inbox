Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbUKKULf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbUKKULf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 15:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbUKKULf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 15:11:35 -0500
Received: from chello083144090118.chello.pl ([83.144.90.118]:15108 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S262318AbUKKUL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 15:11:29 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: strange multisession DVD behaviour after closing the disc.
Date: Thu, 11 Nov 2004 21:11:25 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411112111.25828.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have written a multisession data DVD with Nero Burning ROM.
Then I have added one more session and I have closed the disc
with NEC ND-3500AG DVD/RW.

INQUIRY:                [_NEC    ][DVD_RW ND-3500AG][2.16]
GET [CURRENT] CONFIGURATION:
 Mounted Media:         1Bh, DVD+R
 Media ID:              AML/001
 Current Write Speed:   6.1x1385=8467KB/s
 Write Speed #0:        6.1x1385=8467KB/s
 Write Speed #1:        5.1x1385=7056KB/s
 Write Speed #2:        4.1x1385=5645KB/s
 Write Speed #3:        3.1x1385=4234KB/s
 Write Speed #4:        2.0x1385=2822KB/s
 Write Speed #5:        1.0x1385=1411KB/s
GET [CURRENT] PERFORMANCE:
 Write Performance:     4.0x1385=5540KB/s@[0 -> 2185872]
 Speed Descriptor#0:    00/2185872 R@5.0x1385=6925KB/s W@4.0x1385=5540KB/s
 Speed Descriptor#1:    00/2185872 R@5.0x1385=6925KB/s W@2.4x1385=3324KB/s
READ DVD STRUCTURE[#0h]:
 Media Book Type:       A1h, DVD+R book [revision 1]
 Legacy lead-out at:    2295104*2KB=4700372992
READ DISC INFORMATION:
 Disc status:           complete
 Number of Sessions:    2
 State of Last Session: complete
 Number of Tracks:      2
READ TRACK INFORMATION[#1]:
 Track State:           partial/complete
 Track Start Address:   0*2KB
 Free Blocks:           0*2KB
 Track Size:            1433568*2KB
READ TRACK INFORMATION[#2]:
 Track State:           partial/complete
 Track Start Address:   1435616*2KB
 Free Blocks:           0*2KB
 Track Size:            750256*2KB
FABRICATED TOC:
 Track#1  :             17@0
 Track#2  :             17@1435616
 Track#AA :             17@2185872
 Multi-session Info:    #2@1435616
READ CAPACITY:          2185872*2048=4476665856

The content of this disc is accessible without any problem under WindowsXP.
Under Linux, when I try to mount the disc I get an error:

[root]-[/media] # mount /dev/hdc dvd/
mount: block device /dev/hdc is write-protected, mounting read-only
mount: wrong fs type, bad option, bad superblock on /dev/hdc,
       or too many mounted file systems

[root]-[/media] # dmesg |tail
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
(...)
Unable to identify CD-ROM format.

I can mount this disc with 'mount -o loop /dev/hdc /media/dvd' 
but I can see only the first session.
Playing with 'mount -osession=...' doesn't work.

dmesg #
(...)
Invalid session number or type of track
Invalid session number

Have you got any idea about this behaviour?
Is it possible to access all sessions on this disc?

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
