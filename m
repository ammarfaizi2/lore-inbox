Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318850AbSG0WtZ>; Sat, 27 Jul 2002 18:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318851AbSG0WtY>; Sat, 27 Jul 2002 18:49:24 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:17417 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318850AbSG0WtY>; Sat, 27 Jul 2002 18:49:24 -0400
Date: Sat, 27 Jul 2002 19:52:26 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Buddy Lumpkin <b.lumpkin@attbi.com>,
       Austin Gonyou <austin@digitalroadkill.net>,
       <vda@port.imtp.ilyichevsk.odessa.ua>,
       Ville Herva <vherva@niksula.hut.fi>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: About the need of a swap area
In-Reply-To: <1027814596.21511.5.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.0207271951150.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jul 2002, Alan Cox wrote:
> On Sat, 2002-07-27 at 23:39, Buddy Lumpkin wrote:
> > Why would you want to push *anything* to swap until you have to?
>
> To reduce the amount of disk access

> > and it's pretty relative what "long unaccessed" means ..
>
> In the Linux case the page cache is basically not discriminating too
> much about what page is (and it may be several things at once - cache,
> executing code and file data) just its access history.

There is a case to make for evicting the page cache with more
priority than process memory ...

... but frequently accessed page cache memory should definately
stay in ram, while not accessed process memory should be evicted.

I'll make a quick patch for this (for recent 2.5) today.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

