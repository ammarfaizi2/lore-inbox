Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267511AbUJFFrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUJFFrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 01:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267278AbUJFFrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 01:47:09 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:64096 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267511AbUJFFqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 01:46:51 -0400
Message-ID: <416386C1.5020200@yahoo.com.au>
Date: Wed, 06 Oct 2004 15:46:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kenneth.w.chen@intel.com, mingo@redhat.com, linux-kernel@vger.kernel.org,
       judith@osdl.org
Subject: Re: Default cache_hot_time value back to 10ms
References: <200410060042.i960gn631637@unix-os.sc.intel.com>	<20041005205511.7746625f.akpm@osdl.org>	<416374D5.50200@yahoo.com.au>	<20041005215116.3b0bd028.akpm@osdl.org>	<41637BD5.7090001@yahoo.com.au>	<20041005220954.0602fba8.akpm@osdl.org>	<416380D7.9020306@yahoo.com.au> <20041005223307.375597ee.akpm@osdl.org>
In-Reply-To: <20041005223307.375597ee.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Any thoughts about making -rc's into -pre's, and doing real -rc's?
> 
> 
> I think what we have is OK.  The idea is that once 2.6.9 is released we
> merge up all the well-tested code which is sitting in various trees and has
> been under test for a few weeks.  As soon as all that well-tested code is
> merged, we go into -rc.  So we're pipelining the development of 2.6.10 code
> with the stabilisation of 2.6.9.
> 
> If someone goes and develops *new* code after the release of, say, 2.6.9
> then tough tittie, it's too late for 2.6.9: we don't want new code - we
> want old-n-tested code.  So your typed-in-after-2.6.9 code goes into
> 2.6.11.
> 
> That's the theory anyway.  If it means that it takes a long time to get
> code into the kernel.org tree, well, that's a cost.  That latency may be
> high but the bandwidth is pretty good.
> 
> There are exceptions of course.  Completely new
> drivers/filesystems/architectures can go in any old time becasue they won't
> break existing setups.  Although I do tend to hold back on even these in
> the (probably overoptimistic) hope that people will then concentrate on
> mainline bug fixing and testing.
> 
> 
>> It would have caught the NFS bug that made 2.6.8.1, and probably
>> the cd burning problems... Or is Linus' patching finger just too
>> itchy?
> 
> 
> uh, let's say that incident was "proof by counter example".
> 

Heh :)

OK I agree on all these points. And yeah it has worked quite well...

But by real -rc, I mean 2.6.9 is a week after 2.6.9-rcx minus the
extraversion string; nothing more.

The main point (for me, at least) is that if -rc1 comes out, and I'm
still working on some bug or having something else tested then I can
hurry up and/or send you and Linus a polite email saying don't release
yet.

Would probably be a help for people running automated testing and
regression tests, etc. And just generally increase the userbase a
little bit.

Catching the odd paper bag bug would be a fringe benefit.
