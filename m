Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269392AbUJFTg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269392AbUJFTg4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269382AbUJFTg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:36:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46008 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269392AbUJFTeI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:34:08 -0400
Message-ID: <4164489D.6040404@pobox.com>
Date: Wed, 06 Oct 2004 15:33:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org, judith@osdl.org
Subject: Re: new dev model (was Re: Default cache_hot_time value back to 10ms)
References: <200410060042.i960gn631637@unix-os.sc.intel.com> <20041005205511.7746625f.akpm@osdl.org> <416374D5.50200@yahoo.com.au> <20041005215116.3b0bd028.akpm@osdl.org> <41637BD5.7090001@yahoo.com.au> <20041005220954.0602fba8.akpm@osdl.org> <416380D7.9020306@yahoo.com.au> <20041005223307.375597ee.akpm@osdl.org> <41638E61.9000004@pobox.com> <Pine.LNX.4.58.0410060512580.14349@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.58.0410060512580.14349@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> On Wed, 6 Oct 2004, Jeff Garzik wrote:
> 
> 
>>The _reality_ is that there is _no_ point in time where you and Linus
>>allow for stabilization of the main tree prior to relesae. [...]
> 
> 
> i dont think this is fair to Andrew - there's hundreds of patches in his
> tree that are scheduled for 2.6.10 not 2.6.9.
> 
> you are right that -mm is experimental, but the latency of bugfixes is the
> lowest i've ever seen in any Linux tree, which is quite amazing
> considering the hundreds of patches.

I said "stabilization of the main tree" for a reason :)  Like a 
"mini-Andrew", I have over 100 net driver csets waiting for 2.6.10 as well.

The crucial point is establishing a psychology where maintainers only 
submit (and only apply) bug fixes in -rc series.  As long as random 
stuff (like fasync in 2.6.8 release) is getting applied at the last 
minute, we are

* destroying the validity of testing done in -rc prior to release, and
* reducing the value of user testing
* discouraging users from treating -rc as anything but a 'devel' release 
(as opposed to a 'stable' release)



> it is also correct that the pile of patches in the -mm tree mask the QA
> effects of testing done on -mm, so testing -BK separately is just as
> important at this stage.

The simple fact is that -mm doesn't receive _nearly_ the amount of 
testing that a 2.6.x -BK snapshot does, which in turn doesn't receive 
_nearly_ the amount of testing that a 2.6.x-rc release gets.

The increase in the amount of testing, and amount of feedback I get for 
my stuff in -mm/-bk versus -rc/release is a very large margin.  For this 
reason, one cannot hold up testing in -mm as nearly having the value of 
testing in -rc.

But with the diminished signal/noise ratio of current -rc...

	Jeff


