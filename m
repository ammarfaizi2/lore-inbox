Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbWHOSYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWHOSYJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbWHOSYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:24:08 -0400
Received: from 1wt.eu ([62.212.114.60]:19215 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1030424AbWHOSYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:24:06 -0400
Date: Tue, 15 Aug 2006 20:19:39 +0200
From: Willy Tarreau <w@1wt.eu>
To: alex@yuriev.com
Cc: Mark Reidenbach <m.reidenbach@everytruckjob.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How to find a sick router with 2.6.17+ and tcp_window_scaling enabled
Message-ID: <20060815181938.GK8776@1wt.eu>
References: <44E1F0CD.7000003@everytruckjob.com> <20060815180634.GB15957@s2.yuriev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815180634.GB15957@s2.yuriev.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 02:06:34PM -0400, alex@yuriev.com wrote:
> > After scouring the net for many days trying to find an answer as to how 
> > to find the broken router, I've come up empty and there are many 
> > references as to why you don't want to disable window scaling completely 
> > which so far has been my only working solution.   Can anyone give 
> > instructions or references as to what the requirements are for a router 
> > to work (specifically Cisco routers)?  Is there a minimum required IOS 
> > or certain commands that must be enabled such as any of the following?
> > ip tcp window-size 8388480
> > ip tcp selective-ack
> > ip tcp timestamp
> > 
> 
> This is absolutely not correct. Routers forward packets. They do not mangle
> the data in them.

Believe it or not, there are a lot of routers nowadays that can do NAT.
And even for very basic NAT, you have to recompute the TCP checksum, which
means that you mangle data within the packet. Even worse, some of them are
able to NAT complex protocols such as FTP and for this, they need to mangle
the application payload. OK, this should not be the router's job, but it's
often the best placed to do the job, and there is customer demand for this.

> Alex

Willy

