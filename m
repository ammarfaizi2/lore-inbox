Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTJQNpY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 09:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTJQNpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 09:45:24 -0400
Received: from chaos.analogic.com ([204.178.40.224]:64896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263467AbTJQNpW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 09:45:22 -0400
Date: Fri, 17 Oct 2003 09:47:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Matt Mackall <mpm@selenic.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RLE (was Re: Transparent compression in the FS)
In-Reply-To: <20031016230302.GV5725@waste.org>
Message-ID: <Pine.LNX.4.53.0310170853420.2962@chaos>
References: <20031016230302.GV5725@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Oct 2003, Matt Mackall wrote:

> On Wed, Oct 15, 2003 at 01:19:09PM -0400, Richard B. Johnson wrote:
>
> > JMODEM was done in 1989 as stated. RLE was invented my ME in 1967
> > and was first used for a digital telemetry link between the Haystack
> > research facility in Groton, Mass. and MIT's main campus. I was a
> > technician there during my senior year at Northeastern. Whether or
> > not it was patented by others is immaterial.
>
> S.W. Golomb. Run-length encoding. IEEE Trans. on Information Theory,
> 12(3), July 1966.
>
> I'm sure there are earlier instances, but this is one that is commonly
> cited. I expect we can find coding theory stuff back to the at least
> the mid-40s with the formalization of regular expression theory and
> Kleene closures.
>
> --
> Matt Mackall : http://www.selenic.com : Linux development and consulting
>

Well did you actually read it or just did a keyword search? The
theory he cited definitely has its roots back with Claude Shannon
(AT&T). Dr. Golomb is Professor Emeritus at University of Southern
California. He's a well known mathematician and the developer of
many math games and puzzles.

There is a big difference between theory and "reducing to practice".
Further, RLE has become many things. When I first proposed sending
the large bunch of zeros that comprised most of the data, as some kind
of special symbol, I was laughed at because the idea was absurd. My
supervisor, who was a "moon-bounce" researcher, matter-of-factly
said; "There are no special symbols. They are all used.". My
reply was that they are not all equally probable. If we could
find a symbol (byte, in this communications link), that was very
unlikely, I could encode that symbol as a 3-byte symbol that
would be unlikely to ever have to happen.

My supervisor asked somebody else about this at the MIT campus.
The next week-end, (I worked on weekends, being a full-time
student at Northeastern) my supervisor was very, very, excited
about doing this and asked me to do the project.

This did not use CPUs. Only mainframe computers existed in those
days. Intel hadn't yet made their "traffic-light-controller" that
would become the first production CPU. So, using a "proto-board"
and a bunch of gates and registers, I made a 16-byte serial
FIFO with a hardware replacement scheme to do RLE compression
and expansion. Some MIT researchers (students) did a sort/merge
on previous data using their time-share IBM mainframe and found
that the least-likely code was 0xbb (bee-bee-hex). The method
became known  as the bee-bee method and was used even 20 years
later in disk-drives where 0xbb was still used as the token, even
though it was most certainly not optimal for disk-drive data.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


