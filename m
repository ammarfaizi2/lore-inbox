Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270746AbRHNTBN>; Tue, 14 Aug 2001 15:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270747AbRHNTBD>; Tue, 14 Aug 2001 15:01:03 -0400
Received: from pasky.ji.cz ([62.44.12.54]:30460 "HELO pasky.ji.cz")
	by vger.kernel.org with SMTP id <S270746AbRHNTA7>;
	Tue, 14 Aug 2001 15:00:59 -0400
Date: Tue, 14 Aug 2001 21:01:11 +0200
From: Petr Baudis <pasky@pasky.ji.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio driver bug?
Message-ID: <20010814210111.B29803@pasky.ji.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010814184654Z270673-760+1634@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108131833300.21710-100000@dunlop.itg.ie>; from paulj@alphyra.ie on Mon, Aug 13, 2001 at 06:46:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > and if they've seen XMMS or other audio applications with access to
> > /dev/mixer have strange, temporarily lockups when not in root/realtime
> > priority. I've yet to be able to test this with other audio applications
> > besides XMMS.
> 
> yes.. i see this too with the via82cxxx_audio driver on my Tyan
> AMD751+Via southbridge board.
> 
> /anything/ that accesses /dev/mixer or /dev/dsp while sound is being
> played is locked. Eg, play an mp3 with xmms. while playing, xmms and
> things like the gnome and WM mixer applets are all unresponsive. they
> respond to UI interaction maybe only every 30 seconds or longer.
> 
> xmms with real-time priority does not suffer from this
> unresponsiveness.

This bug was reported before some time even on sourceforge, where this
driver is developed.

It happens even when running silly volume adjusting console program
(http://pasky.ji.cz/~pasky/cp/volume.c) - try to strace it, it hangs
in depth of the ioctl()s called - but it happens only when you are
actually playing something also.

-- 

				Petr "Pasky" Baudis
.                                                                       .
#define BITCOUNT(x)     (((BX_(x)+(BX_(x)>>4)) & 0x0F0F0F0F) % 255)
#define  BX_(x)         ((x) - (((x)>>1)&0x77777777)                    \
                             - (((x)>>2)&0x33333333)                    \
                             - (((x)>>3)&0x11111111))
             -- really weird C code to count the number of bits in a word
.                                                                       .
My public PGP key is on: http://pasky.ji.cz/~pasky/pubkey.txt
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS d- s++:++ a--- C+++ UL++++$ P+ L+++ E--- W+ N !o K- w-- !O M-
!V PS+ !PE Y+ PGP+>++ t+ 5 X(+) R++ tv- b+ DI(+) D+ G e-> h! r% y?
------END GEEK CODE BLOCK------
