Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293439AbSBZB7x>; Mon, 25 Feb 2002 20:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293464AbSBZB7o>; Mon, 25 Feb 2002 20:59:44 -0500
Received: from unthought.net ([212.97.129.24]:35263 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S293439AbSBZB7c>;
	Mon, 25 Feb 2002 20:59:32 -0500
Date: Tue, 26 Feb 2002 02:59:31 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Christer Weinigel <wingel@acolyte.hack.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
Message-ID: <20020226025931.M28035@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Christer Weinigel <wingel@acolyte.hack.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0202251413100.11464-100000@dragon.pdx.osdl.net> <20020226012245.95555F5B@acolyte.hack.org> <20020226013735.0D309F5B@acolyte.hack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20020226013735.0D309F5B@acolyte.hack.org>; from wingel@acolyte.hack.org on Tue, Feb 26, 2002 at 02:37:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 02:37:35AM +0100, Christer Weinigel wrote:
> Hi,
> 
> this is a patch trying to document the Watchdog API in the kernel.
> I'd suggest that it gets into the mainline kernel so that people read
> it and (hopefully) also update it.

Great !

...
> +
> +Some parts of this document are copied verbatim from the sbc60xxwdt
> +driver which is (c) Copyright 2000 Jakob Oestergaard <jakob@ostenfeld.dk>

My e-mail address now is:  jakob@unthought.net

....
> +A Watchdog Timer (WDT) is a hardware circuit that can reset the
> +computer system in case of a software fault.  You probably knew that
> +already.

Hardware faults such as memory corruption (leading to software malfunction)
are included as well   :)

> +Usually a userspace daemon will notify the kernel watchdog driver via the
> +/dev/watchdog special device file that userspace is still alive, at
> +regular intervals.  When such a notification occurs, the driver will
> +usually tell the hardware watchdog that everything is in order, and
> +that the watchdog should wait for yet another little while to reset
> +the system.  If userspace fails (RAM error, kernel bug, whatever), the
> +notifications cease to occur, and the hardware watchdog will reset the
> +system (causing a reboot) after the timeout occurs.

Exactly.

...
> +A more advanced driver could for example check that a HTTP server is
> +still responding before doing the write call to ping the watchdog.

I think that's a bad example - you would start httpd from init if it was that
critical, or use a monitoring system, or something...  Spontaneously booting
the machine because the admin made an error in httpd.conf seems a little
impractical  :)   Especially because it will keep on re-booting, until someone
starts it in single-user mode and fixes the httpd config...

...

A very nice document !   Some day, someone ought to standardize the way
that /dev/watchdog is used...  Some other day I presume   :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
