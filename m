Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbWF0JLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWF0JLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbWF0JLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:11:39 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:39688 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S1751309AbWF0JLh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:11:37 -0400
Message-ID: <20060627131136.B13959@castle.nmd.msu.ru>
Date: Tue, 27 Jun 2006 13:11:36 +0400
From: Andrey Savochkin <saw@swsoft.com>
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210202.215291000@localhost.localdomain> <20060609210625.144158000@localhost.localdomain> <20060626134711.A28729@castle.nmd.msu.ru> <449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <44A00215.2040608@fr.ibm.com>; from "Daniel Lezcano" on Mon, Jun 26, 2006 at 05:49:41PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On Mon, Jun 26, 2006 at 05:49:41PM +0200, Daniel Lezcano wrote:
> 
> > Then you lose the ability for each namespace to have its own routing entries.
> > Which implies that you'll have difficulties with devices that should exist
> > and be visible in one namespace only (like tunnels), as they require IP
> > addresses and route.
> 
> I mean instead of having the route tables private to the namespace, the 
> routes have the information to which namespace they are associated.

I think I understand what you're talking about: you want to make routing
responsible for determining destination namespace ID in addition to route
type (local, unicast etc), nexthop information, and so on.  Right?

My point is that if you make namespace tagging at routing time, and
your packets are being routed only once, you lose the ability
to have separate routing tables in each namespace.

	Andrey
