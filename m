Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131277AbRBPUxV>; Fri, 16 Feb 2001 15:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131278AbRBPUxL>; Fri, 16 Feb 2001 15:53:11 -0500
Received: from [63.95.13.242] ([63.95.13.242]:17170 "EHLO
	zso-powerapp-01.zeusinc.com") by vger.kernel.org with ESMTP
	id <S131277AbRBPUxA>; Fri, 16 Feb 2001 15:53:00 -0500
Message-ID: <001f01c09859$f928dd10$25040a0a@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Andrew Morton" <andrewm@uow.edu.au>
Cc: "Gord R. Lamb" <glamb@lcis.dyndns.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.32.0102141548440.27843-100000@localhost.localdomain>,	<Pine.LNX.4.32.0102141548440.27843-100000@localhost.localdomain> <982190431.3a8b095f4b3c4@eargle.com> <3A8D3E62.98F5AD6A@uow.edu.au>
Subject: Re: Samba performance / zero-copy network I/O
Date: Fri, 16 Feb 2001 15:49:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My testing showed that the lowlatency patches abosolutely destroy a
system
> > thoughput under heavy disk IO.
>
> I'm surprised - I've been keeping an eye on that.
>
> Here's the result of a bunch of back-to-back `dbench 12' runs
> on UP, alternating with and without LL:

It's interesting that your results seem to show an improvement in
performance, while mine show a consistent drop.  My tests were not very
scientific, and I was running much higher dbench processes, 'dbench 64' or
'dbench 128', and at those levels performance with lowlatency enabled fell
though the floor on my setup.

My system is a PIII 700Mhz, Adaptec 7892 Ultra-160, software RAID1,
reiserfs, 256MB RAM.

Under lower loads, like the 'dbench 12' lowlatency only showed only a few
percent loss, but once you approached the levels around 50 things really
went downhill.

I might try to do a more complete test, maybe there's something else in my
config that would make this be a problem, but it was definately quite
noticable.

Later,
Tom


