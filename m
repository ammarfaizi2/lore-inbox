Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTKYHTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 02:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTKYHTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 02:19:33 -0500
Received: from pop.gmx.net ([213.165.64.20]:30642 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262072AbTKYHTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 02:19:32 -0500
X-Authenticated: #20450766
Date: Tue, 25 Nov 2003 08:17:21 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Bradley Chapman <kakadu_croc@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
In-Reply-To: <Pine.LNX.4.58.0311241356420.1473@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311250815200.2874-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Linus Torvalds wrote:

> On Mon, 24 Nov 2003, Guennadi Liakhovetski wrote:
> >
> > Well, FWIW, I'm getting 100% reproducible Oopses on __boot__ by enabling
> > preemption AND (almost) all kernel-hacking CONFIG_DEBUG_* options - see my
> > post of 21.11.2003 with subject "[OOPS] 2.6.0-test7 + preempt + hacking".
> > If required, could try to narrow it down to 1 CONFIG option.
>
> I'd love to have more info - I actually looked at your original report,
> and it's one of those "impossible" things as far as I can tell. The low
> bit of the work "pending" flag should acts as a lock on workqueues, and
> serialize access to one workqueue totally - so having it show up with a
> pending timer is "strange" to say the least. The only two ways to clear
> the "pending" timer is by running the work-queue - either for the timer to
> have gone off (for the delayed case) _or_ the timer not to have evern been
> set in the first place (for the immediate case).
>
> So more information would be wonderful.

SORRY. Please, inore this report. It IS 100% reproducable - if you load
wrong (compiled without debugging) modules... Maybe you should only accept
bug-reports either without modules or with CONFIG_MODVERSIONS...

Really sorry for taking your time.

Regards
Guennadi
---
Guennadi Liakhovetski


