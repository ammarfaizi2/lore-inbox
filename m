Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbTIYM3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 08:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTIYM3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 08:29:30 -0400
Received: from aloggw2.analogic.com ([204.178.40.3]:7175 "EHLO
	aloggw2.analogic.com") by vger.kernel.org with ESMTP
	id S261293AbTIYM32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 08:29:28 -0400
From: "Richard B. Johnson" <johnson@quark.analogic.com>
Reply-To: "Johnson, Richard" <rjohnson@analogic.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: "Johnson, Richard" <rjohnson@analogic.com>, linux-kernel@vger.kernel.org
Date: Thu, 25 Sep 2003 08:30:14 -0400 (EDT)
Subject: Re: [OT] Re: Horiffic SPAM
In-Reply-To: <3F72A59D.4000407@aitel.hist.no>
Message-ID: <Pine.LNX.4.53.0309250819560.32337@quark.analogic.com>
References: <Pine.LNX.4.53.0309231408260.28457@quark.analogic.com>
 <20030923183648.GE1269@velociraptor.random> <Pine.LNX.4.53.0309241006500.30216@quark.analogic.com>
 <3F72A59D.4000407@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Sep 2003, Helge Hafting wrote:

> Richard B. Johnson wrote:
> > On Tue, 23 Sep 2003, Andrea Arcangeli wrote:
> >
> >
> >>On Tue, Sep 23, 2003 at 02:11:59PM -0400, Richard B. Johnson wrote:
> >>
>
> > Well it seems that fire-walling the SPAM servers is *not* a good idea.
> > They are persistant, gang up, and will not give up until they are
> > able to deliver the mail! When I firewall them, my network traffic
>
> According to standards they will give up after 5 days or so.
>
> > ends up being continuous SYN floods as every spam-server in the
> > country tries to connect. It doesn't do any good to set `ipchains` to
> > REJECT instead of DENY. They just keep on banging on the door.
> >
>
> Have you considered teergrubing them instead?  That ought to
> fix the bandwith problem.  And it is not so fun for whoever has
> the spam server either - either disrupting some spammers operation
> or harassing some server admin into making his box un-abuseable.
>
>

I thought it would be easier than that. However, I did write a
program that keeps the connection open forever (until the SPAM-server
hangs up). This slows down the servers. I also thought that I could
make multiple connections to the server and never hang up, depriving
the SPAM-server of resources. However, I can't make a new connection
with the same socket (don't know why), EISCONN,  without closing the
previous.
This means that I need a new socket for each connection. I run out
of sockets before the SPAM-servers do.


> Helge Hafting
>


Richard B. Johnson
Project Engineer
Analogic Corporation
Penguin : Linux version 2.2.15 on an i586 machine (330.14 BogoMips).
