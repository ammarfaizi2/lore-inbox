Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264408AbRFHXzj>; Fri, 8 Jun 2001 19:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264409AbRFHXz3>; Fri, 8 Jun 2001 19:55:29 -0400
Received: from [32.97.182.103] ([32.97.182.103]:14567 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264408AbRFHXzS>;
	Fri, 8 Jun 2001 19:55:18 -0400
Importance: Normal
Subject: Re: Please test: workaround to help swapoff behaviour
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Derek Glidden <dglidden@illusionary.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF215A9F3A.3CFF9D00-ON85256A65.007FE32C@watson.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Fri, 8 Jun 2001 19:53:35 -0400
X-MIMETrack: Serialize by Router on D01MLWT1/01/M/IBM(Build M9_05202001 Beta 2|May 20, 2001) at
 06/08/2001 07:52:42 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I looked at try_to_unuse in swapfile.c.  I believe that the algorithm is
>> broken.
>> For each and every swap entry it is walking the entire process list
>> (for_each_task(p)).  It is also grabbing a whole bunch of locks
>> for each swap entry.  It might be worthwhile processing swap entries in
>> batches instead of one entry at a time.
>>
>> In any case, I think having this patch is worthwhile as a quick and
dirty
>> remedy.
>
>Bulent,
>
>Could you please check if 2.4.6-pre2+the schedule patch has better
>swapoff behaviour for you?

No problem.  I will check it tomorrow. I don't think it can be any worse
than it is now.  The patch looks correct in principle.
I believe it should go in to 2.4.6.  But I will test it.

On small machines people don't notice it, but otherwise if you have few
GB of memory it really hurts.  Shutdowns take forever since swapoff takes
forever.




