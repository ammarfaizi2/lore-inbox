Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131132AbRCGSF1>; Wed, 7 Mar 2001 13:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131137AbRCGSFS>; Wed, 7 Mar 2001 13:05:18 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:33266 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131132AbRCGSFK>; Wed, 7 Mar 2001 13:05:10 -0500
Date: Wed, 7 Mar 2001 15:04:00 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Oswald Buddenhagen <ob6@inf.tu-dresden.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <20010307184000.A26594@ugly.wh8.tu-dresden.de>
Message-ID: <Pine.LNX.4.33.0103071447340.1409-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Oswald Buddenhagen wrote:

> i found, that linux is missing a static low-priority scheduling class
> (or did i miss something? in this case feel free to stomp me into the
> ground :).  it would be ideal for typical number-crunchers running in
> the background like the different distributed.net-like clients.

The problem with these things it that sometimes such a task may
hold a lock, which can prevent higher-priority tasks from running.

A solution would be to make sure that these tasks get at least one
time slice every 3 seconds or so, so they can release any locks
they might be holding and the system as a whole won't livelock.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

