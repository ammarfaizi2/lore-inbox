Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130442AbQKAQUS>; Wed, 1 Nov 2000 11:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130484AbQKAQUI>; Wed, 1 Nov 2000 11:20:08 -0500
Received: from gatekeeper.trcinc.com ([208.224.120.226]:31738 "HELO gatekeeper")
	by vger.kernel.org with SMTP id <S130442AbQKAQTz>;
	Wed, 1 Nov 2000 11:19:55 -0500
Message-ID: <790BC7A85246D41195770000D11C56F21C847C@trc-tpaexc01.trcinc.com>
From: Jonathan George <Jonathan.George@trcinc.com>
To: "'Rik van Riel'" <riel@conectiva.com.br>,
        Jonathan George <Jonathan.George@trcinc.com>
Cc: "'matthew@mattshouse.com'" <matthew@mattshouse.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.0-test10 Sluggish After Load
Date: Wed, 1 Nov 2000 11:18:44 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Rik van Riel [mailto:riel@conectiva.com.br]
Sent: Wednesday, November 01, 2000 11:06 AM
To: Jonathan George
Cc: 'matthew@mattshouse.com'; 'linux-kernel@vger.kernel.org'
Subject: RE: 2.4.0-test10 Sluggish After Load


On Wed, 1 Nov 2000, Jonathan George wrote:

> It might be helpful to show the current (post crippled) results
> of top. Futhermore, a list of allocated ipc resources (share
> memory, etc.) and open files (lsof) would be nice.

The problem may well be that Oracle wants to clean up
all memory at once, accessing much more memory than
it did while under stress with more tricky access
patterns.
<SNIP>
If this looks bad to you, compare the points where 2.2
starts thrashing and where 2.4 starts thrashing. You'll
most likely (there must be a few corner cases where 2.2
does better ;)) see that 2.4 still runs fine where 2.2
performance has already "degraded heavily" and that 2.2
has "hit the wall" before 2.4 does so ... the difference
just is that 2.4 hits the wall more suddenly ;)

regards,

Rik
---------------

It sounded to me as if his machine never actually recovered from thrashing.
Futhermore, even a thrashing case on a machine like that shouldn't last for
more than about 10 minutes.  It would be interesting to contrast FreeBSD's
behavior if "simple" cleanup was the problem.  BTW, I think that everyone is
happy with the direction of the new VM.  I'm looking forward to your
upcoming enhancements which I hope will make it in to a later 2.4 release.

--Jonathan--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
