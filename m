Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130876AbQLJRc2>; Sun, 10 Dec 2000 12:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131134AbQLJRcR>; Sun, 10 Dec 2000 12:32:17 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:50695 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130876AbQLJRcB>; Sun, 10 Dec 2000 12:32:01 -0500
Date: Sun, 10 Dec 2000 17:01:21 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [patch] hotplug fixes
In-Reply-To: <Pine.LNX.4.10.10012100846170.2635-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0012101657330.25294-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000, Linus Torvalds wrote:

> All user-mode-helpers are async as of this patch.
>
> The reason for the serialization is that we need to wait until the exec()
> has taken place - so that the arguments that the caller set up haven't
> disappeared from the caller stack. The actual execution is asynchronous
> anyway.

OK, I see what's happening. But is it strictly necessary to special-case
it? If we can't use schedule_task() in all situations and hence have to
have code for doing it ourself - why not just do it ourself all the time,
keeping the code simpler?

--
dwmw2



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
