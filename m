Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265002AbUFTK3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbUFTK3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 06:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265770AbUFTK3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 06:29:25 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:45976 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265002AbUFTK3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 06:29:23 -0400
Message-ID: <40D56700.2030206@yahoo.com.au>
Date: Sun, 20 Jun 2004 20:29:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.6 & 2.6.7 sometime hang after much I/O
References: <Pine.LNX.4.44.0406201123240.26522-100000@korben.citd.de>
In-Reply-To: <Pine.LNX.4.44.0406201123240.26522-100000@korben.citd.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> Hi
> 
> 
> 
> First. Kernels <= 2.6.5 don't have this problem. After 2.6.6 show this
> behaviour sometimes i downgraded to 2.6.5 as i thought that it would be
> fixed in 2.6.7, but 2.6.7 also show this behaviour.
> 
> The I/O i do is split some large files (>2GB) into smaller files <= 2GB.
> Sometimes the process that does this just hangs (currently i have such a
> hangung process), top currently shows up to 90% I/O-Wait.
> 
> SOME of my "konsole"s(xterm) hang then too, but others don't (like this
> where i type this email) starting new "konsole"s sometimes work, sometimes
> not.
> 
> System is:
> Distribution: Debian SID.
> 2xP3-933Mhz, 3GB-RAM, Serverworks HE-SL-Chipset
> "System"-HDD is SCSI connected via Symbios-53c1010 (Dual U160)
> "Data"-HDD(s)(where the split-process does it's work) is connected to a
> Highpoint RocketRAID 1540 (HPT-374 Chipset)
> Filesystem is XFS for the Data-HDD(s) and Reiserfs for the system-HDD.
> 
> If other info is needed i will provide them.
> 

When the process has hung, press Alt + SysRq + T to get a task
trace. Run

	dmesg -s 1000000 > tmp

and send us tmp. You'd better send your .config and dmesg too.

Thanks
