Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAPNse>; Tue, 16 Jan 2001 08:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRAPNsY>; Tue, 16 Jan 2001 08:48:24 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:21418 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S129406AbRAPNsM>;
	Tue, 16 Jan 2001 08:48:12 -0500
Date: Tue, 16 Jan 2001 08:47:22 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Pavel Machek <pavel@suse.cz>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <20010116001633.A3343@bug.ucw.cz>
Message-ID: <Pine.GSO.4.30.0101160845490.17392-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Jan 2001, Pavel Machek wrote:

> > TWO observations:
> > - Given Linux's non-pre-emptability of the kernel i get the feeling that
> > sendfile could starve other user space programs. Imagine trying to send a
> > 1Gig file on 10Mbps pipe in one shot.
>
> Hehe, try sigkilling process doing that transfer. Last time I tried it
> it did not work.

>From Alexey's response: it does get descheduled possibly every sndbuf
send. So you should be able to sneak that sigkill.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
