Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131725AbRCTGPB>; Tue, 20 Mar 2001 01:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131726AbRCTGOv>; Tue, 20 Mar 2001 01:14:51 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:36362 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131725AbRCTGOi>; Tue, 20 Mar 2001 01:14:38 -0500
Date: Tue, 20 Mar 2001 01:29:48 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Mike Galbraith <mikeg@wen-online.de>,
        linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: 3rd version of R/W mmap_sem patch available
In-Reply-To: <Pine.LNX.4.31.0103192206030.1025-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0103200125480.8873-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Mar 2001, Linus Torvalds wrote:

> 
> 
> On Tue, 20 Mar 2001, Marcelo Tosatti wrote:
> >
> > Could the IDE one cause corruption ?
> 
> Only with broken disks, as far as we know right now. There's been so far
> just one report of this problem, and nobody has heard back about which
> disk this was.. And it should be noisy about it when it happens -
> complaining about lost interrupts and resetting the IDE controller.
> 
> So unlikely.

Ok, so I think we have a problem. The disk is OK -- no lost interrupts or
resets. Just this message on syslog and pgbench complaining about
corruption of the database.

I'll put pre5 in and try to reproduce the problem (I hitted it while
running pgbench + shmtest). 

Damn. 

