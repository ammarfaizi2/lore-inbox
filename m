Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbVH3AvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbVH3AvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 20:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbVH3AvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 20:51:05 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:7802 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751430AbVH3AvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 20:51:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fSImQC2RvxJTdbBcTuB+CFDD/gvOKcQhBph+DWSqUW0K92bTKeWiIM2hr5fnGbmhC2EitJAKhBjrYle3JpbABp5eYXaWlSjl244WBSsXCzo89pWpGvVjojRREaa9HrhK18OIb5H2bzFWtPl/ANTfUPwRRagBKGL/rs2COe3RjBA=  ;
Message-ID: <4313A85E.4000502@yahoo.com.au>
Date: Tue, 30 Aug 2005 10:29:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ray Fucillo <fucillo@intersystems.com>
CC: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Rik van Riel <riel@redhat.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: process creation time increases linearly with shmem
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au> <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com> <430E6FD4.9060102@yahoo.com.au> <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org> <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com> <Pine.LNX.4.58.0508261052330.3317@g5.osdl.org> <Pine.LNX.4.61.0508261917360.8477@goblin.wat.veritas.com> <Pine.LNX.4.63.0508261910080.8057@cuia.boston.redhat.com> <Pine.LNX.4.58.0508261621410.3317@g5.osdl.org> <43108136.1000102@yahoo.com.au> <Pine.LNX.4.61.0508280500450.3323@goblin.wat.veritas.com> <43115E67.1050305@yahoo.com.au> <43139B62.7010502@intersystems.com>
In-Reply-To: <43139B62.7010502@intersystems.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Fucillo wrote:

> Nick Piggin wrote:
>
>> How does the following look? (I changed the comment a bit). Andrew, 
>> please
>> apply if nobody objects.
>
>
> Nick, I applied this latest patch to a 2.6.12 kernel and found that it 
> does resolve the problem.  Prior to the patch on this machine, I was 
> seeing about 23ms spent in fork for ever 100MB of shared memory 
> segment.  After applying the patch, fork is taking about 1ms 
> regardless of the shared memory size.
>

Hi Ray,
That's good news. I think we should probably consider putting the patch in
2.6.14 or if not, then definitely 2.6.15.

Andrew, did you pick up the patch or should I resend to someone?

I think the fork latency alone is enough to justify inclusion... 
however, did
you actually see increased aggregate throughput of your database (or at 
least
not a _decreased_ throughput)?

> Many thanks to everyone for your help on this.
>

Well thank you very much for breaking the kernel and telling us about it! :)

Nick


Send instant messages to your online friends http://au.messenger.yahoo.com 
