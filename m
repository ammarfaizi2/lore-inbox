Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265695AbUFXVeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265695AbUFXVeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265696AbUFXVd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:33:56 -0400
Received: from gprs214-211.eurotel.cz ([160.218.214.211]:13953 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265695AbUFXVbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:31:01 -0400
Date: Thu, 24 Jun 2004 23:30:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Fao, Sean" <Sean.Fao@dynextechnologies.com>
Cc: linux-kernel@vger.kernel.org, Amit Gud <gud@eth.net>
Subject: Re: Elastic Quota File System (EQFS)
Message-ID: <20040624213041.GA20649@elf.ucw.cz>
References: <40d9ac40.674.0@eth.net> <200406231853.35201.mrwatts@fast24.co.uk> <1088016048.15211.10.camel@sage.kitchen> <001901c459cd_bc436e40_868209ca@home> <20040624115019.GA3614@suse.de> <20040624141742.GD698@openzaurus.ucw.cz> <40DB3263.40600@dynextechnologies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DB3263.40600@dynextechnologies.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>What action should be taken can be specified by the user while making the
> >>>files elastic. He can either opt to delete the file, compress it or move 
> >>>it
> >>>to some place (backup) where he know he has write access. The 
> >>>corresponding
> >>>     
> >>>
> >>- having files disappear at the discretion of the filesystem seems to be
> >> bad behaviour: either I need this file, then I do not want it to just
> >> disappear, or I do not need it, and then I can delete it myself.
> >>   
> >>
> >
> >
> >Actually, think .o or mozilla cache files... You don't need them, but if 
> >you have them,
> >things are faster.
> > 
> >
> I fail to understand the point you're trying to make.  Are you 
> suggesting that a feature doesn't necessarily have to be implemented, 
> just because it's there?  If so, the proposed idea on the "elastic" file 
> system differs greatly.  Cached content, for instance, speeds up the 
> browsing experience *without* hindering the ability of the application 
> to function normally.  Caching is a true enhancement --in most 
> circumstances.  I can personally see no way to implement EQFS without 
> greatly exasperating end users with its shortcomings.

Okay, lets make it explicit.

On one school server, theres 10MB quota. (Okay, its admins are
BOFHs^H^H^H^H^HSISAL). Everyone tries to run mozilla there (because
its installed as default!), and immediately fills his/her quota with
cache files, leading to failed login next time (gnome just will not
start if it can't write to ~).

Imagine mozilla automatically marking cache files "elastic".

That would solve the problem -- mozilla caches would go away when disk
space was demanded, still mozilla's on-disk caching would be effective
when there is enough disk space.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
