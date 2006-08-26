Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWHZTbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWHZTbu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 15:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWHZTbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 15:31:50 -0400
Received: from p02c11o144.mxlogic.net ([208.65.145.67]:33455 "EHLO
	p02c11o144.mxlogic.net") by vger.kernel.org with ESMTP
	id S1750732AbWHZTbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 15:31:49 -0400
Date: Sat, 26 Aug 2006 22:31:27 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Robert Walsh <rjwalsh@pathscale.com>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 22 of 23] IB/ipath - print warning if LID not acquired within one minute
Message-ID: <20060826193126.GF21168@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <44EF6053.4010006@pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EF6053.4010006@pathscale.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 26 Aug 2006 19:37:48.0234 (UTC) FILETIME=[1C5CC2A0:01C6C947]
X-Spam: [F=0.0100000000; S=0.010(2006081701)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Robert Walsh <rjwalsh@pathscale.com>:
> Subject: Re: [PATCH 22 of 23] IB/ipath - print warning if LID not acquired within one minute
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Roland Dreier wrote:
> > 1) What makes ipath special so that we want this warning for ipath
> > devices but not other IB hardware?
> 
> There's nothing special about our hardware that requires this.  We just
> wanted that in there so we could direct customers to look at dmesg to
> see if the warning popped up if they call with a problem.  It is useful
> to have for this purpose.
> 
> > If this warning is actually
> > useful, then I think it would make more sense to start a timer when
> > any IB device is added, and warn if ports with a physical link don't
> > become active after the timeout time.
> 
> I'd be OK with doing that, too.

Looks like your devices are all single-port. With a multi port
device it is quite common to have one port down.

> > But I'm having a hard time
> > seeing why we want this message in the kernel log.
> 
> It's useful when you're trying to track down problems.

How about doing this in userspace by looking at port state in sysfs?
You can diagnose a much wider class of problems this way.

-- 
MST
