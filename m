Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266568AbUHSPky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266568AbUHSPky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbUHSPkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:40:52 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:10404 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S266536AbUHSPgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:36:55 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Thu, 19 Aug 2004 11:36:49 -0400
User-Agent: KMail/1.6.82
Cc: Matthias Andree <matthias.andree@gmx.de>, Martin Mares <mj@ucw.cz>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       kernel@wildsau.enemy.org, diablod3@gmail.com
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <20040819141442.GC13003@ucw.cz> <20040819150704.GB1659@merlin.emma.line.org>
In-Reply-To: <20040819150704.GB1659@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200408191136.49766.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.62.54] at Thu, 19 Aug 2004 10:36:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 11:07, Matthias Andree wrote:
>On Thu, 19 Aug 2004, Martin Mares wrote:
>> That's really hard to believe, but on the other hand, when
>> packaging my programs, SUSE people were always cooperating very
>> well.
>
>It depends on whom you talk to. The generic feedback ways don't work
>well at all, 80% of issues are apparently dropped, no chance to
> query status from the outside, and it takes ages until something
> happens.
>
>> So, let's ask the SUSE'rs around there: is there any problem with
>> adding such a notice to the cdrecord package?
>
>Non-issue.  SuSE 9.1 PRO:
>
>$ rpm -qf /usr/bin/cdrecord
>cdrecord-2.01a27-21
>$ /usr/bin/cdrecord -version
>ZY�$: Operation not permitted. WARNING: Cannot set RR-scheduler
>ZY�$: Permission denied. WARNING: Cannot set priority using
> setpriority(). ZY�$: WARNING: This causes a high risk for buffer
> underruns. Cdrecord-Clone-dvd 2.01a27 (i686-suse-linux) Copyright
> (C) 1995-2004 Jörg Schilling Note: This version is an unofficial
> (modified) version with DVD support Note: and therefore may have
> bugs that are not present in the original. Note: Please send bug
> reports or support requests to http://www.suse.de/feedback Note:
> The author of cdrecord should not be bothered with problems in this
> version.
>
>BTW:
>
>$ /opt/schily/bin/cdrecord -version
>Cdrecord-Clone 2.01a37 (i686-pc-linux-gnu) Copyright (C) 1995-2004
> J�rg Schilling /opt/schily/bin/cdrecord: Warning: Running on
> Linux-2.6.8.1 /opt/schily/bin/cdrecord: There are unsettled issues
> with Linux-2.5 and newer. /opt/schily/bin/cdrecord: If you have
> unexpected problems, please try Linux-2.4 or Solaris.
>
>I read the discussion as though these issues had been settled with
>Linux 2.6.8. Is 2.01a37 too old to be aware of the fix or is there
> an issue left with finding the "right" header files?

FWIW, I had to use smake, latest version from his site, in order to 
compile 2.01a37 just yesterday.  The error messages from make (very 
carefully programmed into the Makefile) indicated that the lost 
headers it couldn't find were a bug in make-3.80, and that his make 
suffered from no such errors.  It didn't.

Since the gnu make has only had, what, 2, maybe 3 revisions in almost 
a decade, maybe, just maybe, there is a grain of truth to Jorg's 
objections and often childish squawking, at least over the gnu make 
which he has mentioned, among others.

[root@coyote cdrecord]# cdrecord --version
Cdrecord-Clone 2.01a37 (i686-pc-linux-gnu) Copyright (C) 1995-2004 
Jörg Schilling
cdrecord: Warning: Running on Linux-2.6.8-rc4
cdrecord: There are unsettled issues with Linux-2.5 and newer.
cdrecord: If you have unexpected problems, please try Linux-2.4 or 
Solaris.

However Jorg, since I built from your tarball, and used smake to do 
it, why is it now proclaiming to be a "Clone".

That doesn't seem to be the intended action unless he is carrying the 
linux/solaris battles in his code with conditionals.  And thats 
childish.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
