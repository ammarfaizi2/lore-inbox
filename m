Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUJATTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUJATTB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUJATTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:19:01 -0400
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:60157 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S266196AbUJATS4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:18:56 -0400
Subject: md hangs while rebuilding
From: "Shesha B. " Sreenivasamurthy <shesha@inostor.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Content-Type: text/plain
Organization: 
Message-Id: <1096658210.9342.1525.camel@arcane>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 01 Oct 2004 12:16:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I have 9 disks raid 1. I pulled out 4 disks, and using raidhotadd I
triggered a rebuild on 3 of them. While rebuilding md1, the rebuilding
process is stuck at 0.0%. Below is a snapshot of "/proc/mdstat". 

-----
md1 : active raid1 sdi2[12] sdh2[11] sdg2[10] sde2[4] sdd2[1] sdc2[0]
sdb2[2] sda2[5]
      405504 blocks [9/5] [UUU_UU___]
      [>....................]  recovery =  0.0% (384/405504)
finish=176649.2min speed=0K/sec
-----

The finish="***" time is increasing constantly.

(1) What may be the cause. I have experienced it several times. There is
no heavy IO going-on on any of the partitions. Machine is kind of idle.
(2) Can we somehow stop the rebuilding process and restart it again?
(3) Rebooting will fix it. But I am trying to find a better solution.

Any help is highly appreciated.

Thanking You
Shesha

-- 
  .-----.
 /       \
{  o | o  } 
     |
    \_/
      

