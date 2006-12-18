Return-Path: <linux-kernel-owner+w=401wt.eu-S1754156AbWLRPfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbWLRPfn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754160AbWLRPfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:35:43 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:53348 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbWLRPfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:35:42 -0500
X-Originating-Ip: 24.148.236.183
Date: Mon, 18 Dec 2006 10:31:31 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Make entries in the "Device drivers" menu individually
 selectable
In-Reply-To: <4586AD83.5030600@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.64.0612181024090.26607@localhost.localdomain>
References: <Pine.LNX.4.64.0612140325340.13847@localhost.localdomain>
 <4583D008.40806@s5r6.in-berlin.de> <Pine.LNX.4.64.0612180444230.16929@localhost.localdomain>
 <4586AD83.5030600@s5r6.in-berlin.de>
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

On Mon, 18 Dec 2006, Stefan Richter wrote:

> Robert P. J. Day wrote:

> [...]
> > in any event, as i mentioned earlier, i'm just trying to find a
> > way to make the menu entries more obvious and more easily
> > selectable, without having to enter each submenu to see what it
> > represents.
> [...]
>
> Yes, this and the points you made in the other post are definitely
> valid.

this is a long-term suggestion, but the easiest solution might be to
introduce a new kbuild directive:  "selectablemenu" or something like
that, with a form similar to:

=================
selectablemenu ISDN
	bool "ISDN support"

config ...
config ...
config ...

endmenu
=================

  the top level entry would be just a yes/no toggle as to whether you
want that support in general, and the internal entries would represent
the submenu and all of them would *automatically* depend on the top
config entry (in this case, ISDN).  and the "help" entry could be
available from that top-level entry without having to enter the
submenu. as opposed to what you need to do now.

  i'm guessing that structure would be sufficient for 90% of the
current menu layouts.  just a thought.

rday
