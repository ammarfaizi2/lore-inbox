Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUHJK14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUHJK14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUHJK12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:27:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:39364 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264307AbUHJKUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:20:55 -0400
Date: Tue, 10 Aug 2004 12:20:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, david-b@pacbell.net
Subject: Re: [RFC] Fix Device Power Management States
Message-ID: <20040810102054.GG9034@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <20040809113829.GB9793@elf.ucw.cz> <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net> <20040809212949.GA1120@elf.ucw.cz> <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net> <1092130981.2676.1.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092130981.2676.1.camel@laptop.cunninghams>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Once the swsusp consolidation is merged upstream, I will merge a new
> > device power model in -mm, and we can start working on the drivers. How
> > does that sound?
> 
> Do you want me to merge before or after all this is done; I'm a bit
> concerned that you guys are expending effort (well, Pavel is), getting
> SMP and Highmem going when I already have a working version that -
> unless the plans have changed - we were intending to merge too.

I needed to do highmem anyway (for SUSE kernel)... SMP... I'm not 100%
convinced that SMP support in suspend2 is correct. (Notice: swsusp/SMP
support in current mainline is *not* correct, either). In particular,
if you sleep the CPU, it needs to loop somewhere, right? Can you quote
the piece of code where sleeping CPUs are spinning? ...that one needs
to be in assembly :-(.

Anyway, I believe that refrigerator merge can be done in paralel with
device tree changes, as it will be always very clear what is broken.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
