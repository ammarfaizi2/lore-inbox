Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVBONvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVBONvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 08:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVBONvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 08:51:20 -0500
Received: from gate.firmix.at ([80.109.18.208]:57053 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S261722AbVBONvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 08:51:15 -0500
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001
	release)
From: Bernd Petrovitsch <bernd@firmix.at>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Lee Revell <rlrevell@joe-job.com>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>,
       Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-hotplug-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Roland Dreier <roland@topspin.com>
In-Reply-To: <4211F706.4030104@aitel.hist.no>
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>
	 <20050211011609.GA27176@suse.de>
	 <1108354011.25912.43.camel@krustophenia.net>
	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>
	 <1108422240.28902.11.camel@krustophenia.net> <524qge20e2.fsf@topspin.com>
	 <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com>
	 <1108430245.32293.16.camel@krustophenia.net>
	 <4B923A81-7EF3-11D9-86CC-000393ACC76E@mac.com>
	 <4211B8FC.8000600@aitel.hist.no> <1108459982.438.9.camel@tara.firmix.at>
	 <4211F706.4030104@aitel.hist.no>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1108475448.19030.7.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Tue, 15 Feb 2005 14:50:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 14:20 +0100, Helge Hafting wrote:
> Bernd Petrovitsch wrote:
> >On Tue, 2005-02-15 at 09:55 +0100, Helge Hafting wrote:
[...]
> >These are not dependencies but "only" the sequence of startup (and it is
> >not only Debian but also Fedora/RedHat, SuSE, Mandrake and probably all
> >except Gentoo).
> >  
> Yes, it is a sequence.  It it derived from real dependencies though,
> where nondependent stuff have the same number.

Yes, of course. Sorry if that wasn't clear.

> >However for real dependencies and parallelism you want the info similar
> >to creat a Makefile from it (i.e. the explicit dependency from service X
> >to service Y). As a consequence you can get rid of the numbers (since
> >they are not needed any more).
> >  
> Now that is a really good idea.  Init could simply run "make -j init2" to

Actually I just used it to illustrate the idea.
As with Gentoo, I'm not a guru there so other people must comment if
Gentoo actually starts services in parallel.

> enter runlevel 2.  A suitable makefile would list all dependencies, and
> of course the targets needed for "init2", "init3" and so on.
> 
> It might not be that much work either.  Parallel make exists already, 
> and the
> first attempt at a makefile could simply implement the current sequence that
> is known to work. Then the tweaking comes. :-)

You just have to cope with the potentially parallel output reliably
especially in error cases (which is IMHO basically the most work).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

