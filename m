Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTLPNhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 08:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTLPNhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 08:37:47 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:64975 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261595AbTLPNho
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 08:37:44 -0500
Date: Tue, 16 Dec 2003 14:37:42 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: George Anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <3FDE2AC6.30902@mvista.com>
Message-ID: <Pine.LNX.4.55.0312161426060.8262@jurand.ds.pg.gda.pl>
References: <3FD5F9C1.5060704@nishanet.com> <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl>
 <brcoob$a02$1@gatekeeper.tmr.com> <3FDA40DA.20409@mvista.com>
 <Pine.LNX.4.55.0312151412270.26565@jurand.ds.pg.gda.pl> <3FDE2AC6.30902@mvista.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003, George Anzinger wrote:

> >  Hmm, you could have simply asked... ;-)  Anyway, an inclusion is doable,
> > I guess.
> 
> I suspect I did, but most likey the wrong place.  In any case, I would like to 
> think that "read the source, Luke" is the right answer.

 Certainly it is, but not necessarily the only one. ;-)

> So, while I am in the asking mode, is there a simple way to turn off the PIT 
> interrupt without changing the PIT program?  I would like a way to stop the 
> interrupts AND also stop the NMIs that it generates for the watchdog.  I suspect 
> that this is a bit more complex that it would appear, due to how its wired.

 Well, in PC/AT compatible implementations, the counter #0 of the PIT has
its gate hardwired to active, so you cannot mask the PIT output itself.  
So the only other choices are either reprogramming the counter to a mode
that won't cause periodic triggers (which is probably the easiest way, but
you don't want to do that for some purpose, right?) or reprogramming
interrupt controllers not to accept interrupts arriving from the PIT.

 Note that Linux may behave strangely then. ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
