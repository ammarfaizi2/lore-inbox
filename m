Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbUKNS6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbUKNS6f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 13:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUKNS6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 13:58:35 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:62155 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261334AbUKNS6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 13:58:33 -0500
Message-ID: <4197AACF.9090303@colorfullife.com>
Date: Sun, 14 Nov 2004 19:58:23 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andries Brouwer <aebr@win.tue.nl>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] __init in mm/slab.c
References: <E1CTDXF-0006mU-00@bkwatch.colorfullife.com> <419714B8.3030804@colorfullife.com> <20041114111551.GA8680@pclin040.win.tue.nl> <Pine.LNX.4.58.0411141823460.2216@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411141823460.2216@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Sun, 14 Nov 2004, Andries Brouwer wrote:
>  
>
>>So yesterday's series of __init patches is not because there were
>>bugs, but because it is desirable to have the situation where
>>static inspection of the object code shows absence of references
>>to .init stuff. Much better than having to reason that there is
>>a reference but that it will not be used.
>>    
>>
>
>And I agree heartily with this. I love static checking (after all, that's 
>all that sparse does), and if you can make sure that there is one less 
>thing to be worried about, all the better.
>
>Of course, another option to just removing/fixing the __init is to have 
>some way to let the static checker know things are ok, but in this case, 
>especially with fairly small data structures, it seems much easier to just 
>make the checker happy.
>
>  
>
I agree, but a comment would have been nice. Now there are two identical 
structures that are used for the same purpose, one __init, one not __init.

I'd bet that sooner or later someone will ask why.

--
    Manfred
