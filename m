Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272838AbRIQPgC>; Mon, 17 Sep 2001 11:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273643AbRIQPfv>; Mon, 17 Sep 2001 11:35:51 -0400
Received: from ns.ithnet.com ([217.64.64.10]:55314 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272838AbRIQPfj>;
	Mon, 17 Sep 2001 11:35:39 -0400
Date: Mon, 17 Sep 2001 17:35:55 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: ast@domdv.de, linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-Id: <20010917173555.460c8ea3.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0109161509300.915-100000@penguin.transmeta.com>
In-Reply-To: <200109162159.XAA11989@webserver.ithnet.com>
	<Pine.LNX.4.33.0109161509300.915-100000@penguin.transmeta.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001 15:14:22 -0700 (PDT) Linus Torvalds
<torvalds@transmeta.com> wrote:

> > Very willing. Just send it to me, please.
> 
> It's there as 2.4.10pre10, on ftp.kernel.org under "testing" now.
> 
> However, note that it hasn't gotten any "tweaking", ie there's none of the
> small changes that aging differences usually tend to need. I'm hoping
> that's ok, as the new behaviour shouldn't be that different from the old
> behaviour in most cases, and that the biggest differences _should_ be just
> proper once-use things.
> 
> But it would be interesting to hear which loads show markedly worse/better
> behaviour. If any.

Hello,

I tried my usual test setup today with 2.4.10-pre10 and experienced the
following:

- cpu load goes pretty high (11-12 according to xosview)during several
occasions, upto the point where you cannot even move the mouse. Compared to an
once tested ac-version it is not _that_ nice. I have some problems cat'ing
/proc/meminfo, too. I takes sometimes pretty long (minutes).

- the meminfo shows me great difference to former versions in the balancing of
inact_dirty and active. This pre10 tends to have a _lot_ more inact_dirty pages
than active (compared to pre9 and before) in my test. I guess this is intended
by this (used-once) patch. So take this as a hint, that your work performs as
expected.

- of course the alloc problems itself stayed the same.

Regards,
Stephan


