Return-Path: <linux-kernel-owner+w=401wt.eu-S1753675AbWLRJyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbWLRJyu (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753668AbWLRJyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:54:50 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:33224 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbWLRJyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:54:50 -0500
X-Originating-Ip: 24.148.236.183
Date: Mon, 18 Dec 2006 04:50:18 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Make entries in the "Device drivers" menu individually
 selectable
In-Reply-To: <4583D008.40806@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.64.0612180444230.16929@localhost.localdomain>
References: <Pine.LNX.4.64.0612140325340.13847@localhost.localdomain>
 <4583D008.40806@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006, Stefan Richter wrote:

> Robert P. J. Day wrote on 2006-12-14:
> >   i've posted on this before so here's a slightly-updated patch that
> > uses the kbuild "menuconfig" feature to make numerous entries under
> > the Device drivers menu selectable on the spot.
>
> Works for me, but I don't see a lot of benefit from it. Actually I see
> two disadvantages of the patch:

... snip ...

>  - There are two out-of-tree FireWire drivers for special purposes
> (one bus sniffer, one remote debugging aid) which might perhaps be
> candidates for integration into mainline. These drivers do not use
> the ieee1394 base driver. (They just don't need to.) With your
> patch, disabling the subsystem menu would not only disable the
> subsystem core driver (which is correct) but would also hide the
> choice for such extra drivers which do not need the core driver. Or
> vice versa, enabling the submenu would enable the core driver, even
> though not all subsystem choices need the core driver.

... snip ...

i've noticed this sort of thing before -- submenus containing entries
that don't actually depend on the top-level config variable.  but
which drivers are you talking about here?  i'm looking at the
ieee1394/Kconfig file and every entry in that submenu appears to
depend explicitly on IEEE1394.

note that that patch i submitted earlier didn't try to modify every
single sub-entry under Device Drivers -- only those for which it
seemed that the transformation wouldn't cause *any* change in
functionality.  so if there was something about ieee1394 that didn't
fit the bill, it's because i must have overlooked something.

in any event, as i mentioned earlier, i'm just trying to find a way to
make the menu entries more obvious and more easily selectable, without
having to enter each submenu to see what it represents.  it's quite
possible that a whole new kbuild directive would be useful here.  who
knows?

rday
