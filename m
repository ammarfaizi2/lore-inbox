Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUGQUAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUGQUAX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 16:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUGQUAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 16:00:23 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:55240 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261234AbUGQUAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 16:00:19 -0400
Message-ID: <40F9854D.2000408@comcast.net>
Date: Sat, 17 Jul 2004 16:00:13 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040708)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: audio cd writing causes massive swap and crash
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both with 2.6.7-rc3 and 2.6.8-rc1-mm1 I get the same behavior when 
writing an audio cd on my plextor px-712a.  DMA is enabled and normal 
data cds write as expected, but audio cds will cause (at any speed) the 
box to start using insane amounts of swap (>150MB) and eventually cause 
the box to crash before finishing the cd.  CPU usage during the write is 
very low, but the feeling of lagginess begins after the first few tracks 
(and as the memory begins to be sucked away).   I've used both cdrecord 
from cdrtools in debian and from the site and both have the same 
behavior.  I dont know how i'd go about finding out what the problem is, 
so far I've coastered over 10 cds trying different ways of burning an 
audio cd but it appears that burnfree, speed have nothing to do with the 
problem. 

Here's some drive info if it helps. 

Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'PLEXTOR '
Identifikation : 'DVDR   PX-712A  '
Revision       : '1.01'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
cdrecord: This version of cdrecord does not include DVD-R/DVD-RW support 
code.
cdrecord: See /usr/share/doc/cdrecord/README.DVD.Debian for details on 
DVD support.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE VARIREC FORCESPEED SPEEDREAD 
SINGLESESSION HIDECDR
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R


now in cdrecord i use the option -swab not sure if that counters the 
driver flags or what, either way I doubt it would be causing this problem. 

the drive by the way is mmc4 compliant, so it's weird that it says mmc2.
any more info that's needed just tell me.

