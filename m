Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130067AbRARRFv>; Thu, 18 Jan 2001 12:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130073AbRARRFm>; Thu, 18 Jan 2001 12:05:42 -0500
Received: from chiara.elte.hu ([157.181.150.200]:18707 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130067AbRARRFd>;
	Thu, 18 Jan 2001 12:05:33 -0500
Date: Thu, 18 Jan 2001 18:04:56 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rick Jones <raj@cup.hp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.10.10101180850290.18072-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101181801150.7062-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Jan 2001, Linus Torvalds wrote:

> Yeah, and how are you going to teach a perl CGI script that writes to
> stdout to use it?

yep, correct. But you can have TCP_CORK behavior from user-space (by
setting the cork flag in user-space and writing it for all network
output), while you cannot have MSG_MORE in the TCP_CORK case. And a perl
script will likely use none of these mechanizms, it's the webserver CGI
host code that does the network send, perl CGI scripts do not send to the
network directly, they send to a pipe so the CGI host code can have
absolute control over eg. CGI-generated HTTP headers.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
