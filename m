Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbSIRQlu>; Wed, 18 Sep 2002 12:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267450AbSIRQlu>; Wed, 18 Sep 2002 12:41:50 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39949 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267441AbSIRQlt>; Wed, 18 Sep 2002 12:41:49 -0400
Date: Wed, 18 Sep 2002 13:46:38 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44.0209180906460.1913-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0209181345320.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, Linus Torvalds wrote:

> Give me one reason for why these two added lines aren't better than all
> the complexity we've discussed?

On second thought ... yes there's a reason.  Suppose you have
100000 threads on your box already, how long is it going to
take to walk them all to figure out the pid distribution ?

And are you willing to walk 100000 threads for every 16 pids allocated ?

Rik
-- 
Spamtrap of the month: september@surriel.com

http://www.surriel.com/		http://distro.conectiva.com/

