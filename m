Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVGOWA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVGOWA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 18:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVGOWA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 18:00:57 -0400
Received: from fmr20.intel.com ([134.134.136.19]:31892 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261743AbVGOWAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 18:00:55 -0400
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Dave Jones <davej@redhat.com>, Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Date: Fri, 15 Jul 2005 14:47:46 -0700
User-Agent: KMail/1.5.4
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel> <9a8748490507141845162c0f19@mail.gmail.com> <20050715020912.GB22284@redhat.com>
In-Reply-To: <20050715020912.GB22284@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507151447.46318.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 July 2005 19:09, Dave Jones wrote:
> On Fri, Jul 15, 2005 at 03:45:28AM +0200, Jesper Juhl wrote:
>  > > > The problem is the process, not than the code.
>  > > > * The issues are too much ad-hock code flux without enough
>  > > > disciplined/formal regression testing and review.
>  > >
>  > > It's basically impossible to regression test swsusp except to release
>  > > it. Its success or failure depends on exactly the driver
>  > > combination/platform/BIOS version etc.  e.g. all drivers have to
>  > > cooperate and the particular bugs in your BIOS need to be worked
>  > > around etc. Since that is quite fragile regressions are common.
>  > >
>  > > However in some other cases I agree some more regression testing
>  > > before release would be nice. But that's not how Linux works.  Linux
>  > > does regression testing after release.
>  >
>  > And who says that couldn't change?
>  >
>  > In my oppinion it would be nice if Linus/Andrew had some basic
>  > regression tests they could run on kernels before releasing them.
>
> The problem is that this wouldn't cover the more painful problems
> such as hardware specific problems.
>
> As Fedora kernel maintainer, I frequently get asked why peoples
> sound cards stopped working when they did an update, or why
> their system no longer boots, usually followed by a
> "wasnt this update tested before it was released?"
>
> The bulk of all the regressions I see reported every time
> I put out a kernel update rpm that rebases to a newer
> upstream release are in drivers. Those just aren't going
> to be caught by folks that don't have the hardware.

This problem is the developer making driver changes without have the resources 
to test the changes on a enough of the hardware effected by his change, and 
therefore probubly shouldn't be making changes they cannot realisticaly test.

What would be wrong in expecting the folks making the driver changes have some 
story on how they are validating there changes don't break existing working 
hardware?  I could probly be accomplished in open source with subsystem 
testing volenteers.

>
> The only way to cover as many combinations of hardware
> out there is by releasing test kernels. (Updates-testing
> repository for Fedora users, or -rc kernels in Linus' case).
> If users won't/don't test those 'test' releases, we're
> going to regress when the final release happens, there's
> no two ways about it.

You can't blame the users!  Don't fall into that trap.  Its not productive.

>
> 		Dave

-- 
--mgross
BTW: This may or may not be the opinion of my employer, more likely not.  

