Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318172AbSHDS2D>; Sun, 4 Aug 2002 14:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318174AbSHDS2D>; Sun, 4 Aug 2002 14:28:03 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:42246 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S318172AbSHDS2C>; Sun, 4 Aug 2002 14:28:02 -0400
Message-ID: <3D4D72EB.7000809@namesys.com>
Date: Sun, 04 Aug 2002 22:31:07 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Andreas Gruenbacher <agruen@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Caches that shrink automatically
References: <Pine.LNX.4.44L.0208041055160.23404-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Sun, 4 Aug 2002, Andreas Gruenbacher wrote:
>  
>
>>On Sunday 04 August 2002 13:30, Hans Reiser wrote:
>>    
>>
>>>How do you ensure that caches have their (internal) aging hands pushed
>>>at a speed that is proportional to their memory usage, or is your design
>>>susceptible to all the usual complaints the unified memory manager crowd
>>>has about separate caches?
>>>      
>>>
>>That's a policy/optimization issue; it's not even desirable to shrink the
>>caches with priorities proportional to their size---they would all tend to
>>become equally large.
>>    
>>
>
>Nope, the idea is to push all caches according to size, but
>often-used caches should shrink less than caches that are
>hardly ever used.
>
Do you let the subcache decide how to move the aging hand and track it? 
 Have I convinced you of that one yet?  Or is it still page based?

-- 
Hans



