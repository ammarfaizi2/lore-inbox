Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVJ2Emj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVJ2Emj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 00:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVJ2Emj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 00:42:39 -0400
Received: from [67.137.28.189] ([67.137.28.189]:63873 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S1751139AbVJ2Emj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 00:42:39 -0400
Message-ID: <4362E96F.8080209@utah-nac.org>
Date: Fri, 28 Oct 2005 21:15:59 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jmerkey <jmerkey@utah-nac.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Jeff Garzik <jgarzik@pobox.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: kernel performance update - 2.6.14
References: <200510282344.j9SNihg27345@unix-os.sc.intel.com> <4362BA30.2020504@pobox.com> <4362A9A7.2090101@utah-nac.org> <4362E329.8040204@yahoo.com.au> <4362E71A.6030904@utah-nac.org> <4362E7B3.6020509@utah-nac.org>
In-Reply-To: <4362E7B3.6020509@utah-nac.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



And one other item. Setting the build to preemptible kernel seems to 
improve I/O performance relative to 2.6.9, if you don't use it, the 
console has long periods where user processes are getting starved under 
extremely heavy I/O loads.

Jeff


jmerkey wrote:

> jmerkey wrote:
>
>> Nick Piggin wrote:
>>
>>> Jeff V. Merkey wrote:
>>>
>>>>
>>>> Verified. These numbers reflect my measurements as well. I have not 
>>>> moved off 2.6.9 to newer kernels on shipping products due to these 
>>>> issues. There are also serious stability issues as well, though 
>>>> 2.6.14 seems a little better than than previous kernels. Jeff
>>>>
>>>
>>> These issues aren't going to fix themselves. Did you investigate
>>> any of the performance or (more importantly) stability problems?
>>
>>
>>
> Added a little more clarification.
>
> Jeff
>
>> Yes I did. The list wasn't too long. I had problems with RCU messages 
>> and irq warn messages at very high loads and init respawning itself 
>> subjected to loads > 369 MB/S to the disk channels on 2.6.13. 
>> Performance was down on disk I/O [vs.] 2.6.9. I did not investigate 
>> the BIO fixes but something changed there. Theres also some memory 
>> problems with corruption somewhere in the 2.6.14 (during module 
>> unload and shutdown).
>>
>> Jeff
>>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
>

