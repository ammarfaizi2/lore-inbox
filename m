Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264619AbSJ3IZK>; Wed, 30 Oct 2002 03:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264621AbSJ3IZK>; Wed, 30 Oct 2002 03:25:10 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:55822 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264619AbSJ3IZJ>; Wed, 30 Oct 2002 03:25:09 -0500
Message-ID: <3DBF98A7.8060906@namesys.com>
Date: Wed, 30 Oct 2002 11:30:31 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Oleg Drokin <green@namesys.com>, Nikita Danilov <Nikita@Namesys.COM>
Subject: We need help benchmarking and debugging reiser4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can some of you help us by doing such things as replicating our 
benchmarks, and helping us debug it as we enter the last stretch before 
Halloween?

Nikita and Oleg will describe the details of what to do to replicate the 
benchmarks, please be sure to use reiser4 readdir order for writes to 
reiser4 (that means don't use tarballs made from ext2 (Remember that 
writes determine subsequent read performance.)), and to use the latest 
hard drives and fast processors with udma 5 turned on.  We are quite 
sensitive to transfer speed since we do a good job of avoiding seeks.  
We are sensitive to readdir order because we sort directory entries 
(which is necessary for having efficient large directory lookups).   In 
reiser4.1 we will ship a repacker, and then it won't matter what order 
you do writes in so long as the repacker gets a chance to run at night.  

-- 
Hans


