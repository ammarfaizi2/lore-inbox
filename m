Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274372AbRIYBh4>; Mon, 24 Sep 2001 21:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274377AbRIYBhl>; Mon, 24 Sep 2001 21:37:41 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:4880 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S274372AbRIYBhZ>; Mon, 24 Sep 2001 21:37:25 -0400
Date: Mon, 24 Sep 2001 19:03:20 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Olivier Sessink <olivier@lx.student.wau.nl>
Cc: <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: weird memory related problems, negative memory usage or fake
 memory usage?
In-Reply-To: <20010924233139.A14548@fender.fakenet>
Message-ID: <Pine.LNX.4.33L.0109241900550.1864-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Andrea, please read this bugreport ...]

On Mon, 24 Sep 2001, Olivier Sessink wrote:

> after upgrade from 2.4.10pre8 to 2.4.10 I have weird problems,
> Xfree sometimes shows up with 99.9% memory in top (on a box with
> 512 mb), and in ps axl it has 4294989036 in the RSS column. When
> this happens the box starts to kill some processes, starts
> heavily swapping (top reports > 400MB in the cache, but the
> machine is heavily swapping!!!) and is completely unusable.

> Since this makes the machine completely unusable, and since it is not
> happening on 2.4.10pre8 I guess it is a bug ;-)

>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>  1262 root       5 -10 50764  -1M  1320 S <   2.7 99.9   0:01 XFree86


It seems Andrea wasn't careful with the merge and
backed out some of the locking wrt mm->rss.

Andrea, you may want to spend some time auditing
your VM like has been done with the other 2.4 VM.

cheers,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/



