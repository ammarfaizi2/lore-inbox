Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWFBESz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWFBESz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 00:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWFBESy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 00:18:54 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:30890 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751105AbWFBESx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 00:18:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=i1xCQEwaLGRz2gYZ+eVDhS0+LHPc6Cwlr0ymF0ZjN/ZdL2wvMfRq+gaYrCZV6yR3KyzO8POTHfxew2C0fKzN/ZtAe5gtZWx1uTtIcRWIAjwn6Aw8NkGSrw5OFiUZdUjcuzSVI22Nu5cuiIOozftqpiQ4+qiRd6rx0g1vd2hMx8c=  ;
Message-ID: <447FBC28.8030401@yahoo.com.au>
Date: Fri, 02 Jun 2006 14:18:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Chris Mason'" <mason@suse.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
References: <000101c685d7$1bc84390$d234030a@amr.corp.intel.com> <200606021159.06519.kernel@kolivas.org> <200606021228.37910.kernel@kolivas.org> <200606021355.23671.kernel@kolivas.org>
In-Reply-To: <200606021355.23671.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Friday 02 June 2006 12:28, Con Kolivas wrote:
> 
>>Actually looking even further, we only introduced the extra lookup of the
>>next task when we started unlocking the runqueue in schedule(). Since we
>>can get by without locking this_rq in schedule with this approach we can
>>simplify dependent_sleeper even further by doing the dependent sleeper
>>check after we have discovered what next is in schedule and avoid looking
>>it up twice. I'll hack something up to do that soon.
> 
> 
> Something like this (sorry I couldn't help but keep hacking on it).

Looking pretty good. Nice to acknowledge Chris's idea for
trylocks in your changelog when you submit a final patch.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
