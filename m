Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132740AbRDDDEB>; Tue, 3 Apr 2001 23:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132738AbRDDDDv>; Tue, 3 Apr 2001 23:03:51 -0400
Received: from mx2out.umbc.edu ([130.85.253.52]:46512 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S132740AbRDDDDh>;
	Tue, 3 Apr 2001 23:03:37 -0400
Date: Tue, 3 Apr 2001 23:02:51 -0400
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Simon Kirby <sim@netnation.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3 freeze under heavy writing + open rxvt
In-Reply-To: <20010403223222.A669@netnation.com>
Message-ID: <Pine.SGI.4.31L.02.0104032300370.2523169-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2001, Simon Kirby wrote:

> Three times now I've had 2.4.3 freeze on my dual CPU box while doing a
> "dd if=/dev/zero of=/dev/hdc bs=1024k" (a drive to be RMA'd :)).  I got
> bored and opened an rxvt, and as the machine was swapping in (I assume),
> everything froze.  The mouse still moved for about 5 seconds before the
> freeze, and the window was visible as it was attempting to start tcsh.
>
> I'm guessing that what's happening is something is waiting on a lock and
> blocking interrupts (?) for five seconds while it is swapping in, and the
> NMI lockup detector is kicking in and really breaking it.

I've noticed the same thing. I was doing a rather sadistic test, checking
a memory chip.

one window: make -j in 2.4.2 src; and in another, dd if=/dev/hda
of=/dev/null bs=4096k.

The third window was running top, and froze. A fourth window wouldn't get
past login:

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

