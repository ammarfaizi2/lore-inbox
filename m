Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbSJOSO0>; Tue, 15 Oct 2002 14:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264719AbSJOSOZ>; Tue, 15 Oct 2002 14:14:25 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:50367 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264946AbSJOSNx>;
	Tue, 15 Oct 2002 14:13:53 -0400
Message-ID: <3DAC59ED.2070405@watson.ibm.com>
Date: Tue, 15 Oct 2002 14:09:49 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <3DAB46FD.9010405@watson.ibm.com> <20021015110501.B11395@redhat.com> <3DAC4B0E.EBB3A2AB@kegel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:

>Benjamin LaHaise wrote:
>
>>On Mon, Oct 14, 2002 at 06:36:45PM -0400, Shailabh Nagar wrote:
>>
>>>As of today, there is no scalable alternative to poll/select in the 2.5
>>>kernel even though the topic has been discussed a number of times
>>>before. The case for a scalable poll has been made often so I won't
>>>get into that.
>>>
>>Have you bothered addressing the fact that async poll scales worse than
>>/dev/epoll?  That was the original reason for dropping it.
>>
>
>Doesn't the F_SETSIG/F_SETOWN/SIGIO stuff qualify as a scalable
>alternative?
>It's in 2.5 as far as I know.   It does suffer from using the signal
>queue,
>but it's in production use on servers that handle many thousands of 
>concurrent connections, so it's pretty scalable.
>
>- Dan
>

Dan,

Are there any performance numbers for F_SETSIG/F_SETOWN/SIGIO on 2.5 ? 
Does it scale with the number of active connections too ?

Signal-per-fd seems to be a decent alternative (from the measurements on 
Davide's /dev/epoll page) but Vitaly Luban's patch for that isn't available
for 2.5 so I'm not sure what other issues it might have.

-- Shailabh






