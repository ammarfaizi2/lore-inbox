Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUBRK0p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 05:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbUBRK0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 05:26:45 -0500
Received: from ln33.neoplus.adsl.tpnet.pl ([83.30.25.33]:5892 "EHLO
	uran.kolkowski.no-ip.org") by vger.kernel.org with ESMTP
	id S264391AbUBRK0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 05:26:43 -0500
Date: Wed, 18 Feb 2004 11:26:13 +0100
From: Damian Kolkowski <damian@kolkowski.no-ip.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kronos <kronos@kronoz.cjb.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
Subject: Re: Radeonfb problem
Message-ID: <20040218102613.ALLYOURBASEAREBELONGTOUS.A2246@kolkowski.no-ip.org>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kronos <kronos@kronoz.cjb.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
References: <200402172008.39887.vergata@stud.fbi.fh-darmstadt.de> <20040217203604.GA19110@dreamland.darkstar.lan> <20040217211120.ALLYOURBASEAREBELONGTOUS.A8392@kolkowski.no-ip.org> <20040217213441.GA22103@dreamland.darkstar.lan> <20040217215738.ALLYOURBASEAREBELONGTOUS.B9706@kolkowski.no-ip.org> <1077056532.1076.27.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1077056532.1076.27.camel@gaston>
X-GPG-Key: 0xB2C5DE03 (http://kolkowski.no-ip.org/damian.asc x-hkp://wwwkeys.eu.pgp.net)
X-Girl: 1 will be enough!
X-Age: 24 (1980.09.27 - libra)
X-IM: JID:damian@kolkowski.no-ip.org ICQ:59367544 GG:88988
X-Operating-System: Slackware GNU/Linux, kernel 2.6.3-mm1, up 1 min
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2004-02-18 00:02]:
> Ugh ? Send me a dmesg log at boot please without any command
> line. radeonfb should set your display to the native panel size
> by default

Now I compiled 2.6.3-mm1 with new radeonfb. Clean boot without radeonfb append
sets 640x480 in 60 Hz, ok thats fine.

But..,

if I use fbset like this:

	fbset -fb /dev/fb0 -a -depth 32 1024x768-100

my CRT monitor MAG 786FD looks like ths:

|------------|
|     |      |
|  a  |      |
|     |      |
|-----|      |
|       b    |
|            |
|------------|

Where "a" is the visual screan after using fbset and "b" is my monitor.

So something is worng, besides when using higher resolution "a" fieald is
smaller then "b".

P.S. Using video=radeon:1024x768-32@100 in append is _NOT_ working for my
rv250if (radeon 9000 pro).

PP.S. Cursor is working fine on text terminal, but in graphics it's hangs when
protocol option is set to auto :-) Using "IMPS/2" works, but xterm is not
starting :-)

PPP.S. Ben please if you know tell me if fglrx works with new radeonfb without
hanging text terminal as it was in old radeonfb.

-- 
# Damian *dEiMoS* Ko³kowski # http://kolkowski.no-ip.org/ #
