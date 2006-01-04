Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWADAvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWADAvm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWADAvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:51:42 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:29855 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751509AbWADAvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:51:41 -0500
Date: Tue, 3 Jan 2006 16:51:31 -0800
From: Greg KH <greg@kroah.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [Patch 6/6] Delay accounting: Connector interface
Message-ID: <20060104005131.GA19356@kroah.com>
References: <43BB05D8.6070101@watson.ibm.com> <43BB09D4.2060209@watson.ibm.com> <20060104002112.GA18730@kroah.com> <43BB19FC.9020905@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BB19FC.9020905@watson.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 12:42:36AM +0000, Shailabh Nagar wrote:
> Greg KH wrote:
> > On Tue, Jan 03, 2006 at 11:33:40PM +0000, Shailabh Nagar wrote:
> > 
> >>Changes since 11/14/05:
> >>
> >>- explicit versioning of statistics data returned
> >>- new command type for returning per-tgid stats
> >>- for cpu running time, use tsk->sched_info.cpu_time (collected by schedstats)
> >>
> >>First post 11/14/05
> >>
> >>delayacct-connector.patch
> >>
> >>Creates a connector interface for getting delay and cpu statistics of tasks
> >>during their lifetime and when they exit. The cpu stats are available only if
> >>CONFIG_SCHEDSTATS is enabled.
> > 
> > 
> > Why do you use this when we can send typesafe data through netlink
> > messages now?  
> 
> AFAIK, adding new netlink types was frowned upon which is one of the reasons why
> connectors were proposed (besides making it easier to use the netlink interface) ?

I don't know about the issue of creating new types (have you tried?),
but there is a new netlink message format that pretty should make it
just as easy as the connector stuff to send complex message types.

thanks,

greg k-h
