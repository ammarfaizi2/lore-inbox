Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVAKWXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVAKWXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVAKWWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:22:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:21179 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262670AbVAKWVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:21:46 -0500
Date: Tue, 11 Jan 2005 14:21:42 -0800
From: Chris Wright <chrisw@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Chris Wright <chrisw@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111142142.Q10567@build.pdx.osdl.net>
References: <20050110212019.GG2995@waste.org> <87d5wc9gx1.fsf@sulphur.joq.us> <20050111195010.GU2940@waste.org> <871xcr3fjc.fsf@sulphur.joq.us> <20050111200549.GW2940@waste.org> <1105475349.4295.21.camel@krustophenia.net> <20050111124707.J10567@build.pdx.osdl.net> <20050111212823.GX2940@waste.org> <20050111134251.O10567@build.pdx.osdl.net> <20050111221618.GA2940@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050111221618.GA2940@waste.org>; from mpm@selenic.com on Tue, Jan 11, 2005 at 02:16:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Mackall (mpm@selenic.com) wrote:
> On Tue, Jan 11, 2005 at 01:42:51PM -0800, Chris Wright wrote:
> > > But I'm also still not convinced this policy can't be most flexibly
> > > handled by a setuid helper together with the mlock rlimit.
> > 
> > Wait, why can't it be done with (to date fictitious) pam_prio, which
> > simply calls sched_setscheduler?  It's already privileged while it's
> > doing these things...
> 
> You certainly do not want to run everything at RT from login on.
> That'd be bad.

Yup, true.

> Also, tying to UIDs rather than (UID, executable) is worrisome as
> random_game_with_audio in Gnome might decide it needs RT, much to the
> admin's surprise.

Hmm, well, the pam_limit approach has that problem.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
