Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261532AbSJYSbI>; Fri, 25 Oct 2002 14:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261535AbSJYSbI>; Fri, 25 Oct 2002 14:31:08 -0400
Received: from 653277hfc248.tampabay.rr.com ([65.32.77.248]:32527 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id <S261532AbSJYSbH>; Fri, 25 Oct 2002 14:31:07 -0400
Message-ID: <3DB98EDE.6020808@davehollis.com>
Date: Fri, 25 Oct 2002 14:35:10 -0400
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: chrisl@vmware.com
CC: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: How to get number of physical CPU in linux from user space?
References: <20021024230229.GA1841@vmware.com> <2897727591.1035509219@[10.10.2.3]> <20021025182023.GA1397@vmware.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chrisl@vmware.com wrote:

>On Fri, Oct 25, 2002 at 01:27:00AM -0700, Martin J. Bligh wrote:
>  
>
>>Define "physical CPU number" ;-) If you want to deteact which
>>    
>>
>
>I mean the number of cpu chip you can count on the mother board.
>
>  
>
>>ones are paired up, I believe that if all but the last bit
>>of the apicid is the same, they're siblings. You might have to
>>dig the apicid out of the bootlog if the cpuinfo stuff doesn't
>>tell you.
>>    
>>
>
>And you are right. Those apicid, after mask out the siblings,
>are put in phys_cpu_id[] array in kernel.
>
>I think about look at bootlog too, but that is not a reliable
>way because bootlog might already been flush out after some
>time.
>
>Cheers
>
>Chris
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
Here is what RedHat does in some of their SRPMS to check if you have 
multiple CPUs on your build machine so they can do some parallel builds 
to speed up the build process (kernel, glibc, etc):

egrep -c "^cpu[0-9]+" /proc/stat || :



