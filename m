Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131647AbRCSWsI>; Mon, 19 Mar 2001 17:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131653AbRCSWr6>; Mon, 19 Mar 2001 17:47:58 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:7178 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131647AbRCSWrp>; Mon, 19 Mar 2001 17:47:45 -0500
Date: Mon, 19 Mar 2001 14:46:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Mike Galbraith <mikeg@wen-online.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 3rd version of R/W mmap_sem patch available
In-Reply-To: <Pine.LNX.4.33.0103192254130.1320-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0103191444420.1188-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Now the code is beautiful and it might even be bugfree ;)

I'm applying this to my tree - I'm not exactly comfortable with this
during the 2.4.x timeframe, but at the same time I'm even less comfortable
with the current alternative, which is to make the regular semaphores
fairer (we tried it once, and the implementation had problems, I'm not
going to try that again during 2.4.x).

Besides, the fair semaphores would potentially slow things down, while
this potentially speeds things up. So.. It looks obvious enough.

		Linus

