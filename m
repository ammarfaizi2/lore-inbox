Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277524AbRJOMf0>; Mon, 15 Oct 2001 08:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277527AbRJOMfQ>; Mon, 15 Oct 2001 08:35:16 -0400
Received: from pcephc56.cern.ch ([137.138.38.92]:55680 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S277519AbRJOMe4>; Mon, 15 Oct 2001 08:34:56 -0400
Date: Mon, 15 Oct 2001 14:34:29 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Jelson <jelson@circlemud.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] FUSD v1.00: Framework for User-Space Devices
Message-ID: <20011015143429.F4269@kushida.jlokier.co.uk>
In-Reply-To: <20011002204836.B3026@bug.ucw.cz> <200110022237.f92Mbrk28387@cambot.lecs.cs.ucla.edu> <20011005205136.A1272@elf.ucw.cz> <m1n132x4qg.fsf@frodo.biederman.org> <20011008122013.B38@toy.ucw.cz> <m1wv1zqk37.fsf@frodo.biederman.org> <20011014081233.A31752@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011014081233.A31752@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Sun, Oct 14, 2001 at 08:12:34AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > Additionally you still don't need a FUSD driver for that case.  All
> > you need is to have is a ptty.  Because that is what modem drivers
> > are now.  And the ptty route has binary and source compatiblity
> > to multiple unix platforms.
> 
> I do not think tty/pty pair does cut it for AT emulation. Can you
> really emulate all neccessary features using pty/tty?

Perhaps.  Terminal modes & speeds & special lines and so on set on the
tty side can be seen on the pty side, although I think the pty is not
notified immediately so it has to poll if it wants to detect terminal
programs sending a BREAK signal and things like that.

I had a look at this about a year ago.  I remember that a couple of
small changes to the pty/tty layer would have been very handy to improve
the quality of serial port emulation, and that might be the thing to do.

-- Jamie
