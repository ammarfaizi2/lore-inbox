Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751886AbWJ1HOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbWJ1HOJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 03:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWJ1HOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 03:14:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751886AbWJ1HOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 03:14:08 -0400
Date: Sat, 28 Oct 2006 00:13:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: thockin@hockin.org
Cc: Andi Kleen <ak@suse.de>, Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Lee Revell <rlrevell@joe-job.com>, Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-Id: <20061028001316.928e85e8.akpm@osdl.org>
In-Reply-To: <20061028064924.GA9127@hockin.org>
References: <1161969308.27225.120.camel@mindpipe>
	<1161986902.27225.206.camel@mindpipe>
	<1162007907.26022.13.camel@localhost.localdomain>
	<200610272106.13115.ak@suse.de>
	<20061028063524.GA7669@hockin.org>
	<20061027234615.791b3942.akpm@osdl.org>
	<20061028064924.GA9127@hockin.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 23:49:24 -0700
thockin@hockin.org wrote:

> On Fri, Oct 27, 2006 at 11:46:15PM -0700, Andrew Morton wrote:
> > On Fri, 27 Oct 2006 23:35:24 -0700
> > thockin@hockin.org wrote:
> > 
> > > On Fri, Oct 27, 2006 at 09:06:12PM -0700, Andi Kleen wrote:
> > > > 
> > > > > So far, has I can understand. Seems to me that my computer which have a
> > > > > Pentium D (Dual Core) on VIA chipset, also have unsynchronized TSC and
> > > > > with the patch of hrtimers on
> > > > 
> > > > Intel systems (except for some large highend systems) have synchronized TSCs. 
> > > 
> > > Does Intel guarantee that, or is that just what we happen to see, so far.
> > 
> > Matthias has a Xeon machine on which the TSCs are unsynced, and which are
> > unsyncable - write_tsc() just doesn't do anything.  See thread at
> > http://lkml.org/lkml/2006/7/22/104
> 
> Nothing at all, or just the the low few bits are writeable?

We don't know - the tsc sync code doesn't remeasure the errors after "correcting"
them.
