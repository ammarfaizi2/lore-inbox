Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVLER3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVLER3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVLER3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:29:04 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:42148
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932471AbVLER3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:29:02 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for benchmarks
Date: Mon, 5 Dec 2005 11:28:13 -0600
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Dirk Henning Gerdes <mail@dirk-gerdes.de>,
       axboe@suse.de, linux-kernel@vger.kernel.org
References: <1133443051.6110.32.camel@noti> <200512042013.13214.rob@landley.net> <1133799641.21641.14.camel@mindpipe>
In-Reply-To: <1133799641.21641.14.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512051128.13862.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 10:20, Lee Revell wrote:

> > > Caveats:
> > >
> > > a) Holds inode_lock for exorbitant amounts of time.
> >
> > Voluntary preemption point, maybe?
>
> I thin it's a bad idea, that would just encourage people to use this for
> anything other than debugging.  If you care about latency don't discard
> the page cache.
>
> The GNOME people have been asking for this for a while, in order to
> improve startup times, they would like a way to simulate a cold start
> without rebooting.

I was thinking that virtual environments (namely, User Mode Linux) could use 
this in conjunction with sys_punch to free up memory back to the host system.

> Lee

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
