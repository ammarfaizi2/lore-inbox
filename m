Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130549AbRAPOme>; Tue, 16 Jan 2001 09:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130663AbRAPOmY>; Tue, 16 Jan 2001 09:42:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28681 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130549AbRAPOmU>; Tue, 16 Jan 2001 09:42:20 -0500
Date: Tue, 16 Jan 2001 15:41:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010116154116.A8213@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010116001633.A3343@bug.ucw.cz> <Pine.GSO.4.30.0101160845490.17392-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.GSO.4.30.0101160845490.17392-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Tue, Jan 16, 2001 at 08:47:22AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > TWO observations:
> > > - Given Linux's non-pre-emptability of the kernel i get the feeling that
> > > sendfile could starve other user space programs. Imagine trying to send a
> > > 1Gig file on 10Mbps pipe in one shot.
> >
> > Hehe, try sigkilling process doing that transfer. Last time I tried it
> > it did not work.
> 
> >From Alexey's response: it does get descheduled possibly every sndbuf
> send. So you should be able to sneak that sigkill.

Did you actually tried it? Last time I did the test, SIGKILL did not
make it in. sendfile did not actually check for signals...

(And you could do something like send 100MB from cache into dev
null. I do not see where sigkill could sneak in in this case.)
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
