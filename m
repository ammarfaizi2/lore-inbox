Return-Path: <linux-kernel-owner+w=401wt.eu-S1752532AbWLQMcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbWLQMcp (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 07:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbWLQMco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 07:32:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39956 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752535AbWLQMco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 07:32:44 -0500
Date: Sun, 17 Dec 2006 13:32:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "J.H." <warthog9@kernel.org>, vojtech@suse.cz
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, hpa@zytor.com,
       webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-ID: <20061217123233.GD28628@elf.ucw.cz>
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166297434.26330.34.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The problem has been hashed over quite a bit recently, and I would be
> curious what you would consider the real problem after you see the
> situation.
> 
> The root cause boils down to with git, gitweb and the normal mirroring
> on the frontend machines our basic working set no longer stays resident
> in memory, which is forcing more and more to actively go to disk causing
> a much higher I/O load.  You have the added problem that one of the
> frontend machines is getting hit harder than the other due to several
> factors: various DNS servers not round robining, people explicitly
> hitting [git|mirrors|www|etc]1 instead of 2 for whatever reason and
> probably several other factors we aren't aware of.  This has caused the
> average load on that machine to hover around 150-200 and if for whatever
> reason we have to take one of the machines down the load on the
> remaining machine will skyrocket to 2000+.  
> 
> Since it's apparent not everyone is aware of what we are doing, I'll
> mention briefly some of the bigger points.
> 
> - We have contacted HP to see if we can get additional hardware, mind
> you though this is a long term solution and will take time, but if our
> request is approved it will double the number of machines kernel.org
> runs.

Would you accept help from someone else than HP? kernel.org is very
important, and hardware is cheap these days... What are the
requirements for machine to be interesting to kernel.org? I guess
AMD/1GHz, 1GB ram, 100GB disk is not interesting to you....


								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
