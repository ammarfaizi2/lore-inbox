Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVAGQoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVAGQoY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVAGQlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:41:40 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:2282 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261507AbVAGQkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:40:33 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>
In-Reply-To: <1104761727.4192.14.camel@laptopd505.fenrus.org>
References: <1104374603.9732.32.camel@krustophenia.net>
	 <20050103140359.GA19976@infradead.org>
	 <1104761727.4192.14.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 11:40:14 -0500
Message-Id: <1105116015.20278.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[added Paul to cc:]

On Mon, 2005-01-03 at 15:15 +0100, Arjan van de Ven wrote:
> On Mon, 2005-01-03 at 14:03 +0000, Christoph Hellwig wrote:
> > On Wed, Dec 29, 2004 at 09:43:22PM -0500, Lee Revell wrote:
> > > The realtime LSM has been previously explained on this list.  Its
> > > function is to allow selected nonroot users to run RT tasks.  The most
> > > common application is low latency audio with JACK, http://jackit.sf.net.
> > > 
> > 
> > This is far too specialized.  And option to the capability LSM to grant 
> > capabilities to certain uids/gids sounds like the better choise - and
> > would also allow to get rid of the magic hugetlb uid horrors.
> those can go away anyway now that there is an rlimit to achieve the
> exact same thing.....
> 
> I can see the point of making an rlimit like thing instead for both the
> nice levels allowed and maybe the "can do rt" bit
> 

How about a "max RT prio" rlimit, that defaults to -1 (can't do RT).
Set it to 90 or something for audio users so you can still run a higher
prio watchdog thread.

Lee


