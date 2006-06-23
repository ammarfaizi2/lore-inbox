Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWFWCce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWFWCce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 22:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWFWCce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 22:32:34 -0400
Received: from marsha.pcisys.net ([216.229.32.146]:50645 "EHLO
	marsha.pcisys.net") by vger.kernel.org with ESMTP id S1750839AbWFWCce
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 22:32:34 -0400
Message-ID: <449B52BF.3070404@pcisys.net>
Date: Thu, 22 Jun 2006 20:32:31 -0600
From: Brian Hall <brihall@pcisys.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060604)
MIME-Version: 1.0
To: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
Subject: problem burning DVDs with 2.6.17-ck1 (mlockall?)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading from 2.6.16-ck11 to 2.6.17-ck1, I find I can no longer
burn DVDs. With growisofs I get:

:-( unable to anonymously mmap 33554432: Resource temporarily unavailable

and dvdrecord gives:

dvdrecord: Cannot allocate memory. WARNING: Cannot do mlockall(2).

This happens as root or as a normal user. I have tried both "echo 0 >
/proc/sys/vm/dirty_ratio" and "echo 9 > /proc/sys/vm/dirty_ratio" with
no change in this behavior.

memtester works fine:

# memtester 512M
memtester version 4.0.5 (64-bit)
Copyright (C) 2005 Charles Cazabon.
Licensed under the GNU General Public License version 2 (only).

pagesize is 4096
pagesizemask is 0xfffffffffffff000
want 512MB (536870912 bytes)
got  512MB (536870912 bytes), trying mlock ...locked.

# uname -a
Linux syrinx 2.6.17-ck1 #1 SMP PREEMPT Sun Jun 18 20:55:33 MDT 2006
x86_64 Dual Core AMD Opteron(tm) Processor 165 GNU/Linux

Maybe it's something else I've done on the system. Running ~amd64 Gentoo
2006.0. Suggestions welcome!

