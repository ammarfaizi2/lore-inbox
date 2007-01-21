Return-Path: <linux-kernel-owner+w=401wt.eu-S1750783AbXAUO7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbXAUO7p (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 09:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750696AbXAUO7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 09:59:45 -0500
Received: from 1wt.eu ([62.212.114.60]:2117 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783AbXAUO7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 09:59:44 -0500
Date: Sun, 21 Jan 2007 15:58:17 +0100
From: Willy Tarreau <w@1wt.eu>
To: Grzegorz Ja?kiewicz <gryzman@gmail.com>
Cc: Johannes Stezenbach <js@linuxtv.org>, Theodore Tso <tytso@mit.edu>,
       Joe Barr <joe@pjprimer.com>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial port blues
Message-ID: <20070121145817.GE31780@1wt.eu>
References: <1169242654.20402.154.camel@warthawg-desktop> <20070120173644.GY24090@1wt.eu> <20070121055456.GC27422@thunk.org> <20070121070557.GB31780@1wt.eu> <20070121140421.GA13425@linuxtv.org> <2f4958ff0701210650w4fa0138di6a5026de8a0823dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4958ff0701210650w4fa0138di6a5026de8a0823dc@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2007 at 03:50:32PM +0100, Grzegorz Ja?kiewicz wrote:
> funny, how even very fast box can be useless for such activities with modern
> kernels, such as linux. After all, serial ports don't require too much
> horsepower to be highly accurate.
> >From designer perspective, I would rather go for uC solution in his case.
> That is, design and build fairly simple board - based on atmega AVRs. 16mhz
> 8bit chip can do so much better compared to N gigs mhz box running "modern"
> operating system, these days....

It is true, but the point is not "modern" vs "ancient" OS, it's "multitasking"
vs "monotasking" kernel. If your program does the busy loop, you'll get a
very high accuracy at the expense of burning watts polling one bit one
billion times a second waiting for a change every millisecond.

18 years ago, I wrote a soft-only 8250 emulator to connect my second 8088
to the first one's serial port at 19200 bauds. At this time, waiting for
a change only took a few hundred cycles and the busy loop was the default
mode of the OS anyway. Things have changed since.

Willy

