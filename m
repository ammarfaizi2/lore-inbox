Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289228AbSA3XOu>; Wed, 30 Jan 2002 18:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289293AbSA3XOk>; Wed, 30 Jan 2002 18:14:40 -0500
Received: from www.transvirtual.com ([206.14.214.140]:54024 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S289228AbSA3XO3>; Wed, 30 Jan 2002 18:14:29 -0500
Date: Wed, 30 Jan 2002 15:14:04 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Robert Love <rml@tech9.net>, Alex Khripin <akhripin@mit.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: BKL in tty code?
In-Reply-To: <20020130230532.I19292@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10201301510510.7609-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Jan 30, 2002 at 02:58:29PM -0800, James Simmons wrote:
> > All the locking should be moved to the upper tty layers. Why implement the
> > wheel over and over agin for each type of tty device.
> 
> By that statement, I can see that you haven't really done any analysis of
> the tty nor serial locking.  Its not a simple case of "just add a per tty
> semaphore in the tty layer and everything will be fine".

I have to say no. I have been to busy cleaning up the fbdev layer right
now. What I have done is work on a way to haev each console device have
its own lock and then share that with struct tty_driver to protect
hardware access. This is just the first step. I knew the tty layer would
require more than just that. Since I haven't had time to look at all the
details I'm curious to what you have discovered. I still believe that
locking could be moved to the upper layer tho. I don't see why not.   

