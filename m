Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319634AbSIMM5m>; Fri, 13 Sep 2002 08:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319635AbSIMM5m>; Fri, 13 Sep 2002 08:57:42 -0400
Received: from denise.shiny.it ([194.20.232.1]:24998 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S319634AbSIMM5k>;
	Fri, 13 Sep 2002 08:57:40 -0400
Message-ID: <XFMail.20020913150221.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3D81C3EF.9509A4D0@aitel.hist.no>
Date: Fri, 13 Sep 2002 15:02:21 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: Killing/balancing processes when overcommited
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is hard to setup, and has the some weaknesses:
> 1. You worry only about apps you _know_.  But the guy who got
> his netscape or make -j killed will rename his
> copies of these apps to something else so your carefully
> set up oom killer won't know what is running.
> (How much memory is the "mybrowser" app supposed to use?)
> Or he'll get another software package that you haven't heard of.
>
> 2. Lots and lots of people running netscapes using
> only 70M each will still be too much.  Think of
> a university with xterms and then they all
> goes to cnn.com or something for the latest news
> about some large event.
>
> Even nice well-behaved apps
> is bad when there is unusually many of them. [...]

That's obvious. The point is that the sysadmin should be
able to hint the oom killer as much as possible.
The current linux/mm/oom_kill.c:badness() takes into account
many factors. The sysadmin should be able to affect the
badness calculation on process/user/something basis.



Bye.

