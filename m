Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRBASnb>; Thu, 1 Feb 2001 13:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130866AbRBASnV>; Thu, 1 Feb 2001 13:43:21 -0500
Received: from [216.151.155.116] ([216.151.155.116]:21769 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S129242AbRBASnH>; Thu, 1 Feb 2001 13:43:07 -0500
To: Chris Evans <chris@scary.beasts.org>
Cc: Malcolm Beattie <mbeattie@sable.ox.ac.uk>, <linux-kernel@vger.kernel.org>,
        <davem@redhat.com>
Subject: Re: Serious reproducible 2.4.x kernel hang
In-Reply-To: <Pine.LNX.4.30.0102011826060.397-100000@ferret.lmh.ox.ac.uk>
From: Doug McNaught <doug@wireboard.com>
Date: 01 Feb 2001 13:41:57 -0500
In-Reply-To: Chris Evans's message of "Thu, 1 Feb 2001 18:28:45 +0000 (GMT)"
Message-ID: <m3bssmgs96.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Evans <chris@scary.beasts.org> writes:

> [cc: davem because of the severity]
> 
> On Thu, 1 Feb 2001, Malcolm Beattie wrote:
> 
> > rid of the hang. So it looks as though some combination of
> > shutdown(2) and SIGABRT is at fault. After the hang the kernel-side
> 
> Nope - I've nailed it to a _really_ simple test case. It looks like a
> read() on a shutdown() unix dgram socket just kills the kernel. Demo code
> below. I wonder if this affects UP or is SMP only?

Kills my UP K6-2 dead as a doornail (except for pings, as you say). 

-Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
