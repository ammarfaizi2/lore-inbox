Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289076AbSAOEDc>; Mon, 14 Jan 2002 23:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289106AbSAOEDW>; Mon, 14 Jan 2002 23:03:22 -0500
Received: from ppp219.c5300-2.day-oh.siscom.net ([209.251.10.219]:39044 "EHLO
	leros.siscom.net") by vger.kernel.org with ESMTP id <S289076AbSAOEDJ>;
	Mon, 14 Jan 2002 23:03:09 -0500
Message-Id: <200201150402.XAA08887@leros.siscom.net>
Date: Mon, 14 Jan 2002 23:02:02 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: Significant Slowdown Occuring in 2.2 starting with 19pre2
From: Steve Sheftic <kern0201@siscom.net>
X-Mailer: Ishmail 2.0.0-20010107-i586-pc-linux-gnu <http://ishmail.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I encountered a significant disk-write slowdown in the 2.2 kernel that
I've tracked to 2.2.19pre2. I do backups to a SCSI magneto-optical disk.
My /home backup creates a 700MB+ file (using BRU). When I was using
2.2.14, this took roughly a half hour. When I upgraded to 2.2.20, this
same backup started taking nearly 3 hours. Yes, same 700MB+ file size.
The table below shows the results of many tests with many kernels. For
2.2.14 through 2.2.19, the config is essentially identical (doing "make
oldconfig" and answering "No" to new stuff). The config for 2.2.20 and
2.2.21p2 is slightly different, but doesn't seem to be a factor. As you
can see, something happened in 2.2.19pre2 that led to this slowdown.
During these nearly 3 hour backups, the load number stayed at about 3
(with no user-level activity) and the Select light on the MO drive
glowed constantly. System response was poor during this time.

Minutes required to write MO disk vs. kernel version
(multiple tests)

Kernel    Minutes
------    -------
2.2.14     29  33
2.2.15     31  30
2.2.16     67  78       <--- elapsed time more than doubled
2.2.17     22  23  22   <--- notable improvement
2.2.18     34  40
2.2.19p1   30  44
2.2.19p2  161 165       <--- 4x to 5x longer
2.2.19p5  168           (pre3,4 skipped - wouldn't build for me)
2.2.19    168 168
2.2.20    171
2.2.21p2  166

2.4.17     17  17       <--- Woohoo!! 2.4 is GREAT!!

Hardware
--------
Intel 430TX motherboard
Pentium (MMX)
192 MB memory
Advansys ABP940 SCSI controller (hosts the hard disks and MO drive)
Adaptec 2940 SCSI controller (hosts a scanner only)
(more details if requested)

The great news is that for 2.4.17, this backup is only taking 17
minutes! Now that I'm using 2.4, I'm ecstatic! :) However, I wanted to
provide my timing results regarding 2.2.

I also want to express my gratitude to all of you who contribute to this
marvelous OS that I enjoy so much. Thank you!

Steve Sheftic

