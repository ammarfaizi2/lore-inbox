Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVAKVLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVAKVLC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVAKVIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:08:47 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:64437 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262841AbVAKVHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:07:20 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Matt Mackall <mpm@selenic.com>,
       Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <87oefw3p7m.fsf@sulphur.joq.us>
References: <200501111305.j0BD58U2000483@localhost.localdomain>
	 <87oefw3p7m.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 16:07:15 -0500
Message-Id: <1105477636.4295.47.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 10:28 -0600, Jack O'Quin wrote:
> Paul Davis <paul@linuxaudiosystems.com> writes:
> 
> >>Rlimits are neither UID/GID or PAM-specific. They fit well within
> >>the general model of UNIX security, extending an existing mechanism
> >>rather than adding a completely new one. That PAM happens to be the
> >>way rlimits are usually administered may be unfortunate, yes, but it
> >>doesn't mean that rlimits is the wrong way.
> 
> PAM is how most GNU/Linux systems manage rlimits.  It is very UID/GID
> oriented.  So from the sysadmin perspective, claiming that rlimits is
> "better" or "easier to manage" than "GID hacks" is bogus.
> 

Sorry, I have to agree with Matt, let's just use PAM.  Maybe I have been
a Linux admin for too long but I don't think PAM is so bad.  Yes it
could be better documented but if this was a showstopper then no one
would use Linux at all.  It's not like every naive user will have to
figure out PAM now, the audio oriented distributions will just set it up
right by default.  And if people want to use the mainstream distros to
do audio work OOTB, they'll just have to bug their vendor about it.

> > agreed, although i note with interest the flap over RLIMIT_MEMLOCK
> > being made accessible to unprivileged users by people working on
> > grsecurity. 
> 
> :-)

But we are not talking about unprivileged users.  Do not take
"unprivileged" to mean "nonroot".  We need an easy mechanism for root to
tell the kernel 'the following users get to do things that could
potentially lock up the system'.  No general purpose Linux distro would
ship with this enabled by default for everyone.  But, to quote another
LKML thread 'you can't prevent root from doing stupid things because
that would also keep him from doing clever things'.

It's a fine line between stupid and clever.

Lee


