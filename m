Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbWF0Lza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWF0Lza (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWF0Lz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:55:29 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:30219 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S1161061AbWF0Lz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:55:27 -0400
Message-ID: <20060627155525.B15503@castle.nmd.msu.ru>
Date: Tue, 27 Jun 2006 15:55:25 +0400
From: Andrey Savochkin <saw@swsoft.com>
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210202.215291000@localhost.localdomain> <20060609210625.144158000@localhost.localdomain> <20060626134711.A28729@castle.nmd.msu.ru> <449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com> <20060627131136.B13959@castle.nmd.msu.ru> <44A0FBAC.7020107@fr.ibm.com> <20060627133849.E13959@castle.nmd.msu.ru> <44A1149E.6060802@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <44A1149E.6060802@fr.ibm.com>; from "Daniel Lezcano" on Tue, Jun 27, 2006 at 01:21:02PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On Tue, Jun 27, 2006 at 01:21:02PM +0200, Daniel Lezcano wrote:
> >>>My point is that if you make namespace tagging at routing time, and
> >>>your packets are being routed only once, you lose the ability
> >>>to have separate routing tables in each namespace.
> >>
> >>Right. What is the advantage of having separate the routing tables ?
> > 
> > 
> > Routing is everything.
> > For example, I want namespaces to have their private tunnel devices.
> > It means that namespaces should be allowed have private routes of local type,
> > private default routes, and so on...
> > 
> 
> Ok, we are talking about the same things. We do it only in a different way:

We are not talking about the same things.

It isn't a technical thing whether route lookup is performed before or after
namespace change.
It is a fundamental question determining functionality of network namespaces.
We are talking about the capabilities namespaces provide.

Your proposal essentially denies namespaces to have their own tunnel or other
devices.  There is no point in having a device inside a namespace if the
namespace owner can't route all or some specific outgoing packets through
that device.  You don't allow system administrators to completely delegate
management of network configuration to namespace owners.

	Andrey
