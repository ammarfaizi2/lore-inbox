Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVIZU1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVIZU1i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVIZU1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:27:38 -0400
Received: from [212.76.85.1] ([212.76.85.1]:772 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932490AbVIZU1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:27:37 -0400
From: Al Boldi <a1426z@gawab.com>
To: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: Resource limits
Date: Mon, 26 Sep 2005 23:26:10 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200509251712.42302.a1426z@gawab.com> <200509262032.14613.a1426z@gawab.com> <20050926175148.GA3797@hmsreliant.homelinux.net>
In-Reply-To: <20050926175148.GA3797@hmsreliant.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509262326.10305.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
> On Mon, Sep 26, 2005 at 08:32:14PM +0300, Al Boldi wrote:
> > Neil Horman wrote:
> > > On Mon, Sep 26, 2005 at 05:18:17PM +0300, Al Boldi wrote:
> > > > Rik van Riel wrote:
> > > > > On Sun, 25 Sep 2005, Al Boldi wrote:
> > > > > > Too many process forks and your system may crash.
> > > > > > This can be capped with threads-max, but may lead you into a
> > > > > > lock-out.
> > > > > >
> > > > > > What is needed is a soft, hard, and a special emergency limit
> > > > > > that would allow you to use the resource for a limited time to
> > > > > > circumvent a lock-out.
> > > > >
> > > > > How would you reclaim the resource after that limited time is
> > > > > over ?  Kill processes?
> > > >
> > > > That's one way,  but really, the issue needs some deep thought.
> > > > Leaving Linux exposed to a lock-out is rather frightening.
> > >
> > > What exactly is it that you're worried about here?
> >
> > Think about a DoS attack.
>
> Be more specific.  Are you talking about a fork bomb, a ICMP flood, what?

How would you deal with a situation where the system hit the threads-max 
ceiling?

> preventing resource starvation/exhaustion is often handled in a way thats
> dovetailed to the semantics of how that resources is allocated (i.e. you
> prevent syn-flood attacks differently than you manage excessive disk
> usage).

The issue here is a general lack of proper kernel support for resource 
limits.  The fork problem is just an example.

Thanks!

--
Al

