Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbTGFNjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 09:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTGFNjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 09:39:09 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:8900 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S262318AbTGFNjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 09:39:06 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: 2.5.74-mm1
Date: Sun, 6 Jul 2003 15:54:48 +0200
User-Agent: KMail/1.5.2
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <200307060414.34827.phillips@arcor.de> <Pine.LNX.4.55.0307051918310.4599@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0307051918310.4599@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307061554.48126.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 July 2003 04:21, Davide Libenzi wrote:
> On Sun, 6 Jul 2003, Daniel Phillips wrote:
> > On Sunday 06 July 2003 03:28, Jamie Lokier wrote:
> > > Your last point is most important.  At the moment, a SCHED_RR process
> > > with a bug will basically lock up the machine, which is totally
> > > inappropriate for a user app.
> >
> > How does the lockup come about?  As defined, a single SCHED_RR process
> > could lock up only its own slice of CPU, as far as I can see.
>
> They're de-queued and re-queue in the active array w/out having dynamic
> priority adjustment (like POSIX states). This means that any task with
> lower priority will starve if the RR task will not release the CPU.

OK, I see, I didn't pay close enough attention to the "it will be put at the 
end of the list _for its priority_" part.

So SCHED_RR is broken by design, too bad.  Now, how would SCHED_RR_NOTBROKEN 
work?

Regards,

Daniel

