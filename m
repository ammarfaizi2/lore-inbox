Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWEIXGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWEIXGx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWEIXGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:06:52 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:27521 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S932071AbWEIXGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:06:52 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: [RFC PATCH 25/35] Add Xen time abstractions
Date: Wed, 10 May 2006 01:03:53 +0200
User-Agent: KMail/1.9.1
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085157.908244000@sous-sol.org> <200605092350.03886.ak@suse.de>
In-Reply-To: <200605092350.03886.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605100103.54875.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Tuesday, 9. May 2006 23:50, Andi Kleen wrote:
> On Tuesday 09 May 2006 09:00, Chris Wright wrote:
> > Add support for Xen time abstractions. To avoid expensive traps into
> > the hypervisor, the passage of time is extrapolated from the local TSC
> > and a set of timestamps and scaling factors exported to the guest via
> > shared memory. Xen also provides a periodic interrupt facility which
> > is used to drive updates of xtime and jiffies, and perform the usual
> > process accounting and profiling.
> 
> There is far too much code duplication in there. I think you need to
> refactor the main time.c a bit first and strip that down.
> 
> Also you can drop all the __x86_64__ support for now.

Isn't time and timer handling a moving target anyway?
The refactoring will be done by the timer people in a completly different
manner anyway.

Are you sure, you want to disturb these efforts by requiring another
refactoring here?


Regards

Ingo Oeser
