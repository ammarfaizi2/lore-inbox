Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbWISRmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbWISRmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWISRmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:42:15 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:32918 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030392AbWISRmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:42:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=XjCIJ0cPI1M6WfaoWcXDPXWZYpYy9qmqdq52nUNRUUjuCezsvxXhDwM+YhoQ4UNz10USvL4rUZWCuXq+sQwAX4Ax/15eOdczwOK6UfK6zZUKVTDboKVwSZBxtzrBb1IActVCb6UoFeDltI4t+roUQ1USOYJMUof/on0fA3qe+74=  ;
Message-ID: <45102BEE.9000501@yahoo.com.au>
Date: Wed, 20 Sep 2006 03:42:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: w@1wt.eu
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <mtosatti@redhat.com>,
       Mikael Pettersson <mikpe@it.uu.se>, David Miller <davem@davemloft.net>
Subject: Re: Linux 2.4.34-pre3
References: <20060919173253.GA25470@hera.kernel.org>
In-Reply-To: <20060919173253.GA25470@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hello !
> 
> I've been a little bit silent and quite busy too. As announced with -pre2,
> here comes -pre3 with only GCC4 fixes. Other fixes I received are minor
> and can wait for -pre4. I really want people to test -pre3 without adding
> any noise to the test. There should be *no* regression at all with existing
> compilers.
> 
> Gcc 4.1 is known to build x86, x86_64, ppc, sparc64, and sparc. Only sparc
> has received no testing yet, while sparc64 is OK. It is possible that some
> sparc/sparc64 drivers have not been caught because of undetected options
> combinations (Davem CC'd for any possible advice on this mater). Status
> for other archs is unknown but at least must not be affected for existing
> setups.
> 
> You will notice that most of the changes below appear under my name while
> I do not deserve any credit for the changes. It is just because I've cut
> all the fixes to sort them, and committed them myself individually. But
> the real work has been done by Mikael.
> 
> We have worked *very* carefully on this merge, and we hope to get all
> possible feedback. People who encounter build problems on archs listed
> above are free to report them, possibly with the fix. When providing a
> fix, *please* provide the whole error output in the commit message so
> that we can track what has been fixed. People who want to include support
> for other archs will have to provide patches, as (at least for me) we
> are not equipped to build on other archs (except for alpha when my RAM
> arrives).
> 
> I plan to wait up to the end of this month before providing -pre4 if there
> is no feedback. Important fixes will be subject to another -stable release
> anyway, so it's safe to wait for feedback here.

I wonder if 2.4 doesn't need the memory ordering fix to prevent pagecache
corruption in reclaim? (http://www.gatago.com/linux/kernel/14682626.html)

What would need to be done is to test page_count before testing PageDirty,
and putting an smp_rmb between the two.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
