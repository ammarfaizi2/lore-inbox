Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267689AbTA1SoW>; Tue, 28 Jan 2003 13:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267690AbTA1SoW>; Tue, 28 Jan 2003 13:44:22 -0500
Received: from air-2.osdl.org ([65.172.181.6]:1247 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267689AbTA1SoV>;
	Tue, 28 Jan 2003 13:44:21 -0500
Date: Tue, 28 Jan 2003 10:47:35 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Martin Mares <mj@ucw.cz>
cc: =?iso-8859-2?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Vojtech Pavlik <vojtech@ucw.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] in drivers/char/joystick/magellan.c
In-Reply-To: <20030128175757.GA22145@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33L2.0301281045250.30636-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Martin Mares wrote:

| Hi!
|
| > Without the patch below, the \0 terminating the string is written
| > anywhere. nibbles[] would be even better, I guess.
| > Can you check for stupidity on my side?
|
| As far as I remember, the ANSI C permits initialization of a char array
| with a string of the same length and defines that the trailing \0 is
| dropped in such cases. However, I cannot quote the right chapter and
| verse by heart nor am I sure it's still permitted by C99, so better
| check yourself.

The closest that I find in a quick scan is:

ANSI/ISO/IEC 9899-1999, page 126, section 6.7.8, constraint 14:

An array of character type may be initialized by a character string
literal, optionally enclosed in braces. Successive characters of the
character string literal (including the terminating null character if
there is room or if the array is of unknown size) initialize the
elements of the array.

-- 
~Randy

