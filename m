Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967174AbWKYVon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967174AbWKYVon (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 16:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967193AbWKYVon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 16:44:43 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:52869 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S967187AbWKYVom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 16:44:42 -0500
Date: Sat, 25 Nov 2006 13:44:58 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MPT:  make all Fusion MPT sub-choices singly selectable
Message-Id: <20061125134458.43cf3ee7.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0611251548530.24225@localhost.localdomain>
References: <Pine.LNX.4.64.0611250627200.20370@localhost.localdomain>
	<20061125121210.52c66f55.randy.dunlap@oracle.com>
	<Pine.LNX.4.64.0611251548530.24225@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006 15:54:18 -0500 (EST) Robert P. J. Day wrote:

> On Sat, 25 Nov 2006, Randy Dunlap wrote:
> 
> ... snip ...
> 
> > Here's another option.  What do you think of it?
> 
> ...
> 
> > --- linux-2.6.19-rc6-git8.orig/drivers/message/fusion/Kconfig
> > +++ linux-2.6.19-rc6-git8/drivers/message/fusion/Kconfig
> > @@ -1,14 +1,12 @@
> >
> > -menu "Fusion MPT device support"
> > +menuconfig FUSION
> > +	bool "Fusion MPT device support"
> >
> > -config FUSION
> > -	bool
> > -	default n
> > +if FUSION
> 
> ... more snip ...
> 
>   i suspect you already noticed that that's what i proposed in my
> followup posting.  :-)  my first suggestion explicitly didn't mess
> with the "Device Drivers" menu, only the underlying MPT submenu.

Actually I had not looked at that email yet -- have now.

>   my second posting went that extra step and added selection boxes to
> the Device Drivers menu entries themselves, although your solution is
> nicer than mine, surrounding the MPT entries with a single "if FUSION"
> rather than my adding a dependency to every selection.
> 
>   i'm willing to come up with some patches that match your suggestion,
> but what do others think of changing the fundamental layout of the
> Device Drivers menu (and perhaps other menus) to that extent by adding
> that extra selector?

I like it, but your question to "others" is good.
I.e., it would help to have more comments/consensus on this IMO.

---
~Randy
