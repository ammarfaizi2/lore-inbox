Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317512AbSFRRX6>; Tue, 18 Jun 2002 13:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSFRRX6>; Tue, 18 Jun 2002 13:23:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:53257 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317512AbSFRRX4>; Tue, 18 Jun 2002 13:23:56 -0400
Date: Tue, 18 Jun 2002 14:23:37 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: David Schwartz <davids@webmaster.com>, <rml@tech9.net>, <mgix@mgix.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Question about sched_yield()
In-Reply-To: <3D0F669C.89596EC0@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44L.0206181422460.12322-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Chris Friesen wrote:

> >         It has to. What if the only task running is:
> >
> >         while(1) sched_yield();
> >
> >         What would you expect?
>
> If there is only the one task, then sure it's going to be 100% cpu on
> that task.
>
> However, if there is anything else other than the idle task that wants
> to run, then it should run until it exhausts its timeslice.
>
> One process looping on sched_yield() and another one doing calculations
> should result in almost the entire system being devoted to calculations.

So if you have a database with 20 threads yielding to each other
each time a lock is contended and one CPU hog the database should
be reduced to a very small percentage of the CPU ?

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

