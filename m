Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267690AbTA1Uyw>; Tue, 28 Jan 2003 15:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267691AbTA1Uyv>; Tue, 28 Jan 2003 15:54:51 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:4015 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267690AbTA1Uyu>;
	Tue, 28 Jan 2003 15:54:50 -0500
Date: Tue, 28 Jan 2003 22:03:53 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Martin Mares <mj@ucw.cz>,
       =?iso-8859-2?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] in drivers/char/joystick/magellan.c
Message-ID: <20030128220353.A2892@ucw.cz>
References: <20030128175757.GA22145@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33L2.0301281045250.30636-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L2.0301281045250.30636-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Tue, Jan 28, 2003 at 10:47:35AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 10:47:35AM -0800, Randy.Dunlap wrote:
> On Tue, 28 Jan 2003, Martin Mares wrote:
> 
> | Hi!
> |
> | > Without the patch below, the \0 terminating the string is written
> | > anywhere. nibbles[] would be even better, I guess.
> | > Can you check for stupidity on my side?
> |
> | As far as I remember, the ANSI C permits initialization of a char array
> | with a string of the same length and defines that the trailing \0 is
> | dropped in such cases. However, I cannot quote the right chapter and
> | verse by heart nor am I sure it's still permitted by C99, so better
> | check yourself.
> 
> The closest that I find in a quick scan is:
> 
> ANSI/ISO/IEC 9899-1999, page 126, section 6.7.8, constraint 14:
> 
> An array of character type may be initialized by a character string
> literal, optionally enclosed in braces. Successive characters of the
> character string literal (including the terminating null character if
> there is room or if the array is of unknown size) initialize the
> elements of the array.

Which means it was OK.

-- 
Vojtech Pavlik
SuSE Labs
