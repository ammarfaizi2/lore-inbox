Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUASVlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbUASVlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:41:05 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:59150 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264371AbUASVk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:40:56 -0500
Date: Mon, 19 Jan 2004 22:40:36 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, fire-eyes <sgtphou@fire-eyes.dynup.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: atkbd.c errors + mouse errors with a belkin KVM
Message-ID: <20040119224036.A1101@pclin040.win.tue.nl>
References: <400C1D2F.7020503@fire-eyes.dynup.net> <20040119202905.A1073@pclin040.win.tue.nl> <20040119204348.GA2251@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040119204348.GA2251@ucw.cz>; from vojtech@suse.cz on Mon, Jan 19, 2004 at 09:43:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 09:43:48PM +0100, Vojtech Pavlik wrote:

> > > kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> > > isa0060/serio0).
> > 
> > It is not really an error - the kernel is just being a bit noisy.
> > The 0x7a was really 0xfa, the ACK that a keyboard command succeeded.
> > 
> > Sooner or later the noise will go away. For now it is more interesting
> > to fix bugs in behaviour.
> 
> Well, the kernel is quite rightfully noisy at this point - getting
> unexpected ACKs is rather suspicious.

Yes, I do not propose that you remove the noise today.
But nothing is wrong.

Several utilities access the keyboard directly. (For example X and kbdrate.)
Since setting keyboard rate and starting X are rather common actions,
most people will see these messages a few times in their syslog.

A few months from now, when we are satisfied that the keyboard code
is in perfect shape, these messages can be silenced by default.

Andries

