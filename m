Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVEQRUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVEQRUd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVEQRU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:20:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:54724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261894AbVEQRT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:19:28 -0400
Date: Tue, 17 May 2005 10:20:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: Kirill Korotaev <dev@sw.ru>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog config option (was: Re: [PATCH] NMI lockup
 and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI)
In-Reply-To: <Pine.LNX.4.61L.0505171747540.17529@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.58.0505171017480.18337@ppc970.osdl.org>
References: <42822B5F.8040901@sw.ru> <768860000.1116282855@flay>
 <42899797.2090702@sw.ru> <Pine.LNX.4.58.0505170844550.18337@ppc970.osdl.org>
 <Pine.LNX.4.61L.0505171656300.17529@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.58.0505170928220.18337@ppc970.osdl.org>
 <Pine.LNX.4.61L.0505171747540.17529@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 May 2005, Maciej W. Rozycki wrote:
>
> > "exciting", and we've several times had code that does actually disable
> > interrupts for a long time - which may be exceedingly impolite, but then
> > the NMI watchdog makes it a fatal error rather than something that is just
> > a nuisanse.
> 
>  Well, this is actually not a problem with the watchdog itself.  And I'd 
> rather say it's doing us a favour (and a great job) finding these buggy 
> bits of code that keep interrupts off CPUs. ;-)

For a _developer_ yes.

For a user under X, who finds his machine locked up and not doing 
anything, no.

And this is _exactly_ why we don't enable it by default. Go wild on your 
own machines - I used to do it myself. But users are better off with 
working machines.

IOW, testing is good, but it's _not_ good if you test your users to 
destruction.  User testing should be limited (as far as humanly possible) 
to things that they can sanely report.

			Linus
