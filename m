Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbSKVTaK>; Fri, 22 Nov 2002 14:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbSKVTaK>; Fri, 22 Nov 2002 14:30:10 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:37293 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265230AbSKVTaJ>; Fri, 22 Nov 2002 14:30:09 -0500
Message-ID: <3DDE8652.5070003@us.ibm.com>
Date: Fri, 22 Nov 2002 11:32:34 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.5.48 hangs during boot
References: <3DDD8F4D.8080103@us.ibm.com> <20021122021131.GW23425@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Thu, Nov 21, 2002 at 05:58:37PM -0800, Matthew Dobson wrote:
> 
>>Hello all,
>>	2.5.48 + Bill/Martin's noearlyirq patch hangs on boot on our NUMA-Q 
>>machines.  It boots normally up to
>>TCP: Hash tables configured (established 524288 bind 65536)
>>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>>VFS: Mounted root (ext2 filesystem) readonly.
>>Freeing unused kernel memory: 268k freed
>>Then it *VERY* slowly proceeds to output a few more lines before hanging 
>>completely.  The lines come out one at a time, with large time delays 
>>between each line.  The last bit of output I get is the enabling swap line.
>>The -mm1 patch fixes this problem, and I'm in the process of determining 
>>exactly what fixes it.  Any input/ideas would be greatly appreciated.
>>Thanks!
>>-Matt
> 
> 
> get the axboe/akpm fixes for the elevator deadlock and/or an intermediate
> bk tree. This is an io scheduling issue.
> 
> 
> Bill

Yep..  the axboe-scsi patch from the mm1 tree fixes our problem...

Linus, you'll make a bunch of NUMA-Q developers (and likely many other 
people) really happy if you add that patch to the mainline.

Cheers!

-Matt

