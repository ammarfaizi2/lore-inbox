Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUA3RWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUA3RWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:22:12 -0500
Received: from mail.shareable.org ([81.29.64.88]:27776 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262902AbUA3RWE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:22:04 -0500
Date: Fri, 30 Jan 2004 17:21:19 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Ulrich Drepper <drepper@redhat.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040130172119.GA6285@mail.shareable.org>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040129132623.GB13225@mail.shareable.org> <40194B6D.6060906@redhat.com> <20040129191500.GA1027@mail.shareable.org> <4019A5D2.7040307@redhat.com> <20040130041708.GA2816@mail.shareable.org> <20040130083310.GH31589@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130083310.GH31589@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> Prelink ATM doesn't take VDSO into account at all and surely it would
> be best if it did not have to.  For example if VDSO is randomized, userspace
> has no control over its placement like it has for shared libraries
> (if DSO base is NULL, kernel randomizes, if non-NULL (usually means
> prelinked), then does not randomize unless the binary is PIE).

Randomisation of vDSO and randomisation of PIE, or non-PIE objects
which don't get mapped where you intended all break prelinking.  In
this regard vDSO is no different to any other library.

I agree that any uses of randomisation tend to break prelinking, and
so it's not reasonable to depend solely on prelinking.

-- Jamie
