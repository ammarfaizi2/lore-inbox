Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVBOJde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVBOJde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 04:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVBOJde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 04:33:34 -0500
Received: from gate.firmix.at ([80.109.18.208]:62938 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S261661AbVBOJdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 04:33:25 -0500
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
In-Reply-To: <4211B8FC.8000600@aitel.hist.no>
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>
	 <20050211011609.GA27176@suse.de>
	 <1108354011.25912.43.camel@krustophenia.net>
	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>
	 <1108422240.28902.11.camel@krustophenia.net> <524qge20e2.fsf@topspin.com>
	 <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com>
	 <1108430245.32293.16.camel@krustophenia.net>
	 <4B923A81-7EF3-11D9-86CC-000393ACC76E@mac.com>
	 <4211B8FC.8000600@aitel.hist.no>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1108459982.438.9.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Tue, 15 Feb 2005 10:33:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 09:55 +0100, Helge Hafting wrote:
[...]
> The init-script dependencies are specifies already - at least on debian.

These are not dependencies but "only" the sequence of startup (and it is
not only Debian but also Fedora/RedHat, SuSE, Mandrake and probably all
except Gentoo).
Yuo get a much stricter ordering and sorting (and thus much simpler to
implement in a shell script).

> Look at the most used runlevel, ls /etc/rc2.d:
> 
> S10sysklogd@
> S11klogd
> S14ppp
> S18portmap
> S19slapd
> S20alsa
> S20cupsys
> S20dhcp3-server
> S20exim
> ...
> The numbers specify ordering constraint, low numbers must start before 
> high numbers.
> But plenty of scripts have no interdependencies, I have 18 scripts 
> numbered S20.

This would be a win (especially if the numbers are tweked to tune this)
with a relatively small effort.
However for real dependencies and parallelism you want the info similar
to creat a Makefile from it (i.e. the explicit dependency from service X
to service Y). As a consequence you can get rid of the numbers (since
they are not needed any more).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

