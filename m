Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267673AbTA1Rsk>; Tue, 28 Jan 2003 12:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267679AbTA1Rsj>; Tue, 28 Jan 2003 12:48:39 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13326 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267673AbTA1Rsi>; Tue, 28 Jan 2003 12:48:38 -0500
Date: Tue, 28 Jan 2003 18:57:57 +0100
From: Martin Mares <mj@ucw.cz>
To: =?iso-8859-2?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Vojtech Pavlik <vojtech@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] in drivers/char/joystick/magellan.c
Message-ID: <20030128175757.GA22145@atrey.karlin.mff.cuni.cz>
References: <20030128155312.GD10685@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030128155312.GD10685@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Without the patch below, the \0 terminating the string is written
> anywhere. nibbles[] would be even better, I guess.
> Can you check for stupidity on my side?

As far as I remember, the ANSI C permits initialization of a char array
with a string of the same length and defines that the trailing \0 is
dropped in such cases. However, I cannot quote the right chapter and
verse by heart nor am I sure it's still permitted by C99, so better
check yourself.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
return(EIEIO); /* Here-a-bug, There-a-bug... */
