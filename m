Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUESQ7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUESQ7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 12:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbUESQ7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 12:59:14 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:32218 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S261181AbUESQ7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 12:59:08 -0400
Message-ID: <40AB925C.50001@am.sony.com>
Date: Wed, 19 May 2004 09:59:08 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Christoph Hellwig <hch@infradead.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: CE Linux Forum - Specification V1.0 draft
References: <40A90D00.7000005@am.sony.com> <20040517201910.A1932@infradead.org> <40A92D15.2060006@am.sony.com> <20040519152706.GD22742@fs.tum.de>
In-Reply-To: <20040519152706.GD22742@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Mon, May 17, 2004 at 02:22:29PM -0700, Tim Bird wrote:
>>Christoph Hellwig wrote:
>>>If you want my 2Cent:
>>>
>>>- stop these rather useless specifications and provide patchkits instead
>>>- try to actually submit the patches upstream to get a feeling which
>>>  of your 'features' are compltely hopeless, which are okay and which
>>>  can better be solved in different ways.
>>
>>I should point out that some of the features specified have already been
>>submitted as patchsets. 
 >
> A good example that this is true is section 7.9.2 of your 
> "specification".
> 
> It lists under "Work in Progress":
>   Kernel SHALL be configuralble with compiler size options, such as -Os.
> 
> Besides the text in the "Rationale" being obviously wrong, this is 
> already implemented in kernel 2.6. But the people writing this
> "specification" didn't send a patch - the trivial patch was sent by 
> someone who is in no way related to your "Forum".

First, I'll point out that this spec, as you noted, is still
a work in progress.

Yes, the rationale is wrong.  Thanks for pointing that out.
I'll get it fixed before we release a spec on this.  We have
a separate agenda item in our size working group to look at
inline expansions (See section 7.9.3 where it lists candidate
projects that are not started yet.) There is already valuable
work going on in the area of inline reduction, but
unfortunately, we don't have anything to contribute to that
discussion yet.

As for the patch, you are correct that the kernel makefile system
supports compilation with -Os, and someone besides us submitted
the patch for that.  However, there is more work needed to
validate that the option doesn't break things, on many different
architectures.

I have reports from the uClinux crowd that use of
the -Os option is fairly typical for users of uClinux, and they
have no reports of breakage.  However, we want to take a methodical
approach to validating that use of this option is fully supported
by the Linux kernel.  Also, we want to test and report the size
and performance effects of the use of the flag.  This work is
not done yet, so the spec. is still under construction.

Just jamming in the compiler option is not really what we intend here.
I'll try to make sure this spec., when released, is worded to
express our requirement that the option be meaningful and safe,
rather than just supported by the build system.

If you see patches from us (or one of our members) related to this spec.,
they will be to fix issues where use of -Os breaks something in the kernel.

Thanks for the feedback.  We'll keep working on this one.

P.S. Why is "Forum" in quotes?

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

