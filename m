Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265092AbTFEVdN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbTFEVdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:33:13 -0400
Received: from mail.ccur.com ([208.248.32.212]:30724 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265092AbTFEVdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 17:33:12 -0400
Date: Thu, 5 Jun 2003 17:46:38 -0400
From: Joe Korty <joe.korty@ccur.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] Non-blocking write can block
Message-ID: <20030605214638.GA19229@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <11E89240C407D311958800A0C9ACF7D1A33EBD@EXCHANGE> <Pine.LNX.4.55.0306041717230.3655@bigblue.dev.mcafeelabs.com> <20030605183408.GB3291@matchmail.com> <Pine.LNX.4.53.0306051513570.2008@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0306051513570.2008@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 03:15:19PM -0400, Richard B. Johnson wrote:
> On Thu, 5 Jun 2003, Mike Fedyk wrote:
> > Also, what do other UNIX OSes do?  Do they have seperate semantics for
> > O_NONBLOCK and O_NDELAY?  If so, then it would probably be better to change
> > O_NDELAY to be similar and add another feature at the same time as reducing
> > platform specific codeing in userspace.
> 
> My Sun thinks that O_NDELAY = 0x04 and O_NONBLOCK = 0x80, FWIW.


Same here on my AT&T System V ES/MP box.

As far as semantics go, the two appear to be identical except that
O_NDELAY always returns 0 on a blocking condition while O_NONBLOCK
usually returns EAGAIN and only occasionally returns 0.

Joe


[cc list trimmed]
