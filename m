Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbRGEPL2>; Thu, 5 Jul 2001 11:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265319AbRGEPLK>; Thu, 5 Jul 2001 11:11:10 -0400
Received: from smtp102.urscorp.com ([64.17.27.233]:4112 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S265326AbRGEPKt>; Thu, 5 Jul 2001 11:10:49 -0400
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Tom spaziani <digiphaze@deming-os.org>, Dan Maas <dmaas@dcine.com>,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: VM Requirement Document - v0.0
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OF56241C86.6CC1E0F8-ON85256A80.004CE12A@urscorp.com>
Date: Thu, 5 Jul 2001 11:09:01 -0400
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 07/05/2001 11:04:51 AM,
	Serialize complete at 07/05/2001 11:04:51 AM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, on a laptop memory and disk bandwith are rarely wasted - they cost
> battery life.

I've been playing around with different scenarios to see the differences 
in performance. A good way to trigger the cache problem is to untar a 
couple of kernel source trees or other large amounts of files, until free 
memory is down to less than 2mb. Then try to fire up a few apps that need 
some memory. The hard drive thrashes around as the VM tries to free up 
enough space, often using swap instead of flushing out the cache. 

These source trees can then be deleted which frees up the memory the cache 
was using and performance returns to where it should be. 

However, if I just fire up enough apps to use up all the memory and then 
go into swap, response is still acceptable. If the app requires loading 
from swap there is just a short lag while the VM does its thing and then 
life is good. 

I don't expect to be able to run more apps than I have memory for without 
a performance hit, but I do expect to be able to run with over 128MB of 
"real" free memory and not suffer from performance degradation (which 
doesn't happen at present)

Mike

