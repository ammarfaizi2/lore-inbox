Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbWCWI6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbWCWI6H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWCWI6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:58:07 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:23442 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932577AbWCWI6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:58:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xXxK5k3hnrFWyecBbcBHbdyOopHEu3+ihgSVx1E0MvLI/dbA4T0wGuhVUtYXxYTSt7tvbyig09n8zK2MFoL+CdwXABCmdcYjLOFrenBF19JEe/wnVc2EjmxeSIb2uMVSXEHoOGoUT0uwzHZOQ3+glYjaHe9KgqezoAX7f7sVzaI=  ;
Message-ID: <44225BBF.2040604@yahoo.com.au>
Date: Thu, 23 Mar 2006 19:26:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: swap prefetching merge plans
References: <200603230856.24091.volker.armin.hemmann@tu-clausthal.de>
In-Reply-To: <200603230856.24091.volker.armin.hemmann@tu-clausthal.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hemmann, Volker Armin wrote:
> Hi,
> 
> I am just a user, but I would love to see this feature.
> 
> After compiling stuff, I have usually some kb in swap (300kb, 360 kb), and 
> lots of free ram. But even this few kb make my KDE desktop extremly sluggish. 
> It feels, like every byte is fetched individually and always the wrong stuff 
> ends in swap.
> 

I'm almost positive this wouldn't be the cause of your problems (even a
slow disk could read all these blocks in, randomly, in under 2 seconds,
assuming they're spread from one end of the platters to the other).

The problem is simply the more general one of parts your working set
being paged out (in this case, cached files). Which is something swap
prefetch will not help with.

> The only 'workaround' so far is to do a 'swapoff -a&& swapon -a' which not 
> only clears swap, but make my box blazzingly fast again (thank you guys, 
> besides this little swap annoyance you all do a great job). 
> 
> So everything that makes the situation better (swap in of data faster) is 
> highly welcome. The CPU is bored most of the time anyway and as I wrote 
> above, usually lots of ram are free. So why not use the free ram and free CPU 
> cycles?
> 
> The compelling argument is: swap is extremly slow. It is so slow that you can 
> go out, plant a tree, build a house and father a son while I am waiting for 
> some few kb to get fetched from it. Everything that reduces swap access when 
> the data is needed, is IMHO a good thing. Oh, and the harddisk is not slow. 
> Only swap is.
> 

I'd be stumped if swapoff helps you. Maybe you aren't exaggerating about
the speed of your swap.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
