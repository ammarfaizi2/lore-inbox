Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUEGRQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUEGRQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 13:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbUEGRQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 13:16:27 -0400
Received: from lc2-lfd165.law5.hotmail.com ([64.4.53.187]:3089 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263147AbUEGRQX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 13:16:23 -0400
X-Originating-IP: [67.71.31.26]
X-Originating-Email: [wizhippo@hotmail.com]
Message-ID: <409BC476.5010905@hotmail.com>
Date: Fri, 07 May 2004 13:16:38 -0400
From: wizhippo <wizhippo@hotmail.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kswapd0 hangs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 May 2004 17:16:22.0357 (UTC) FILETIME=[04FAF050:01C43457]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:

When doing a backup kswapd0 always hangs.
Does it both localy  and remotely and via ssh

System:
Linux 2.6.5 vanilla
Dual PIII 1.2GHz, 2GB Ram, RAID SCSI

I can't get SysReq to do a dump, but I do have the ouput of top before 
it hangs.

here is the command i'm using
tar -vc -- /root /etc /home /usr/local /var /usr/portage/packages | 
bzip2 -c | split -b 500m - /mnt/backup/backup-$(date +%Y%m%d).tar.bz2- &

top - 11:47:10 up  2:39,  2 users,  load average: 6.83, 2.96, 1.46
Tasks:  90 total,   4 running,  86 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.5% us,  0.5% sy,  0.0% ni,  0.0% id, 98.8% wa,  0.2% hi,  0.0% si
Mem:   2072512k total,  1399844k used,   672668k free,      200k buffers
Swap:  3919840k total,       28k used,  3919812k free,   296472k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
   13 root      15   0     0    0    0 R  0.1  0.0   0:01.17 kswapd0
 7606 root      17   0  8868 7784 1404 R  0.1  0.4  19:01.98 bzip2
    1 root      15   0  1484  496 1336 S  0.0  0.0   0:07.20 init
    2 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 migration/0
    3 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
    4 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 migration/1
    5 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/1
    6 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 events/0


nothing shows up in my logs.

If you can tell me how to get more info to help let me know.
I wish I had more for you.
