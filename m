Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbSJYIXG>; Fri, 25 Oct 2002 04:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261307AbSJYIXG>; Fri, 25 Oct 2002 04:23:06 -0400
Received: from franka.aracnet.com ([216.99.193.44]:29619 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261306AbSJYIXF>; Fri, 25 Oct 2002 04:23:05 -0400
Date: Fri, 25 Oct 2002 01:27:00 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: chrisl@vmware.com, linux-kernel@vger.kernel.org
Subject: Re: How to get number of physical CPU in linux from user space?
Message-ID: <2897727591.1035509219@[10.10.2.3]>
In-Reply-To: <20021024230229.GA1841@vmware.com>
References: <20021024230229.GA1841@vmware.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define "physical CPU number" ;-) If you want to deteact which
ones are paired up, I believe that if all but the last bit
of the apicid is the same, they're siblings. You might have to
dig the apicid out of the bootlog if the cpuinfo stuff doesn't
tell you.

M.

--On Thursday, October 24, 2002 4:02 PM -0700 chrisl@vmware.com wrote:

> It seems that /proc/cpuinfo will return the number of logical CPU.
> If the machine has Intel Hyper-Thread enabled, that number is bigger
> than physical CPU number. Usually twice as big.
> 
> My question is, what is the reliable way for user space program
> to detect the number of physical CPU in the current machine?
> 
> If in it is in the kernel, I can read from cpu_sibling_map[]
> or phys_cpu_id[]. But it seems not easy read that from
> user space.
> 
> Of course I can do "gdb /proc/kcore" to get them. But is there
> any better way?
> 
> Thanks in advance.
> 
> Chris
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


