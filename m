Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVBNXpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVBNXpe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVBNXpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:45:34 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:51609 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261191AbVBNXpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:45:22 -0500
Subject: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001
	release)
From: Lee Revell <rlrevell@joe-job.com>
To: Roland Dreier <roland@topspin.com>
Cc: Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, Greg KH <gregkh@suse.de>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <524qge20e2.fsf@topspin.com>
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>
	 <20050211011609.GA27176@suse.de>
	 <1108354011.25912.43.camel@krustophenia.net>
	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>
	 <1108422240.28902.11.camel@krustophenia.net>  <524qge20e2.fsf@topspin.com>
Content-Type: text/plain
Date: Mon, 14 Feb 2005 18:45:20 -0500
Message-Id: <1108424720.32293.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-14 at 15:21 -0800, Roland Dreier wrote:
>     Lee> I don't see why so much effort goes into improving boot time
>     Lee> on the kernel side when the most obvious user space problem
>     Lee> is ignored.
> 
> How much of a win is it to run init scripts in parallel?  I seem to
> recall seeing tests that show that it doesn't make much difference and
> may even slow things down by causing more disk seeks as various things
> start up at the same time and cause reads of different files to get
> interleaved.
> 

This is why Windows XP reserves sapce at the beginning of the disk for
the files read during the boot process and caches copies of them there.

But, I was referring more to things like GDM not being started until all
the other init scripts are done.  Why not start it first, and let the
network initialize while the user is logging in?

> On the other hand, hotplug is an area that real profiling of real
> systems booting has identified as something that can be improved, and
> Greg's hotplug-ng seems to be a step towards a measurable improvement.

Agreed.

Lee

