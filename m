Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131227AbRCTWbR>; Tue, 20 Mar 2001 17:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131228AbRCTWbH>; Tue, 20 Mar 2001 17:31:07 -0500
Received: from saarinen.org ([203.79.82.14]:23978 "EHLO vimfuego.saarinen.org")
	by vger.kernel.org with ESMTP id <S131227AbRCTWa5>;
	Tue, 20 Mar 2001 17:30:57 -0500
From: "Juha Saarinen" <juha@saarinen.org>
To: "Rik van Riel" <riel@conectiva.com.br>, "Josh Grebe" <squash@primary.net>
Cc: "Jan Harkes" <jaharkes@cs.cmu.edu>, <linux-kernel@vger.kernel.org>
Subject: RE: Question about memory usage in 2.4 vs 2.2
Date: Wed, 21 Mar 2001 10:29:31 +1200
Message-ID: <LNBBIBDBFFCDPLBLLLHFEEAIJIAA.juha@saarinen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <Pine.LNX.4.21.0103201857170.3750-100000@imladris.rielhome.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:: > And can this behavior be tuned so that it uses less of the overall
:: > memory?
::
:: This isn't currently possible. Also, I suspect what we really want
:: for most situations is a way to better balance between the different
:: uses of memory.  Again, patches are welcome (I haven't figured out a
:: way to take care of this balancing yet ... maybe we DO want some way
:: of limiting memory usage of each subsystem??).

man ulimit? ;-)

On a more serious note, is there a way to find out what has been paged out
to disk, and also limit what can be paged out?

I could be wrong, but for instance I leave X running for a while (not sure
about the timing here but let's say several hours), and come back and log in
again, it is very slow to "come alive". The screen redraws slowly, and
there's quite a bit of disk access. This only happens if the system is left
alone for a long period of time (no, I don't have APM running on it).

Squid behaves the same -- the first access after a long period of inactivity
causes a lot of disk grinding, but successive accesses are fine.

Don't see this behaviour with the 2.2.x kernels.


-- Juha

