Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbVLOFFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbVLOFFy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVLOFFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:05:54 -0500
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:18552 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965042AbVLOFFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:05:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ReUuIlHwBvVUrDgUD5Hphx23qPR1Ma8T+n+JfImyf9x7jhrtFDq9ozMiiG3F0oGU94O5+V65jYCJP0sbLbUZEf7ptk8KJKg9iDANuVmsrUgovvyHjLW7FwhZ6RN7oPZ7k2T3hZyb1uqiju0A1QpsTosNWfrawfZO56NmhBS9cQ4=  ;
Message-ID: <43A0F9A8.1010109@yahoo.com.au>
Date: Thu, 15 Dec 2005 16:05:44 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: Christoph Hellwig <hch@infradead.org>, Jakub Jelinek <jakub@redhat.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
       dhowells@redhat.com, torvalds@osdl.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <dhowells1134431145@warthog.cambridge.redhat.com>	<20051212161944.3185a3f9.akpm@osdl.org>	<20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de>	<20051213004257.0f87d814.akpm@osdl.org>	<20051213084926.GN23384@wotan.suse.de>	<20051213090429.GC27857@infradead.org>	<20051213101141.GI31785@devserv.devel.redhat.com>	<20051213101938.GA30118@infradead.org> <buod5jz6jwo.fsf@dhapc248.dev.necel.com>
In-Reply-To: <buod5jz6jwo.fsf@dhapc248.dev.necel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
>>But serious, having to look all over the source instead of just a block
>>beginning decreases code readability a lot.
> 
> 
> My experience is quite the opposite.
> 
> Being forced to put declarations at the beginning of the block in
> practice means that people simply separate declarations from the first
> assignment.  That uglifies and bloats the code, and seems to often cause
> bugs as well (because people seem to often not pay attention to what
> happens to a variable between the declaration and first assignment;
> having it simply _not exist_ before the first assignment helps quite a
> bit).
> 

If your blocks are so big that you lose track of variables like
this... then it is too big and/or complex.

And the argument about having it simply _not exist_ before the
first assignment isn't convincing to me, because you cannot
undeclare variables after you finish with them (do you also see
code where people cause bugs by forgetting about the variable after
its last use?).

IMO, the system of declaring all variables at the top of the block
and they all disappear at the end is nice and symmetric... although
I probably agree with Linus on the 'for (int i = 0;' feature.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
