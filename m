Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263155AbVGOCLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbVGOCLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbVGOCLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:11:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57477 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263156AbVGOCJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:09:23 -0400
Date: Thu, 14 Jul 2005 22:09:12 -0400
From: Dave Jones <davej@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Mark Gross <mgross@linux.intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Message-ID: <20050715020912.GB22284@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesper Juhl <jesper.juhl@gmail.com>, Andi Kleen <ak@suse.de>,
	Mark Gross <mgross@linux.intel.com>, linux-kernel@vger.kernel.org
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel> <p73wtnsx5r1.fsf@bragg.suse.de> <9a8748490507141845162c0f19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490507141845162c0f19@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 03:45:28AM +0200, Jesper Juhl wrote:
 
 > > > The problem is the process, not than the code.
 > > > * The issues are too much ad-hock code flux without enough disciplined/formal
 > > > regression testing and review.
 > > 
 > > It's basically impossible to regression test swsusp except to release it.
 > > Its success or failure depends on exactly the driver combination/platform/BIOS
 > > version etc.  e.g. all drivers have to cooperate and the particular
 > > bugs in your BIOS need to be worked around etc. Since that is quite fragile
 > > regressions are common.
 > > 
 > > However in some other cases I agree some more regression testing
 > > before release would be nice. But that's not how Linux works.  Linux
 > > does regression testing after release.
 > > 
 > And who says that couldn't change?
 > 
 > In my oppinion it would be nice if Linus/Andrew had some basic
 > regression tests they could run on kernels before releasing them.

The problem is that this wouldn't cover the more painful problems
such as hardware specific problems.

As Fedora kernel maintainer, I frequently get asked why peoples
sound cards stopped working when they did an update, or why
their system no longer boots, usually followed by a
"wasnt this update tested before it was released?"

The bulk of all the regressions I see reported every time
I put out a kernel update rpm that rebases to a newer
upstream release are in drivers. Those just aren't going
to be caught by folks that don't have the hardware.

The only way to cover as many combinations of hardware
out there is by releasing test kernels. (Updates-testing
repository for Fedora users, or -rc kernels in Linus' case).
If users won't/don't test those 'test' releases, we're
going to regress when the final release happens, there's
no two ways about it.

		Dave

