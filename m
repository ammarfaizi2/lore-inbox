Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318158AbSHDLoQ>; Sun, 4 Aug 2002 07:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318159AbSHDLoQ>; Sun, 4 Aug 2002 07:44:16 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:39428 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318158AbSHDLoQ>;
	Sun, 4 Aug 2002 07:44:16 -0400
Date: Sat, 3 Aug 2002 22:50:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 10: 2.5.29-wdt977
Message-ID: <20020803225053.A1515@mars.ravnborg.org>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <E17b3Rq-0006wh-00@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17b3Rq-0006wh-00@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Aug 03, 2002 at 07:16:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2002 at 07:16:18PM +0100, Russell King wrote:
> Bitops are used with on the timer_alive variable.  Therefore, timer_alive
> needs to be "unsigned long" not "int".

How about:
> -static	int timer_alive;
> +static	bitmap_member(timer_alive, 1);

In this way it is obviously used for bitops.

Rusty's more informative DECLARE_BITMAP (IIRC) patch has not yet been 
accepted by Linus, otherwise it would better tell people that this is 
actually a macro without the need to parse the declaration first.

	Sam

