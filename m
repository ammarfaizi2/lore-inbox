Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWHaIDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWHaIDB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 04:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWHaIDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 04:03:00 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:31431 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751224AbWHaIC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 04:02:58 -0400
Message-ID: <44F6979C.4070309@cn.ibm.com>
Date: Thu, 31 Aug 2006 16:02:36 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
Reply-To: walkinair@cn.ibm.com
Organization: IBM
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
CC: linux-kernel@vger.kernel.org, haveblue@us.ibm.com, xfs@oss.sgi.com
Subject: Re: kernel BUG in __xfs_get_blocks at fs/xfs/linux-2.6/xfs_aops.c:1293!
References: <44F67847.6030307@cn.ibm.com> <20060831074742.GD807830@melbourne.sgi.com>
In-Reply-To: <20060831074742.GD807830@melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner wrote:

>
>Hmmmm. We've mapped a range that has been reserved for a delayed
>allocate extent during a direct I/O. That should not happen as XFS
>flushes delalloc extents before executing a direct read and holds
>the I/O lock which will prevent any new writes from mapping new
>delalloc extents. Something went astray, though. :(
>
>Can you give me some more detail on the machine you're running?
>e.g. How many CPUs, RAM and what type of disk subsystem you are using?
>That will make it easier for us to try to reproduce this problem.
>
>Cheers,
>
>Dave.
>  
>
The test box is an IBM System p5 Linux partition, allocated with
0.8 physical POWER5+ cpu processing unit/ 2 virtual processors and 8GB 
memory.
The disk is exported by AIX Virtual IO Server.

BTW, I have CONFIG_PPC_64K_PAGES enabled.
 

