Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277599AbRKAB4N>; Wed, 31 Oct 2001 20:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277605AbRKAB4D>; Wed, 31 Oct 2001 20:56:03 -0500
Received: from 216-239-45-7.google.com ([216.239.45.7]:46893 "EHLO
	corp.google.com") by vger.kernel.org with ESMTP id <S277599AbRKABzx>;
	Wed, 31 Oct 2001 20:55:53 -0500
Message-ID: <3BE0AB8D.3040400@google.com>
Date: Wed, 31 Oct 2001 17:55:25 -0800
From: Ben Smith <ben@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Google's mm problem - not reproduced on 2.4.13
In-Reply-To: <Pine.LNX.4.33L.0110312341030.2963-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>*Just in case* it's oom-related I've asked Ben to try it with one less than
>>>the maximum number of memory blocks he can allocate.
>>>
>>I've run this test with my 3.5G machine, 3 blocks instead of 4 blocks,
>>and it has the same behavior (my app gets killed, 0-order allocation
>>failures, and the system stays up.
>>
> 
> If you still have swap free at the point where the process
> gets killed, or if the memory is file-backed, then we are
> positive it's a kernel bug.

This machine is configured without a swap file. The memory is file backed, 

though (read-only mmap, followed by a mlock).

  - Ben

Ben Smith
Google, Inc



