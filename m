Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbRARRty>; Thu, 18 Jan 2001 12:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131124AbRARRtd>; Thu, 18 Jan 2001 12:49:33 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:25614 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S130454AbRARRta>;
	Thu, 18 Jan 2001 12:49:30 -0500
Date: Thu, 18 Jan 2001 12:49:28 -0500
From: Zach Brown <zab@zabbo.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010118124928.F8658@tetsuo.zabbo.net>
In-Reply-To: <Pine.LNX.4.30.0101181411530.823-100000@elte.hu> <Pine.LNX.4.10.10101180826370.18072-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10101180826370.18072-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jan 18, 2001 at 08:49:38AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 08:49:38AM -0800, Linus Torvalds wrote:

> That has its advantages: it's a very local thing, and doesn't need any
> state. However, the fact is that you _need_ the persistency of a socket
> option if you want to take advantage of external programs etc getting good
> behaviour without having to know that they are talking to a socket. 

*nod*

We set TCP_CORK on the socket we handed to external programs that were
being run via 'site exec' in an ftp server.  It resulted in much nicer
packets being spit out, especially in the 'ls' case where it likes to
write() on really goofy boundaries.

[yes, ftp and 'site exec' in particular are far from sexy, but do the same
with CGI scripts and the world might care :)]

- z
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
