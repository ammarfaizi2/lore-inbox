Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932787AbWF0Jiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbWF0Jiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933385AbWF0Jiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:38:52 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:8969 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S932787AbWF0Jiu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:38:50 -0400
Message-ID: <20060627133849.E13959@castle.nmd.msu.ru>
Date: Tue, 27 Jun 2006 13:38:49 +0400
From: Andrey Savochkin <saw@swsoft.com>
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210202.215291000@localhost.localdomain> <20060609210625.144158000@localhost.localdomain> <20060626134711.A28729@castle.nmd.msu.ru> <449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com> <20060627131136.B13959@castle.nmd.msu.ru> <44A0FBAC.7020107@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <44A0FBAC.7020107@fr.ibm.com>; from "Daniel Lezcano" on Tue, Jun 27, 2006 at 11:34:36AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 11:34:36AM +0200, Daniel Lezcano wrote:
> Andrey Savochkin wrote:
> > Daniel,
> > 
> > On Mon, Jun 26, 2006 at 05:49:41PM +0200, Daniel Lezcano wrote:
> > 
> >>>Then you lose the ability for each namespace to have its own routing entries.
> >>>Which implies that you'll have difficulties with devices that should exist
> >>>and be visible in one namespace only (like tunnels), as they require IP
> >>>addresses and route.
> >>
> >>I mean instead of having the route tables private to the namespace, the 
> >>routes have the information to which namespace they are associated.
> > 
> > 
> > I think I understand what you're talking about: you want to make routing
> > responsible for determining destination namespace ID in addition to route
> > type (local, unicast etc), nexthop information, and so on.  Right?
> 
> Yes.
> 
> > 
> > My point is that if you make namespace tagging at routing time, and
> > your packets are being routed only once, you lose the ability
> > to have separate routing tables in each namespace.
> 
> Right. What is the advantage of having separate the routing tables ?

Routing is everything.
For example, I want namespaces to have their private tunnel devices.
It means that namespaces should be allowed have private routes of local type,
private default routes, and so on...

	Andrey
