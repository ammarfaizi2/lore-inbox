Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVA3TUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVA3TUV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 14:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVA3TUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 14:20:21 -0500
Received: from mail13.bluewin.ch ([195.186.18.62]:17629 "EHLO
	mail13.bluewin.ch") by vger.kernel.org with ESMTP id S261767AbVA3TUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 14:20:13 -0500
Message-ID: <41FD336B.8050007@bluewin.ch>
Date: Sun, 30 Jan 2005 20:20:11 +0100
From: Mario Vanoni <vanonim@bluewin.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.29: strange behaviour system clock
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the same with
2.4.29-rc[123]
2.4.28-lck1
2.4.23-aa3
every time repeatable

UP P4-3400HT, 2GB mem, no swap
IDE NEC DVD-RW ND-3500AG (dev/sr0)

DVD with 48 files (*.tar.bz2), 4.4GB

ntpdate -b swisstime.ethz.ch: offset 0.0...
time dircmp /mnt/cdrom /source
thinks it used 20 minutes, no errors
ntpdate -b ...: offset 1134 sec !!!

SMP dual P3-550, 1GB mem, no swap
SCSI PIONER DVD-ROM DVD-304 (slot-in, /dev/sr0)

same DVD, identical source (copied)

ntpdate -b ...: offset 0.0...
time dircmp /mnt/cdrom /source
thinks it used 12 minutes, no errors
ntpdate -b ...: 0.020522 sec

SMP dual Xeon-2800HT, 2GB mem, no swap
IDE NEC DVD-RW ND-2501A (/dev/sr0)

same deviation, offset tons of seconds
this is the production, time must remain correct

Burning CD/DVD with IDE burners,
there not exist SCSI burners,
similar retards of the system clock.
CD using cdrecord, DVD growisofs.

Doing hwclock --show, time is always correct.

Not in LKML, cc if you need, and ... thanks

Mario

PS We burn DVD only since 2 weeks,
   before only CD and only on the SCSI machine,
   and ... NO PROBLEM.

