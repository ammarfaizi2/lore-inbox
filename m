Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270336AbRHNENM>; Tue, 14 Aug 2001 00:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269786AbRHNENC>; Tue, 14 Aug 2001 00:13:02 -0400
Received: from femail40.sdc1.sfba.home.com ([24.254.60.34]:43003 "EHLO
	femail40.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S270366AbRHNEMt>; Tue, 14 Aug 2001 00:12:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Paul Jakma <paulj@alphyra.ie>
Subject: Re: via82cxxx_audio driver bug?
Date: Mon, 13 Aug 2001 21:12:44 -0700
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108131833300.21710-100000@dunlop.itg.ie>
In-Reply-To: <Pine.LNX.4.33.0108131833300.21710-100000@dunlop.itg.ie>
MIME-Version: 1.0
Message-Id: <01081321124401.00204@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 August 2001 10:46 am, Paul Jakma wrote:
> On Mon, 13 Aug 2001, Nicholas Knight wrote:
> > and if they've seen XMMS or other audio applications with access to
> > /dev/mixer have strange, temporarily lockups when not in
> > root/realtime priority. I've yet to be able to test this with other
> > audio applications besides XMMS.
>
> yes.. i see this too with the via82cxxx_audio driver on my Tyan
> AMD751+Via southbridge board.
>
> /anything/ that accesses /dev/mixer or /dev/dsp while sound is being

/dev/mixer is the sole problem on my end, as long as I block XMMS's 
access to /dev/mixer (wether via permissions or pointing it to a device 
that doesn't exist), it plays out /dev/dsp alone just fine, except for 
the lack of XMMS-side volume control.

> played is locked. Eg, play an mp3 with xmms. while playing, xmms and
> things like the gnome and WM mixer applets are all unresponsive. they
> respond to UI interaction maybe only every 30 seconds or longer.

The UI in other apps is a little iffy on my end, sometimes they lock, 
sometimes not.

>
> xmms with real-time priority does not suffer from this
> unresponsiveness.
>

same here

> from the haze of my memory i think this behaviour started with the
> mmap support that Jeff brought in 1.1.13 or 1.1.14. but i can't be
> sure.

what version was in kernel 2.4.3? I first started reporting this when I 
installed Mandrake 8.0 and noticed it a couple months ago.

>
> I've tried playing with the size of the buffers
> (VIA_MAX_BUFFER_DMA_PAGES) and the _TIME and FRAG_ defines. best
> result was that perioid of the unresponsiveness was reduced slightly,
> but not eliminated (by reducing the buffering times and number of
> fragments).
>
> > Thanks.
>
> regards,
>
> --paulj
