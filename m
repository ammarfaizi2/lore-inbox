Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263363AbVCKAc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263363AbVCKAc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 19:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbVCKAcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 19:32:41 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:26006 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263363AbVCKAKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 19:10:43 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Greg KH <greg@kroah.com>
Date: Fri, 11 Mar 2005 11:10:37 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16944.57853.539416.268893@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] -stable, how it's going to work.
In-Reply-To: message from Greg KH on Thursday March 10
References: <20050309072833.GA18878@kroah.com>
	<16944.6867.858907.990990@cse.unsw.edu.au>
	<20050310164312.GC16126@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 10, greg@kroah.com wrote:
> On Thu, Mar 10, 2005 at 09:00:51PM +1100, Neil Brown wrote:
> > On Tuesday March 8, greg@kroah.com wrote:
> > > So here's a first cut at how this 2.6 -stable release process is going
> > > to work that Chris and I have come up with.  Does anyone have any
> > > problems/issues/questions with this?
> > 
> > One rule that I thought would make sense, but that I don't see listed
> > is:
> > 
> >  - must fix a regression
> 
> That, and a zillion other specific wordings that people suggested fall
> under the:
> 	or some "oh, that's not good" issue
> rule.
> 
> I didn't feel like being all lawyer-like and explicitly spelling out all
> of the different kinds of bugs that we would be accepting patches for :)
> 
> So yes, I don't have a problem with patches to fix regressions.

I think you did not get the meaning that I was trying to convey...

I didn't mean "If it fixes a regression, it should be accepted."
I meant "If it does not fix a regression, it should not be accepted."

I have the impression that the 2.6.x.y series were suggested because
of regressions in 2.6.11 over 2.6.10 and we needed a way to respond to
that.   I think it should purely be a response to that.


The issue that made me think through this is the locking bug in nfs
(there is a significant delay in getting a contended lock after the
holder drops it).  It has been suggested at least twice for 2.6.11.y.
While it would be nice to have it fixed, I really don't think it
should be a candidate for 2.6.11.y.  It should go into 2.6.12
(which it will) and that should be released 6-10 weeks post 2.6.11
which, given the bug as been around for a lot longer than that without
being widely noticed, should be soon enough.

I fear that if too many bug fixes go into 2.6.11.y, it might seem to
take the pressure of 2.6.12 coming out in a timely fashion, and I
wouldn't like to see that.

NeilBrown
