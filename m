Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266522AbUHMSMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266522AbUHMSMD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 14:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUHMSMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 14:12:02 -0400
Received: from bay17-f22.bay17.hotmail.com ([64.4.43.72]:23308 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266534AbUHMSLg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:11:36 -0400
X-Originating-IP: [207.174.0.253]
X-Originating-Email: [chandrasekhar_n@hotmail.com]
From: "chandrasekhar nagaraj" <chandrasekhar_n@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Preallocation of memory in 2.4 kernels
Date: Fri, 13 Aug 2004 23:41:35 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY17-F222koAUaQMni0003849e@hotmail.com>
X-OriginalArrivalTime: 13 Aug 2004 18:11:35.0451 (UTC) FILETIME=[F83876B0:01C48160]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    We have a block driver which operates under heavy IO load.The driver 
always preallocates the memory for IO so that while IO is going ,it can take 
the required memory from the pool.(for performance reasons,we preallocate 
the memory).
But we do have some small chunks of memory allocation (say close to 4K) when 
the IO is in operation.(to update the stats,we require this memory).But 
under heavy load conditions,the kmalloc fails to get even this small chunk 
of data.
We felt that we could preallocate some 64K of memory pool(before the IO 
starts) and then when this kind of small memory request comes (note that 
this request size is variable) , we would use this memory pool instead of 
using the kmalloc.
Is there any mechanism in 2.4 kernels to achieve this task.?

Regards
Chandrasekhar

_________________________________________________________________
Block annoying pop ups! Empower your search! 
http://server1.msn.co.in/features04/general/MSNToolbar Enrich your internet 
experience!

