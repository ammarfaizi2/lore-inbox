Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265131AbUFARBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265131AbUFARBz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 13:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUFARBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 13:01:31 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:57311 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265099AbUFARBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 13:01:25 -0400
Message-ID: <40BCB6BC.8020901@namesys.com>
Date: Tue, 01 Jun 2004 10:02:52 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Vladimir Saveliev <vs@namesys.com>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Andrew Morton <akpm@osdl.org>, Alexander Zarochentcev <zam@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>, Jeff Mahoney <jeffm@suse.com>
Subject: Re: I would like to see ReiserFS V3 enter a feature freeze real	soon.
References: <20040528122854.GA23491@clipper.ens.fr>	 <1085748363.22636.3102.camel@watt.suse.com>	 <1085750828.1914.385.camel@tribesman.namesys.com>	 <1085751695.22636.3163.camel@watt.suse.com>  <40BB61C0.5020902@namesys.com> <1086089827.22636.3391.camel@watt.suse.com>
In-Reply-To: <1086089827.22636.3391.camel@watt.suse.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>On Mon, 2004-05-31 at 12:48, Hans Reiser wrote:
>  
>
>>While I like and appreciate the data journaling stuff, and I think it 
>>should go in, real soon now I think we should avoid adding new features 
>>to V3.  Let the mission critical server folks have a reiserfs version 
>>that only gets bug fixes added to it, and let V4 be for those who want 
>>excitement.
>>
>>Are there any things which Chris and Jeff think should go in besides 
>>data journaling/ordering and bitmap algorithm changes?
>>
>>    
>>
>
>We've got io error fault tolerance that needs to go in after the barrier
>code has stabilized. 
>
Ok, this qualifies as bug fixing or close enough.;-)

> I can't promise that I'll never making another
>change in there, but my goal is to keep them to a minimum.
>
>  
>
>>Also, I would like to see some serious benchmarks of the bitmap 
>>algorithm changes before they go in.  They seem nice in theory, and some 
>>users liked them for their uses, but that does not make a serious 
>>scientific study.  Such a study has a high chance of making them even 
>>better.;-)
>>
>>    
>>
>
>Some benchmarks have been posted on reiserfs-list, but I'd love to
>coordinate with you on getting some mongo numbers. 
>
Ok.

> I can spout off a
>long list of places where the code does better then the original v3
>allocator, but that's because those were the ones I was trying to fix
>;-)
>
>  
>
>>zam, I view you as the block allocator maintainer, please review that 
>>bitmap code from Chris.
>>
>>Chris and Jeff, can you propose a benchmarking plan for the bitmap code?
>>    
>>
>
>A good start would be to just rebenchmark against v4.
>  
>
V4 performance is not at a stable point at the moment I think, I have 
not been monitoring things closely due to trying to earn bucks 
consulting, and performance did not get tested every week, but there 
have been reports of performance decreasing and no reports of anyone 
investigating it, so I need to....

Elena, please compose a URL consisting of past benchmarks of various V4 
snapshots and send it to me.  (I did not read the last one you sent, 
sorry about that, so include the contents of that one also).

If the objective is to determine if the algorithm is good, then we 
should test it with only the algorithm in question changed.

I would be quite happy to add the algorithm to V4 (or Chris and Jeff can 
do that) and test it on vs. off.

Zam, place that on your todo list and send the todo list to me....

>-chris
>
>
>
>
>  
>

