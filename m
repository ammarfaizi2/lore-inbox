Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423659AbWJaVgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423659AbWJaVgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423658AbWJaVgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:36:39 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61584
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1423650AbWJaVgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:36:38 -0500
Date: Tue, 31 Oct 2006 13:36:39 -0800 (PST)
Message-Id: <20061031.133639.112620851.davem@davemloft.net>
To: shemminger@osdl.org
Cc: peter.hicks@poggs.co.uk, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Thousands of interfaces
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061031102222.7ab1ed6b@freekitty>
References: <20061031092550.GA8201@tufnell.london.poggs.net>
	<20061031.013154.122620846.davem@davemloft.net>
	<20061031102222.7ab1ed6b@freekitty>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Tue, 31 Oct 2006 10:22:22 -0800

> On Tue, 31 Oct 2006 01:31:54 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:
> 
> > From: Peter Hicks <peter.hicks@poggs.co.uk>
> > Date: Tue, 31 Oct 2006 09:25:50 +0000
> > 
> > [ Discussion belongs on netdev@vger.kernel.org, added to CC: ]
> > 
> > > I have a dual 3GHz Xeon machine with a 2.4.21 kernel and thousands (15k+) of
> > > ipip tunnel interfaces.  These are being used to tunnel traffic from remote
> > > routers, over a private network, and handed off to a third party.
> >  ...
> > > Is it possible to speed up creation of the interfaces?  Currently it takes
> > > around 24 hours.  Is there are more efficient way to handle a very large
> > > number of IP-IP tunnels?  Would upgrading to a 2.6 kernel be of use?
> > 
> 
> 
> 2.4 has a several N^2 searches for interfaces (and is in deep freeze by now).
> 2.6 had several changes to handle 1000's of interfaces.

Oops I didn't notice this was with 2.4.x.  Indeed, 2.4.x definitely
cannot handle large numbers of networking interfaces at all without
major surgery.  2.6.x should handle this significantly better.
