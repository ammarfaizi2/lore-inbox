Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267026AbTAULdb>; Tue, 21 Jan 2003 06:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbTAULdb>; Tue, 21 Jan 2003 06:33:31 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:41988
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267026AbTAULda>; Tue, 21 Jan 2003 06:33:30 -0500
Date: Tue, 21 Jan 2003 03:38:35 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Grover <andrew.grover@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: Ask devices to powerdown before S3 sleep
In-Reply-To: <20030121104737.GC24349@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.10.10301210326580.16070-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel,

I failed to make the point clear.
One thing I learned was never trust the BIOS, even if you wrote it.

Now if you are missing ACPI hooks to beat the BIOS silly for whatever
reason you want, I will load two barrels towards Andy for not finishing
the task or not explaining how to throttle them.

I do not care if the BIOS want to do monkey flips.
If there is an event any piece of hardware can not handle, ie where you
have inserted tests that default to panic, it had better allow you to
throttle to full enable.

If it does not, the solution is to make a blackball list of hardware
which fails to conform to acpi rules.  Fair warning you had better have a
means to prove it because, public lists make companies nervous.

So, that I am clear ... would you consider changing the default method of
operations for errors.

How a BUG() and a really long long timer until the battery dies, a panic
gives little or no information, but this is my opinion.

Cheers,


Andre Hedrick
LAD Storage Consulting Group

On Tue, 21 Jan 2003, Pavel Machek wrote:

> Hi!
> 
> > Could you do me just one tiny favor?
> > Please consider attempting an error recovery level path, maybe ...
> > 
> > Every patch I have glanced at has 'panic("blah blah");'
> > 
> > If you do not have enough hardware to generate an accurate path for
> > recovery, then please do not force the kernel into panic.  Would you
> > consider failing the request making it jump back to S1 ?  This at least
> > allows it crash like a power failure.
> 
> If I make it go S1, auto-reboot will not apply etc, and machine will
> crash during ENABLE, anyway...

