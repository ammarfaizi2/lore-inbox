Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131579AbRAPNvo>; Tue, 16 Jan 2001 08:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131585AbRAPNve>; Tue, 16 Jan 2001 08:51:34 -0500
Received: from hera.cwi.nl ([192.16.191.1]:13736 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131579AbRAPNvW>;
	Tue, 16 Jan 2001 08:51:22 -0500
Date: Tue, 16 Jan 2001 14:50:49 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101161350.OAA141869.aeb@ark.cwi.nl>
To: mingo@elte.hu
Subject: Re: Is sendfile all that sexy?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Ingo Molnar <mingo@elte.hu>

    On Tue, 16 Jan 2001, Felix von Leitner wrote:

    > I don't know how Linux does it, but returning the first free file
    > descriptor can be implemented as O(1) operation.

    to put it more accurately: the requirement is to be able to open(), use
    and close() an unlimited number of file descriptors with O(1) overhead,
    under any allocation pattern, with only RAM limiting the number of files.
    Both of my proposals attempt to provide this. It's possible to open() O(1)
    but do a O(log(N)) close(), but that is of no practical value IMO.

        Ingo

> Both of my proposals

I am afraid I have missed most earlier messages in this thread.
However, let me remark that the problem of assigning a
file descriptor is the one that is usually described by
"priority queue". The version of Peter van Emde Boas takes
time O(loglog N) for both open() and close().
Of course this is not meant to suggest that we use it.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
