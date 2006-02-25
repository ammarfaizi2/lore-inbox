Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWBYCoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWBYCoS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 21:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWBYCoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 21:44:18 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:24186 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932562AbWBYCoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 21:44:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=RyUWRJlclhzFhS2/lA/F46tWa1fxpznolaobE8OmwGELbBg5i7i0298x3k2vsXbHv0PC2ckWziAbfPvhTwzMzgw+R/rJM8Jnfn2il8bpcJ0QLwm49Yje7iAMMpSEJaew4tsCrBNQdxzXrcQlbPbSYgxZ+LkTav4tA2c0ScLwJCc=  ;
Message-ID: <43FFC47C.2090001@yahoo.com.au>
Date: Sat, 25 Feb 2006 13:44:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Robin Holt <holt@SGI.com>
CC: Andrew Morton <akpm@osdl.org>, John McCutchan <john@johnmccutchan.com>,
       linux-kernel@vger.kernel.org, rml@novell.com, arnd@arndb.de, hch@lst.de,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: udevd is killing file write performance.
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com> <1140626903.13461.5.camel@localhost.localdomain> <20060222175030.GB30556@lnx-holt.americas.sgi.com> <1140648776.1729.5.camel@localhost.localdomain> <20060222151223.5c9061fd.akpm@osdl.org> <1140651662.2985.2.camel@localhost.localdomain> <20060223161425.4388540e.akpm@osdl.org> <20060224054724.GA8593@johnmccutchan.com> <20060223220053.2f7a977e.akpm@osdl.org> <43FEB0BF.6080403@yahoo.com.au> <20060224185632.GB343@lnx-holt.americas.sgi.com>
In-Reply-To: <20060224185632.GB343@lnx-holt.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt wrote:
> On Fri, Feb 24, 2006 at 06:07:43PM +1100, Nick Piggin wrote:
> 
>>Attached is a first implementation of what was my idea then of how
>>to solve it... note it is pretty rough and I never got around to doing
>>much testing of it.
>>
>>Basically: moves work out of inotify event time and to inotify attach
>>/detach time while staying out of the core VFS.
> 
> 
> The customer called and said they had tried with udevd running and this
> patch applied.  They said the problem is gone.
> 

OK, well tell them not to run it in production of course...

I'll spend a bit of time to implement Andrew's suggestion, and
do some testing on it.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
