Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268491AbRGXWGK>; Tue, 24 Jul 2001 18:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268493AbRGXWGA>; Tue, 24 Jul 2001 18:06:00 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:32526 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268491AbRGXWFk>; Tue, 24 Jul 2001 18:05:40 -0400
Date: Tue, 24 Jul 2001 19:05:36 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <Pine.LNX.4.21.0107241722310.2263-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0107241903410.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 24 Jul 2001, Marcelo Tosatti wrote:
> On Tue, 24 Jul 2001, Daniel Phillips wrote:
>
> > Today's patch tackles the use-once problem, that is, the problem of
>
> Well, as I see the patch should remove the problem where
> drop_behind() deactivates pages of a readahead window even if
> some of those pages are not "used-once" pages, right ?
>
> I just want to make sure the performance improvements you're
> seeing caused by the fix of this _particular_ problem.

Fully agreed.

Especially since it was a one-liner change from worse
performance to better performance (IIRC) it would be
nice to see exactly WHY the system behaves the way it
does.  ;)

Reading a bunch of 2Q, LRU/k, ... papers and thinking
about the problem very carefully should help us a bit
in this.  Lots of researches have already looked into
this particular problem in quite a lot of detail.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

