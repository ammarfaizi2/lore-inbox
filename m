Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTLPT5q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 14:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTLPT5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 14:57:46 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:2313 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S262164AbTLPT5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 14:57:44 -0500
Message-ID: <3FDF63A2.9090205@enterprise.bidmc.harvard.edu>
Date: Tue, 16 Dec 2003 14:57:22 -0500
From: "Kristofer T. Karas" <ktk@ENTERPRISE.BIDMC.HARVARD.EDU>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Linux 2.4.24-pre1: Instant reboot
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, et al,

Just wanted to report an instantaneous reboot problem with 2.4.24-pre1.

I don't even see any printk's to the screen; as soon as LILO is finished 
loading the new kernel, the screen blanks and the BIOS goes through its 
boot sequence again.  Since I seem to be the only one reporting this to 
LKML, I suspect I'll have to back out various patches to try to track 
this down. :-P

I'm using the same .config as in 2.4.23 with new questions left at their 
defaults (e.g. XFS=n, OOM_KILLER=n).  I've had no problems with this 
otherwise rock-stable platform for all varieties of 2.4.x, save for some 
early USB EHCI issues long ago.

At work now, so I don't have a full .config handy, but:
* Slackware 8.1 based; glibc 2.2.5; gcc 2.95.3
* Soltek SL-75DRV2 (UP, Athlon XP 1700, VIA KT266A [VT8366A/VT8233])
* Root = ext3 on IDE partition
* DevFS, DevPTS, IDE-SCSI=cdrom0, USBStorage, USB EHCI, VFAT
* RadeonFB, IPTables, Realtek-8139
Everything else in .config is pretty vanilla (e.g. Linus defaults or 
thereabouts).

Kris

