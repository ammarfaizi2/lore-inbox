Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269515AbRHTVpG>; Mon, 20 Aug 2001 17:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269489AbRHTVos>; Mon, 20 Aug 2001 17:44:48 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:53260 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269481AbRHTVoa>; Mon, 20 Aug 2001 17:44:30 -0400
Date: Mon, 20 Aug 2001 18:44:25 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Mike Galbraith <mikeg@wen-online.de>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8/2.4.9 VM problems
In-Reply-To: <20010820213425Z16360-32383+586@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108201841400.31410-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, Daniel Phillips wrote:
> On August 20, 2001 09:12 pm, Marcelo Tosatti wrote:

> > Find riel's message with topic "VM tuning" to linux-mm, then take a look
> > at the 4th aging option.
> >
> > That one _should_ be able to make us remove all kinds of "hacks" to do
> > drop behind, and also it should keep hot/warm active memory _in cache_
> > for more time.
>
> I looked at it yesterday.  The problem is, it loses the
> information about *how* a page is used: pagecache lookup via
> readahead has different implications than actual usage.

- How is that different from your use-once thing ?
- Where do we do "pagecache lookup via readahead"
  without "actual usage" of the page ?

> The other thing that looks a little problematic, which Rik also
> pointed out, is the potential long lag before the inactive page
> is detected. A lot of IO can take place in this time, filling up
> the active list with pages that we could have evicted much
> earlier.

The lag I described to you had to do with the different
kinds of page aging used and with the time it takes for
previously "hot" pages to cool down and become inactive
pages.

I think you have things mixed up here ;)

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

