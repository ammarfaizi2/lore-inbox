Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbTBQBJs>; Sun, 16 Feb 2003 20:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbTBQBJr>; Sun, 16 Feb 2003 20:09:47 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:34766 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261173AbTBQBJr>; Sun, 16 Feb 2003 20:09:47 -0500
Message-ID: <3E503871.8040107@us.ibm.com>
Date: Sun, 16 Feb 2003 17:18:41 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: Performance of ext3 on large systems
References: <66390000.1045442686@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> OK, so I guess we all know that ext3 doesn't scale well. But by 
> accident, I have some numbers on exactly how bad it really is:
> 
> Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
>                                    Elapsed        User      System         CPU
>             2.5.61-mjb0.1-ext3       48.47      564.13      143.16     1458.67
>             2.5.61-mjb0.1-ext2       46.06      563.04      115.36     1472.33
> 
> (look at system time ... eeek!)
> 
> diffprofile (+ is worse with ext3, - better)
> 
> 12702 .text.lock.inode

# grep -c lock_kernel fs/ext3/inode.c
35



-- 
Dave Hansen
haveblue@us.ibm.com

