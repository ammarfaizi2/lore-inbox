Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269003AbUIXWTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269003AbUIXWTt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269020AbUIXWTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:19:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:7902 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269003AbUIXWTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:19:09 -0400
Date: Fri, 24 Sep 2004 15:19:06 -0700
From: Chris Wright <chrisw@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wright <chrisw@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040924151906.X1924@build.pdx.osdl.net>
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1096060045.10800.4.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Fri, Sep 24, 2004 at 10:07:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Gwe, 2004-09-24 at 21:22, Chris Wright wrote:
> > Hard to say if it's a policy decision outside the scope of the app.
> > Esp. if the app knows it needs to not be swapped.  Either something that
> > has realtime needs, or more specifically, privacy needs.  Don't need to
> > mlock all of gpg to ensure key data never hits swap.
> 
> Keys are a different case anyway. We can swap them if we have encrypted
> swap (hardware or software) and we could use the crypto lib just to
> crypt some pages in swap although that might be complex. As such a
> MAP_CRYPT seems better than mlock. If we don't have cryptable swap then
> fine its mlock.

Yeah, sounds nice.  This is still very much an app specific policy, not
something that a helper such as mlock(1) would solve.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
