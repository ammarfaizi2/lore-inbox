Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbVINU1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbVINU1m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbVINU1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:27:41 -0400
Received: from [66.228.95.230] ([66.228.95.230]:56760 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S932580AbVINU1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:27:40 -0400
To: Peter Staubach <staubach@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
References: <78irx6wh6j.fsf@sober-counsel.permabit.com>
	<200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>
	<784q8qrsad.fsf@sober-counsel.permabit.com>
	<200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>
	<788xy2qas0.fsf@sober-counsel.permabit.com>
	<20050913183948.GE14889@dmt.cnet>
	<784q8okdfn.fsf@sober-counsel.permabit.com>
	<20050913193539.GB17222@dmt.cnet>
	<784q8oivp4.fsf@sober-counsel.permabit.com>
	<43287221.8020602@redhat.com>
	<7864t3h1xw.fsf@sober-counsel.permabit.com>
	<432884CE.9060506@redhat.com>
From: Assar <assar@permabit.com>
Date: 14 Sep 2005 16:26:11 -0400
In-Reply-To: <432884CE.9060506@redhat.com>
Message-ID: <78r7brflb0.fsf@sober-counsel.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Staubach <staubach@redhat.com> writes:
> One other thing -- it doesn't seem particularly correct to me to just
> silently truncate the symbolic link contents.

Sure, and 2.6 indeed returns ENAMETOOLONG.  I was just trying to close
the problem and not change the functionality in 2.4.  If the consensus
is that we should change it to return an error, I can certainly cook
up patches for that.
