Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290237AbSA3Rp1>; Wed, 30 Jan 2002 12:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289987AbSA3RoB>; Wed, 30 Jan 2002 12:44:01 -0500
Received: from mustard.heime.net ([194.234.65.222]:485 "EHLO mustard.heime.net")
	by vger.kernel.org with ESMTP id <S290054AbSA3RnG>;
	Wed, 30 Jan 2002 12:43:06 -0500
Date: Wed, 30 Jan 2002 18:42:38 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>, Knut Olav Boehmer <knuto@linpro.no>,
        Frank Ronny Larsen <gobo@gimle.nu>
Subject: still problems with heavy i/o load
Message-ID: <Pine.LNX.4.30.0201301825470.31732-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I don't know what this might be, but still, now on -rmap12a, i get the
following behaviour:

* streaming starts
* speed is initially >40MB/s
* when cache is used up, it falls to ~30MB/s - then (after a while) down
  to ~25MB/s
* then down to 0, which might show the wget processes on the remote
  computer should be finished, but they aren't. They (59 of the original
  100) are in Sleeping state. The server won't push more data.

This problem is _not_ rmap specific, as mentioned in
http://karlsbakk.net/dev/kernel/vm-fsckup.txt. With 2.4.17-vanilla, the
data transfer halts after reading 2xRAM bytes.

strangely, rmap11c seems to be quite stable, but only gives me ~32MB/s,
whereas the initial is close to 50.

I have posted mesages about this bug so many times now, that I really soon
will try to install CP/M or something. At least a stable system!

And - yes! - I have tried Andrea's patches. The only fscking thing that
seems to be close to solving it is rmap11c

Please help me about this

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

