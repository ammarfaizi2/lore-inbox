Return-Path: <linux-kernel-owner+w=401wt.eu-S1751326AbXAUS6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbXAUS6E (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 13:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbXAUS6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 13:58:04 -0500
Received: from thunk.org ([69.25.196.29]:52237 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbXAUS6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 13:58:03 -0500
Date: Sun, 21 Jan 2007 13:52:18 -0500
From: Theodore Tso <tytso@mit.edu>
To: Grzegorz =?utf-8?Q?Ja=C5=9Bkiewicz?= <gryzman@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, Johannes Stezenbach <js@linuxtv.org>,
       Joe Barr <joe@pjprimer.com>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial port blues
Message-ID: <20070121185218.GD27422@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Grzegorz =?utf-8?Q?Ja=C5=9Bkiewicz?= <gryzman@gmail.com>,
	Willy Tarreau <w@1wt.eu>, Johannes Stezenbach <js@linuxtv.org>,
	Joe Barr <joe@pjprimer.com>,
	Linux Kernel mailing List <linux-kernel@vger.kernel.org>
References: <1169242654.20402.154.camel@warthawg-desktop> <20070120173644.GY24090@1wt.eu> <20070121055456.GC27422@thunk.org> <20070121070557.GB31780@1wt.eu> <20070121140421.GA13425@linuxtv.org> <2f4958ff0701210650w4fa0138di6a5026de8a0823dc@mail.gmail.com> <20070121145817.GE31780@1wt.eu> <2f4958ff0701210710r743c1821n9af23a050c847a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f4958ff0701210710r743c1821n9af23a050c847a7@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2007 at 04:10:58PM +0100, Grzegorz Jaśkiewicz wrote:
> you're right, I used wrong term to describe.
> But the problem still exists. Nowadays it should be possible to run many
> serial ports fully accurate "at the same time". It is also true that the
> same problem exists in windows, and bsd worlds. So it is not only Linux
> problem.

It's not so much a "problem", but rather, most people aren't
particularly interested in using the millions and millions of
transisters of a modern CPU to generate a square wave.  So OS's aren't
optimized to do that.  Linux has no problems running many serial
ports; but in their normal designed function, which is to send and
receive characters, using the UART's FIFO's and interrupts to do so.  

The question of manually toggling DTR/CTS RS-232 lines to generate a
tone is something that you *can* do, but you won't be doing anything
else --- and that's simply because fundamentally that's a very silly
thing to do.  Most people will use a tiny amount of dedicated hardware
--- like the sound care that is built into every single modern PC ---
rather than manually waggling the RS-232 lines in order to generate a
tone.

> Like I said previously, 30$ board (usb+avr+max232) would do it accurately +
> over 300$ PC to control it :D funny...

You *can* do it, and we've described how to do it.  It won't be
efficient (you won't be doing much else), but that's because a PC and
Linux is optimized for different set of tasks.  Sometimes dedicated
hardware is the far superior option to a general purpose OS and a
general-purpose hardware.  This should not at all be surprising.

						- Ted
