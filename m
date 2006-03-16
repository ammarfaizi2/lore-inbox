Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752405AbWCPQuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752405AbWCPQuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbWCPQuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:50:18 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:39915
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1752405AbWCPQuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:50:17 -0500
Date: Thu, 16 Mar 2006 08:50:12 -0800
From: Greg KH <greg@kroah.com>
To: "Artem B. Bityutskiy" <dedekind@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Bug? Report] kref problem
Message-ID: <20060316165012.GA10174@kroah.com>
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru> <20060316164712.GA10167@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316164712.GA10167@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 08:47:12AM -0800, Greg KH wrote:
> On Thu, Mar 16, 2006 at 02:41:19PM +0300, Artem B. Bityutskiy wrote:
> > Hello Greg,
> > 
> > I've hit on a kref problem Please, glance at the attached test module.
> > 
> > The idea of the test is to create 2 kobjects (a and b), create dir A
> > with kobject A, and dir B with kobject B, so that A is B's parent. E.g.,
> > we'll have /sys/A/B.
> > 
> > I see the following output of the test:
> > 
> > a inited, kref 1
> > b inited, kref 1
> > dir A created, A kref 1, B kref 1
> > dir B created, A kref 1, B kref 1
> > b_release
> > a_release
> > kobj B put, A kref 0, B kref 0
> > kobj A put, A kref -1, B kref 0
> > 
> > 
> > So what I don't like is this "A kref -1". Why when I remove directory B,
> > kobj a is released? For me it looks like a bug.
> 
> Sample code please?

Oops, you did that already, I'll look at it now, still waking up, sorry.

greg k-h
