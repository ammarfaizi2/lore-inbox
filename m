Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271197AbTGWSxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271214AbTGWSxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:53:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58004 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271197AbTGWSwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:52:09 -0400
Date: Wed, 23 Jul 2003 12:04:57 -0700
From: "David S. Miller" <davem@redhat.com>
To: Glenn Fowler <gsf@research.att.com>
Cc: gsf@research.att.com, dgk@research.att.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: kernel bug in socketpair()
Message-Id: <20030723120457.206dc02d.davem@redhat.com>
In-Reply-To: <200307231854.OAA90112@raptor.research.att.com>
References: <200307231428.KAA15254@raptor.research.att.com>
	<20030723074615.25eea776.davem@redhat.com>
	<200307231656.MAA69129@raptor.research.att.com>
	<20030723100043.18d5b025.davem@redhat.com>
	<200307231724.NAA90957@raptor.research.att.com>
	<20030723103135.3eac4cd2.davem@redhat.com>
	<200307231814.OAA74344@raptor.research.att.com>
	<20030723112307.5b8ae55c.davem@redhat.com>
	<200307231854.OAA90112@raptor.research.att.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 14:54:49 -0400 (EDT)
Glenn Fowler <gsf@research.att.com> wrote:

> On Wed, 23 Jul 2003 11:23:07 -0700 David S. Miller wrote:
> > On Wed, 23 Jul 2003 14:14:57 -0400 (EDT)
> > Glenn Fowler <gsf@research.att.com> wrote:
> 
> > > named sockets seem a little heavyweight for this application
> 
> > I think it'll be cheaper than unnamed unix sockets and
> > groveling in /proc/*/fd/
> 
> > And even if there is a minor performance issue, you'll more than get
> > that back due to the portability gain. :-)
> 
> named unix sockets reside in the fs namespace, no?

Right.

> so they must be linked to a dir before use and unlinked after use
> the unlink after use would be particularly tricky for the parent process
> implementing
> 	cmd <(cmd ...) ...

Hmmm... true.

I honestly don't know what to suggest you use, sorry :(

Is bash totally broken because of all this?  Or does the problem only
trigger when using (cmd) subprocesses in a certain way?
