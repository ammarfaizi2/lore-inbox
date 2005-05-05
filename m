Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVEEWEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVEEWEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 18:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVEEWE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 18:04:28 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:53687 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261961AbVEEWEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 18:04:24 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Scheduler: SIGSTOP on multi threaded processes
Date: Thu, 5 May 2005 22:04:23 +0000 (UTC)
Organization: Cistron
Message-ID: <d5e597$jok$1@news.cistron.nl>
References: <4279084C.9030908@free.fr> <20050504191604.GA29730@nevyn.them.org> <Pine.LNX.4.61.0505042031120.22323@chaos.analogic.com> <Pine.LNX.4.61.0505050814340.24130@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1115330663 20244 194.109.0.112 (5 May 2005 22:04:23 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.61.0505050814340.24130@chaos.analogic.com>,
Richard B. Johnson <linux-os@analogic.com> wrote:
>
>I don't think the kernel handler gets a chance to do anything
>because SYS-V init installs its own handler(s). There are comments
>about Linux misbehavior in the code. It turns out that I was
>right about SIGSTOP and SIGCONT...

No, you're confused. Sysvinit catches SIGTSTP and SIGCONT (not SIGSTOP)
because pid #1 is special - unlike all other processes, SIG_DFL for
pid #1 is equal to SIG_IGN.

And remember - signal handlers are not inherited (how could they be..)
so there is no such thing as "init installing a signal handler
for all processes".

Right now you should go out and buy a copy of the Stevens book,
"Advanced programming in the Unix enviroment", and study it.

Mike.

