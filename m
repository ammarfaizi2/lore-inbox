Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129468AbRB0CUL>; Mon, 26 Feb 2001 21:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129478AbRB0CUB>; Mon, 26 Feb 2001 21:20:01 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:4612 "HELO sh0n.net")
	by vger.kernel.org with SMTP id <S129468AbRB0CTs>;
	Mon, 26 Feb 2001 21:19:48 -0500
Message-ID: <3A9B0EBE.BBC54F1@sh0n.net>
Date: Mon, 26 Feb 2001 21:19:43 -0500
From: Shawn Starr <spstarr@sh0n.net>
Reply-To: shawn@rhua.org
Organization: sh0n.net - http://www.sh0n.net/spstarr
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mike Galbraith <mikeg@wen-online.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkm <linux-kernel@vger.kernel.org>
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: failed - Causes more then just 
 msgs
In-Reply-To: <Pine.LNX.4.21.0102260610030.5276-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It may not be an important message but what does happen is /dev/dsp becomes
hung and no sound works after the fault. So something is definately wrong.

Shawn.

Marcelo Tosatti wrote:

> On Mon, 26 Feb 2001, Alan Cox wrote:
>
> > > We can add an allocation flag (__GFP_NO_CRITICAL?) which can be used by
> > > sg_low_malloc() (and other non critical allocations) to fail previously
> > > and not print the message.
> >
> > It is just for debugging. The message can go. If anytbing it would be more
> > useful to tack Failed alloc data on the end of /proc/slabinfo
>
> The issue is not the warn message.
>
> Non critical allocations (such as this case of sg_low_malloc()) are trying
> to get additional memory to optimize things -- we want the allocator to be
> lazy and fail previously instead doing hard work. If kswapd cannot keep up
> with the memory pressure, we're surely in a memory shortage state.
>
> Its better to get out of the memory shortage instead running into OOM
> because of some optimization, I guess.
>
> Another example of such a flag is swapin readahead.

--
Hugged a Tux today? (tm)



