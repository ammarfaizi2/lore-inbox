Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290730AbSA3W7k>; Wed, 30 Jan 2002 17:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290728AbSA3W73>; Wed, 30 Jan 2002 17:59:29 -0500
Received: from www.transvirtual.com ([206.14.214.140]:39176 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S290725AbSA3W6z>; Wed, 30 Jan 2002 17:58:55 -0500
Date: Wed, 30 Jan 2002 14:58:29 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Robert Love <rml@tech9.net>, Alex Khripin <akhripin@mit.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: BKL in tty code?
In-Reply-To: <20020130210127.H19292@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10201301457450.7609-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > There is probably some cleanup that is possible, but really getting the
> > thing in gear (which means no BKL, which is probably the hardest part to
> > rip out) require some level of rewrite.
> 
> I've been thinking about the serial layer, and its far from trivial.
> Unless its done right, we'll end up with a mess of locks -> deadlock.

All the locking should be moved to the upper tty layers. Why implement the
wheel over and over agin for each type of tty device.


