Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268316AbUJFGWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268316AbUJFGWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 02:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268325AbUJFGWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 02:22:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7589 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268316AbUJFGT1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 02:19:27 -0400
Message-ID: <41638E61.9000004@pobox.com>
Date: Wed, 06 Oct 2004 02:19:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, kenneth.w.chen@intel.com,
       mingo@redhat.com, linux-kernel@vger.kernel.org, judith@osdl.org
Subject: new dev model (was Re: Default cache_hot_time value back to 10ms)
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

This is damned frustrating :(  Reality is _far_ divorced from what you 
just described.

Major developers such as David and Al don't have trees that see wide 
testing, their code only sees wide testing once it hits mainline.  See 
this message from David, 
http://marc.theaimsgroup.com/?l=linux-netdev&m=109648930728731&w=2

In particular, I think David's point about -mm being perceived as overly 
experimental is fair.

Recent experience seems to directly counter the assertion that only 
well-tested code is landing in mainline, and it's not hard to pick 
through the -rc changelogs to find non-trivial, non-bugfix modifications 
to existing code.  My own experience with netdev-2.6 bears this out as 
well:  I have several personal examples of bugs sitting in netdev (and 
thus -mm) for quite a while, only being noticed when the code hits mainline.

Linus's assertion that "calling it -rc means developers should calm 
down" (implying we should start concentrating on bug fixing rather than 
more-fun stuff) is equally fanciful.

Why is it so hard to say "only bugfixes"?

The _reality_ is that there is _no_ point in time where you and Linus 
allow for stabilization of the main tree prior to relesae.  The release 
criteria has devolved to a point where we call it done when the stack of 
pancakes gets too high.

Ground control to Major Tom?

	Jeff


