Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUK0BgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUK0BgA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbUKZTji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:39:38 -0500
Received: from zeus.kernel.org ([204.152.189.113]:20931 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262466AbUKZT2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:28:03 -0500
Date: Thu, 25 Nov 2004 23:38:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 22/51: Suspend2 lowlevel code.
Message-ID: <20041125223806.GD2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101296166.5805.279.camel@desktop.cunninghams> <20041125183923.GK1417@openzaurus.ucw.cz> <1101420908.27250.71.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101420908.27250.71.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > + * Note that the context and timing of this function is pretty critical.
> > > + * With a minimal amount of things going on in the caller and in here, gcc
> > > + * does a good job of being just a dumb compiler.  Watch the assembly output
> > > + * if anything changes, though, and make sure everything is going in the right
> > > + * place. 
> > 
> > You should include assembly source (unless you can test all the compilers...). Feel free
> > to include C version, too, but #ifdef it out.
> 
> I'm thinking I should actually be removing the comment. The C is simple,
> clear, fast and easy to maintain and we haven't actually had any
> problems at all with compilers. All my tweaking in here has turned out
> to be irrelevant to the real cause of problems (I recently found a bug
> where work queues were wrongly inheriting freezer flags; since fixing
> that, all the symptoms in this area have gone away).

See the flames I got when I did just that. No, it needs to be in
assembly, because (by standard) C compiler is allowed to misoptimize
it.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
