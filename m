Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131488AbRAPMnW>; Tue, 16 Jan 2001 07:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130697AbRAPMnM>; Tue, 16 Jan 2001 07:43:12 -0500
Received: from chiara.elte.hu ([157.181.150.200]:21521 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129868AbRAPMnE>;
	Tue, 16 Jan 2001 07:43:04 -0500
Date: Tue, 16 Jan 2001 13:42:37 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Felix von Leitner <leitner@convergence.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <20010116114018.A28720@convergence.de>
Message-ID: <Pine.LNX.4.30.0101161338270.947-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Jan 2001, Felix von Leitner wrote:

> I don't know how Linux does it, but returning the first free file
> descriptor can be implemented as O(1) operation.

to put it more accurately: the requirement is to be able to open(), use
and close() an unlimited number of file descriptors with O(1) overhead,
under any allocation pattern, with only RAM limiting the number of files.
Both of my proposals attempt to provide this. It's possible to open() O(1)
but do a O(log(N)) close(), but that is of no practical value IMO.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
