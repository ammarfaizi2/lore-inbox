Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbTHYP5e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 11:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbTHYP5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 11:57:34 -0400
Received: from ns.suse.de ([195.135.220.2]:13263 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262002AbTHYP5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 11:57:31 -0400
Date: Mon, 25 Aug 2003 17:57:28 +0200
From: ak@suse.de
Message-Id: <200308251557.h7PFvSNV014402@oldwotan.suse.de>
To: paul.devriendt@amd.com
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, aj@suse.de,
       mark.la@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ngsdorf@amd.com, richard.brunner@amd.com, pavel@suse.cz
Subject: Re: Cpufreq for opteron
References: <99F2150714F93F448942F9A9F112634C080EF014@txexmtae.amd.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 25 Aug 2003 17:57:27 +0200
In-Reply-To: <99F2150714F93F448942F9A9F112634C080EF014@txexmtae.amd.com.suse.lists.linux.kernel>
Message-ID: <p731xv9687s.fsf@oldwotan.suse.de>
Lines: 41
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

paul.devriendt@amd.com writes:

> > -----Original Message-----
> > From: Pavel Machek [mailto:pavel@suse.cz]
> > Sent: Monday, August 25, 2003 8:51 AM
> > To: Devriendt, Paul
> > Cc: davej@redhat.com; linux-kernel@vger.kernel.org; aj@suse.de;
> > Langsdorf, Mark; Brunner, Richard
> > Subject: Re: Cpufreq for opteron
> > 
> > 
> > Hi!
> > 
> > > > 4) given good hardware and debugged driver, will any of those
> > > > BUG_ON()s ever trigger?
> > > 
> > > Only if there are BIOS problems. 
> > 
> > In such case, I believe best idea is to leave them in as BUG_ON(). On
> > broken BIOS, it will kill machine cleanly, and hopefully bios is going
> > to be fixed.
> > 
> > If broken BIOS is seen in retail, we'll need to solve this other way.
> > 
> > Does this seem okay to you?
> 
> My concerns with the BUG_ON() approach are :
>   1. Ease of me debugging the problem, as some of the state data I would
>      want to see is global, so it might not be in a backtrace.
>   2. Taking the machine down when exestuation could continue.
> 
> You have more kernel experience than I do, so I am willing to accept your
> advice. I am ok with it.

I agree with your concerns. I would not back down.

BUG_ON to handle non fatal BIOS issues is just the wrong tool.
BUG_ON is for internal code problems, it is not an appropiate error handler
for external issues (like a broken BIOS)

-Andi
