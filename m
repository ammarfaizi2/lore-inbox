Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTHUOIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 10:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTHUOIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 10:08:41 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:5069 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S262674AbTHUOIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 10:08:39 -0400
Date: Thu, 21 Aug 2003 16:08:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jamie Lokier <jamie@shareable.org>
cc: Andries Brouwer <aebr@win.tue.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: <20030821134854.GA28593@mail.jlokier.co.uk>
Message-ID: <Pine.GSO.3.96.1030821155653.2489I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, Jamie Lokier wrote:

> The user doesn't care if it's PS/2 compliant or not.  It must work,
> that is the only important thing.  Even more so, given it is flawless

 Yep, but "work" is ambiguous.  What one considers working, someone else
may consider insufficient.  That's why there are various quality goods out
there -- someone might want to sacrifice quality to get a low price and
someone else might want to get best quality he can afford.

> Perhaps you can detect a keyboard being unplugged by periodically
> sending it Echo commands (EE), or any other command to which it responds.

 Due to communication latencies and the system load it would be
unreasonable to send an echo request more often than once, perhaps twice
per second.  And it's quite easy to unplug and then plug a keyboard back
in a shorter time. 

 Disabling the translation in the onboard 8042 solves the problem and I am
quite surprised there are problems with that.  After all a pass-through
mode is easier to implement than a cooked one -- it's essentially a no-op.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

