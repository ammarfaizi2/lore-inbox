Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbUASVuk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUASVuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:50:39 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:40067 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264547AbUASVua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:50:30 -0500
Date: Mon, 19 Jan 2004 22:50:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: fire-eyes <sgtphou@fire-eyes.dynup.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: atkbd.c errors + mouse errors with a belkin KVM
Message-ID: <20040119215028.GA4431@ucw.cz>
References: <400C1D2F.7020503@fire-eyes.dynup.net> <20040119202905.A1073@pclin040.win.tue.nl> <20040119204348.GA2251@ucw.cz> <20040119224036.A1101@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119224036.A1101@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 10:40:36PM +0100, Andries Brouwer wrote:
> On Mon, Jan 19, 2004 at 09:43:48PM +0100, Vojtech Pavlik wrote:
> 
> > > > kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> > > > isa0060/serio0).
> > > 
> > > It is not really an error - the kernel is just being a bit noisy.
> > > The 0x7a was really 0xfa, the ACK that a keyboard command succeeded.
> > > 
> > > Sooner or later the noise will go away. For now it is more interesting
> > > to fix bugs in behaviour.
> > 
> > Well, the kernel is quite rightfully noisy at this point - getting
> > unexpected ACKs is rather suspicious.
> 
> Yes, I do not propose that you remove the noise today.
> But nothing is wrong.
> 
> Several utilities access the keyboard directly. (For example X and kbdrate.)
> Since setting keyboard rate and starting X are rather common actions,
> most people will see these messages a few times in their syslog.

kbdrate is supposed to use the ioctls, as is X. Actually kbdrate does
use the ioctls on my systems.

> A few months from now, when we are satisfied that the keyboard code
> is in perfect shape, these messages can be silenced by default.

Actually, I think they could stay, because they'll not happen under
normal circumstances by then.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
