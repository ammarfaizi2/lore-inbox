Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269042AbUIXXIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269042AbUIXXIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 19:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbUIXXIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 19:08:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:61852 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269042AbUIXXIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 19:08:19 -0400
Date: Fri, 24 Sep 2004 16:08:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040924160817.Y1924@build.pdx.osdl.net>
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain> <20040924151906.X1924@build.pdx.osdl.net> <41549FEF.30008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41549FEF.30008@pobox.com>; from jgarzik@pobox.com on Fri, Sep 24, 2004 at 06:30:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik (jgarzik@pobox.com) wrote:
> Chris Wright wrote:
> > * Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> > >On Gwe, 2004-09-24 at 21:22, Chris Wright wrote:
> >>>Hard to say if it's a policy decision outside the scope of the app.
> >>>Esp. if the app knows it needs to not be swapped.  Either something that
> >>>has realtime needs, or more specifically, privacy needs.  Don't need to
> >>>mlock all of gpg to ensure key data never hits swap.
> >>
> >>Keys are a different case anyway. We can swap them if we have encrypted
> >>swap (hardware or software) and we could use the crypto lib just to
> >>crypt some pages in swap although that might be complex. As such a
> >>MAP_CRYPT seems better than mlock. If we don't have cryptable swap then
> >>fine its mlock.
> > 
> > Yeah, sounds nice.  This is still very much an app specific policy, not
> > something that a helper such as mlock(1) would solve.
> 
> It's all app-specific policy.  mlock(1) allows the sysadmin to apply 
> app-specific policy on top of whatever app-specific policy the engineer 
> has chosen to hardcode into his app.
> 
> A smart sysadmin that knows the working set of his _local configuration_ 
> of a given app is sometimes in a better position to make a decision 
> about mlockall(2) than the engineer.

OK, that's fine.  I just wanted to highlight some situations
where it's preferable to leave that hardcoded in the application.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
