Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130913AbQJ1GTl>; Sat, 28 Oct 2000 02:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131029AbQJ1GTb>; Sat, 28 Oct 2000 02:19:31 -0400
Received: from pop.gmx.net ([194.221.183.20]:31415 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S130913AbQJ1GTV>;
	Sat, 28 Oct 2000 02:19:21 -0400
Message-ID: <39FA7052.9C11541@gmx.net>
Date: Sat, 28 Oct 2000 08:21:06 +0200
From: Marko Macek <Marko.Macek@gmx.net>
Reply-To: Marko.Macek@gmx.net
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Simon Kirby <sim@stormix.com>
Subject: Re: kqueue microbenchmark resul
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>In fact, if you did leave the read queued in a daemon using select()
>before, you'd keep looping endlessly taking all CPU and never idle
>because there would always be read data available.

Also, level triggered notifications would also seem to cause
multiple thread wakeups and thundering herd problems when
there are multiple worker threads reading from the same queue.

How does (?) kevent avoid this from happening?

Mark

--
... recursive make suxx!
------------------------------------------------------------------------
Marko.Macek@gmx.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
