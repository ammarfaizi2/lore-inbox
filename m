Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268376AbUHLFRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268376AbUHLFRJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 01:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268403AbUHLFRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 01:17:09 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:39127 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268376AbUHLFRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 01:17:06 -0400
Message-ID: <411AFD2C.5060701@comcast.net>
Date: Thu, 12 Aug 2004 01:16:28 -0400
From: Clem Taylor <clemtaylor@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Any news on a higher performance sata_sil SIL_QUIRK_MOD15WRITE workaround?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been really disappointed by the performance of the Silicon Image 
3114 on my new x86_box. I spent a bunch of time looking into the 
problem, thinking it was a software RAID5 or xfs issue causing 4K IOs.
I don't know why I didn't notice the 'applying Seagate errata fix' in 
dmesg until after I did a bunch of performance testing and realized that 
it was a sata_sil issue.

So, I was wondering what I can do about this problem? I am not currently 
getting enough disk performance to justify the amount spent on the 
system or enough to satisfy the application I'm working on. Before I go 
out and purchase a 3ware controller and re-install the machine (ouch), 
is there any chance of a better work around in the near future? I'd be 
more than willing to test out a patch.

Is the problem with really with nblocks % 15 == 1? Or is the problem 
with nblocks % 15 == 0? If it is the later and I'm using xfs with 4K 
blocks, couldn't I just turn off the workaround or will the RAID5 driver 
potentially break up larger requests?

It would seem that the root of the problem is a Seagate issue. Does 
anyone know if Seagate fixed the problem with a firmware update? 
Updating the firmware on Seagate fibre channel drives was pretty 
painless, I'd assume that a method exists for SATA drives as well, or is 
that asking too much?

                 Thanks,
                 Clem

