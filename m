Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262779AbVAKWT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVAKWT0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVAKWSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:18:31 -0500
Received: from waste.org ([216.27.176.166]:46260 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262549AbVAKWQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:16:46 -0500
Date: Tue, 11 Jan 2005 14:16:18 -0800
From: Matt Mackall <mpm@selenic.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, "Jack O'Quin" <joq@io.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111221618.GA2940@waste.org>
References: <87mzvkxxck.fsf@sulphur.joq.us> <20050110212019.GG2995@waste.org> <87d5wc9gx1.fsf@sulphur.joq.us> <20050111195010.GU2940@waste.org> <871xcr3fjc.fsf@sulphur.joq.us> <20050111200549.GW2940@waste.org> <1105475349.4295.21.camel@krustophenia.net> <20050111124707.J10567@build.pdx.osdl.net> <20050111212823.GX2940@waste.org> <20050111134251.O10567@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111134251.O10567@build.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 01:42:51PM -0800, Chris Wright wrote:
> > But I'm also still not convinced this policy can't be most flexibly
> > handled by a setuid helper together with the mlock rlimit.
> 
> Wait, why can't it be done with (to date fictitious) pam_prio, which
> simply calls sched_setscheduler?  It's already privileged while it's
> doing these things...

You certainly do not want to run everything at RT from login on.
That'd be bad.

Also, tying to UIDs rather than (UID, executable) is worrisome as
random_game_with_audio in Gnome might decide it needs RT, much to the
admin's surprise.

-- 
Mathematics is the supreme nostalgia of our time.
