Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424056AbWLBNgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424056AbWLBNgS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 08:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424060AbWLBNgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 08:36:18 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:62435 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1424056AbWLBNgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 08:36:17 -0500
X-Originating-Ip: 74.109.98.100
Date: Sat, 2 Dec 2006 08:32:54 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: proposed patch:  standardize white space for "#endif /* __KERNEL__
 */" directives
Message-ID: <Pine.LNX.4.64.0612020823330.17876@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  i've got a one-line perl command that runs through include/linux and
standardizes all of the "#endif" directives for "__KERNEL__" into a
single variant

#endif /* __KERNEL__ */

where all of the whitespace bits above are a single space and nothing
more.

  while this is clearly just aesthetic and involves only whitespace
transformation, it was handy when i was messing around with what
happened during "make headers_install" as i was trying to match the
opening and closing __KERNEL__ directives, and i had to accommodate
that some of those #endif directives had a space, and others a tab, or
multiple spaces, or multiple tabs, etc.  grrrrrrrrrr.

  is it worth submitting this kind of whitespace-related patch?
obviously, it can be done for the entire tree (perhaps in a multi-part
patch) or just include/linux where i was using it.

  if that goes in, a follow-up patch would add any missing __KERNEL__
comments to the corresponding #endif directives so that, visually, it
would be far easier to see the nesting.

  thoughts?  or a waste of time?

rday

p.s.  there is the occasional

#endif    // __KERNEL__

directive as well, but that's obviously just as easy to handle.
