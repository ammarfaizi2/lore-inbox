Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbQJaUFb>; Tue, 31 Oct 2000 15:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129074AbQJaUFV>; Tue, 31 Oct 2000 15:05:21 -0500
Received: from [194.213.32.137] ([194.213.32.137]:6916 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129033AbQJaUFI>;
	Tue, 31 Oct 2000 15:05:08 -0500
Message-ID: <20001031195940.B138@bug.ucw.cz>
Date: Tue, 31 Oct 2000 19:59:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dan Hollis <goemon@anime.net>, Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030184109.C21935@athlon.random> <Pine.LNX.4.21.0010301110450.12201-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0010301110450.12201-100000@anime.net>; from Dan Hollis on Mon, Oct 30, 2000 at 11:11:52AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > TUX modules are kernel modules (I mean you have to write kernel space code for
> > doing TUX ftp). Don't you agree that zero-copy sendfile like ftp serving would
> > be able to perform equally well too?
> 
> For this to bw useful for ftp we need a sendfile() that can write from a
> socket to a diskfile also.

I had patch to fix sendfile this way... Sendfile is really ugly, as of
now. (It basically falled back to read/write, giving only small
performance advantage, but it made things cleaner).

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
