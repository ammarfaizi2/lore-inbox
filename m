Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270328AbRHMRq4>; Mon, 13 Aug 2001 13:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270331AbRHMRqq>; Mon, 13 Aug 2001 13:46:46 -0400
Received: from [193.120.224.170] ([193.120.224.170]:44929 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S270328AbRHMRq3>;
	Mon, 13 Aug 2001 13:46:29 -0400
Date: Mon, 13 Aug 2001 18:46:38 +0100 (IST)
From: Paul Jakma <paulj@alphyra.ie>
To: Nicholas Knight <tegeran@home.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: via82cxxx_audio driver bug?
In-Reply-To: <01081307194201.00276@c779218-a>
Message-ID: <Pine.LNX.4.33.0108131833300.21710-100000@dunlop.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001, Nicholas Knight wrote:

> and if they've seen XMMS or other audio applications with access to
> /dev/mixer have strange, temporarily lockups when not in root/realtime
> priority. I've yet to be able to test this with other audio applications
> besides XMMS.

yes.. i see this too with the via82cxxx_audio driver on my Tyan
AMD751+Via southbridge board.

/anything/ that accesses /dev/mixer or /dev/dsp while sound is being
played is locked. Eg, play an mp3 with xmms. while playing, xmms and
things like the gnome and WM mixer applets are all unresponsive. they
respond to UI interaction maybe only every 30 seconds or longer.

xmms with real-time priority does not suffer from this
unresponsiveness.

from the haze of my memory i think this behaviour started with the
mmap support that Jeff brought in 1.1.13 or 1.1.14. but i can't be
sure.

I've tried playing with the size of the buffers
(VIA_MAX_BUFFER_DMA_PAGES) and the _TIME and FRAG_ defines. best
result was that perioid of the unresponsiveness was reduced slightly,
but not eliminated (by reducing the buffering times and number of
fragments).

> Thanks.

regards,

--paulj

