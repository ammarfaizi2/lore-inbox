Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270779AbRHNUGD>; Tue, 14 Aug 2001 16:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270787AbRHNUFy>; Tue, 14 Aug 2001 16:05:54 -0400
Received: from pasky.ji.cz ([62.44.12.54]:35069 "HELO pasky.ji.cz")
	by vger.kernel.org with SMTP id <S270779AbRHNUFe>;
	Tue, 14 Aug 2001 16:05:34 -0400
Date: Tue, 14 Aug 2001 22:05:45 +0200
From: Petr Baudis <pasky@pasky.ji.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: WANTED: Re: VM lockup with 2.4.8 / 2.4.8pre8
Message-ID: <20010814220545.D31070@pasky.ji.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10108131229270.27903-100000@press-gopher.uchicago.edu> <Pine.LNX.4.33L.0108131451470.6118-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0108131451470.6118-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Mon, Aug 13, 2001 at 02:55:42PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why we are giving so big importance to root processes? Yes, they are
important, but they are even more likely to flood our memory, because
limits don't apply to them. I propose to just divide their badness
by 2, not by 4.

I also propose to half badness of processes with pid < 1000 - those
processes are usually also important, because they are called during
boot-time and they usually handle important system affairs. And
because most of them are run by root, the previous behaviour will
be restored, but with giving less badness to some non-root important
processes, and more badness to later-run root processes, which are
often less important.

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
