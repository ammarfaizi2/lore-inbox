Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbVAKVMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbVAKVMj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVAKVLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:11:41 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:16822 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262827AbVAKVKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:10:40 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, "Jack O'Quin" <joq@io.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20050111124707.J10567@build.pdx.osdl.net>
References: <20050107134941.11cecbfc.akpm@osdl.org>
	 <20050107221059.GA17392@infradead.org>
	 <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us>
	 <20050110212019.GG2995@waste.org> <87d5wc9gx1.fsf@sulphur.joq.us>
	 <20050111195010.GU2940@waste.org> <871xcr3fjc.fsf@sulphur.joq.us>
	 <20050111200549.GW2940@waste.org>
	 <1105475349.4295.21.camel@krustophenia.net>
	 <20050111124707.J10567@build.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 16:10:33 -0500
Message-Id: <1105477833.4295.51.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 12:47 -0800, Chris Wright wrote:
> * Lee Revell (rlrevell@joe-job.com) wrote:
> > On Tue, 2005-01-11 at 12:05 -0800, Matt Mackall wrote:
> > > Anyway, *plonk*.
> > 
> > Plonk?  WTF?  Jack comes up with what many people think is a reasonable
> > solution to a real problem, that affects thousands of users, and in the
> > middle of what seems to me a civilized discussion, you killfile him
> > because he disagrees with you?
> > 
> > Plonk to you too, asshole.
> 
> Guys, could we please bring this back to a useful discussion.  None of
> you have commented on whether the rlimits for priority are useful.  As I
> said before, I've no real problem with the module as it stands since it's
> tiny, quite contained, and does something people need.  But I agree it'd
> be better to find something that's workable as long term solution.

Chris, I did comment on it, see
1105222442.24592.126.camel@krustophenia.net from around 5:15 on
Saturday.

from the above message:

Eh, PAM is a perfectly fine solution.  Documentation is lacking, but
it's easy to find examples.  On my system /etc/security/limits.conf has
this sample config, commented out:

#<domain>      <type>  <item>         <value>
#

#*               soft    core            0
#*               hard    rss             10000
#@student        hard    nproc           20
#@faculty        soft    nproc           20
#@faculty        hard    nproc           50
#ftp             hard    nproc           0

So add your audio users (or cdrecord users, or whoever) to group
realtime and add:

realtime        hard    memlock 100000
realtime        soft    prio    100

Problem solved.

Lee


