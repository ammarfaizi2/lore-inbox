Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286904AbSBCL7A>; Sun, 3 Feb 2002 06:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286925AbSBCL6u>; Sun, 3 Feb 2002 06:58:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:20153 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286904AbSBCL6f>;
	Sun, 3 Feb 2002 06:58:35 -0500
Date: Sun, 3 Feb 2002 14:56:13 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler observations
In-Reply-To: <Pine.GSO.4.33.0202010940320.12546-100000@gurney>
Message-ID: <Pine.LNX.4.33.0202031453460.10158-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 1 Feb 2002, Alastair Stevens wrote:

> Just a brief observation on the O(1) scheduler. I'm using 2.4.18-pre7
> + J7 scheduler patch (haven't had a chance to try J9 yet), on a
> bog-standard Celeron 500MHz / 384Mb / IDE desktop machine under Red
> Hat 7.2.
>
> I'm blasting along in Tuxracer (discovery of the week!) and then
> "updatedb" kicks in. Tuxracer crawls and jerks for about 15 seconds,
> and then turns wonderfully smooth again, whilst the drive continues to
> thrash a while longer.

well, CPU hogs such as Tuxracer are not as highprio as they used to be.
updatedb has a mixed CPU-intensive and IO-intensive scheduling pattern,
which gives it priority over that of Tuxracer.

One solution would be to start Tuxracer at nice -10, or to renice updatedb
to nice +19.

	Ingo

