Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVGOWUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVGOWUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 18:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVGOWUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 18:20:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55246 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261835AbVGOWUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 18:20:25 -0400
Date: Fri, 15 Jul 2005 18:19:55 -0400
From: Dave Jones <davej@redhat.com>
To: Mark Gross <mgross@linux.intel.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Message-ID: <20050715221954.GA31610@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Mark Gross <mgross@linux.intel.com>,
	Jesper Juhl <jesper.juhl@gmail.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel> <9a8748490507141845162c0f19@mail.gmail.com> <20050715020912.GB22284@redhat.com> <200507151447.46318.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507151447.46318.mgross@linux.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 02:47:46PM -0700, Mark Gross wrote:
 
 > This problem is the developer making driver changes without have the resources 
 > to test the changes on a enough of the hardware effected by his change, and 
 > therefore probubly shouldn't be making changes they cannot realisticaly test.

Such is life. The situation arises quite often where fixing a bug
for one person breaks it for another. The lack of hardware to test on
isn't the fault of the person making the change, nor the person requesting
the change. The problem is that the person it breaks for doesn't test
testing kernels, so the problem is only found out about when its too late.

The agpgart driver for example supports around 50-60 different chipsets.
I don't have a tenth of the hardware that it supports at my disposal,
yet when I get patches fixing some problem for someone, or adding support
for yet another variant, I'm not going to go out and find the variants
I don't have.  By your metric I shouldn't apply that change.

That's not how things work.

 > What would be wrong in expecting the folks making the driver changes have some 
 > story on how they are validating there changes don't break existing working 
 > hardware?

It's impractical given the plethora of hardware combinations out there.

 > I could probly be accomplished in open source with subsystem 
 > testing volenteers.

People tend not to test things marked 'test kernels' or 'rc kernels'.
They prefer to shout loudly when the final release happens, and
blame it on 'the new kernel development model sucking'.

 > > The only way to cover as many combinations of hardware
 > > out there is by releasing test kernels. (Updates-testing
 > > repository for Fedora users, or -rc kernels in Linus' case).
 > > If users won't/don't test those 'test' releases, we're
 > > going to regress when the final release happens, there's
 > > no two ways about it.
 > 
 > You can't blame the users!  Don't fall into that trap.  Its not productive.

You're missing my point. The bits are out there for people to
test with.  We can't help people who won't help themselves,
and they shouldn't be at all surprised to find things breaking
if they choose to not take part in testing.

		Dave

