Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422882AbWBIMos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422882AbWBIMos (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 07:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422902AbWBIMos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 07:44:48 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:2659 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1422882AbWBIMor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 07:44:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ogEHBZ5h9SZL7KRM9ODh13b1qymDc/4nGI0YdvBzuFXLZnqDddxsM9lmA0U3aQJR5j76lMn+KSk2MLBdL7LaZzUfbrSUeRPaI7N2vZuQ+G3VHmHZsw5qTmBxW2jS5o6z7YZ+fsug0cnQzhNETfLq5FRoGRFGbbKcRGHJ+G7kMR8=  ;
Message-ID: <43EB393F.1070409@yahoo.com.au>
Date: Thu, 09 Feb 2006 23:44:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: MIke Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [k2.6.16-rc1-mm5] kernel BUG at include/linux/mm.h:302!
References: <1139473463.8028.13.camel@homer>	<43EAFF6D.1040604@yahoo.com.au>	<20060209004712.3998e336.akpm@osdl.org>	<1139478652.7867.9.camel@homer> <20060209021136.410f1128.akpm@osdl.org>
In-Reply-To: <20060209021136.410f1128.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> MIke Galbraith <efault@gmx.de> wrote:
> 
>>On Thu, 2006-02-09 at 00:47 -0800, Andrew Morton wrote:

>>>This was a -mm kernel - how do we know it's not -mm breakage?
>>

It's an educated guess. I suppose it could be -mm breakage.

I sent Andrew a patch which tightens up some debug checking, and
that is likely to be causing your BUGs.

>>It _appears_ to be mm breakage.  I just built/ran rc1 with the same
>>config, and it works fine.
>>
>>RL is calling, so I can't dig right this minute... in a couple hours I
>>hope to be able to start though.
>>
>>Before I get to the 'what comes next' compile marathon, any likely
>>candidates?
> 
> 
> rc2-mm1?
> 
> 
>> (or Nick, do you have the supposed fix handy?)
> 
> 
> Yeah, I'm still scratching my head over the mystery fix.
> 
> 

The mm/swap.c hunk from git 8519fb30e438f8088b71a94a7d5a660a814d3872
is the mystery fix (the mm.h hunk is already in there).

I suppose you'd better verify that -mm works fine with the patch as
well, when you get time.

Thanks,

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
