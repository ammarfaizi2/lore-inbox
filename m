Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266589AbTGFCOP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 22:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266592AbTGFCOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 22:14:14 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:62868 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266589AbTGFCOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 22:14:14 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 5 Jul 2003 19:21:02 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Daniel Phillips <phillips@arcor.de>
cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
In-Reply-To: <200307060414.34827.phillips@arcor.de>
Message-ID: <Pine.LNX.4.55.0307051918310.4599@bigblue.dev.mcafeelabs.com>
References: <20030703023714.55d13934.akpm@osdl.org> <200307060010.26002.phillips@arcor.de>
 <20030706012857.GA29544@mail.jlokier.co.uk> <200307060414.34827.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jul 2003, Daniel Phillips wrote:

> On Sunday 06 July 2003 03:28, Jamie Lokier wrote:
> >
> > Your last point is most important.  At the moment, a SCHED_RR process
> > with a bug will basically lock up the machine, which is totally
> > inappropriate for a user app.
>
> How does the lockup come about?  As defined, a single SCHED_RR process could
> lock up only its own slice of CPU, as far as I can see.

They're de-queued and re-queue in the active array w/out having dynamic
priority adjustment (like POSIX states). This means that any task with
lower priority will starve if the RR task will not release the CPU.



- Davide

