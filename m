Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbTHUNou (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 09:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbTHUNnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 09:43:49 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:58242 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262674AbTHUNWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 09:22:35 -0400
Date: Thu, 21 Aug 2003 14:22:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Neil Brown <neilb@cse.unsw.edu.au>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821132222.GA28416@mail.jlokier.co.uk>
References: <20030821000302.GC24970@mail.jlokier.co.uk> <Pine.GSO.3.96.1030821133902.2489C-100000@delta.ds2.pg.gda.pl> <20030821144835.B3480@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821144835.B3480@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> > > But for programs which want to monitor a key and know its state
> > > continuously (this presently includes the software autorepeater, but
> > > it also includes games), none of the behaviours is right.
> > 
> >  X11 is another example of software that wants to know the state of keys
> > continuously.  And that's not a piece of software to ignore easily. 
> 
> You are both inventing the situation that games, or X11, ask the kernel
> for a bitmap of pressed keys. But they don't. The mechanism doesn't
> even exist.

I have no idea what X wants.  What non-X "action" games want is simple
(I have written a few): to know when the user is pushing particular keys.

Those games achieve this by observing a DOWN event when a key is
pressed, an UP when it is released, to change their knowledge of a key
state, and ignoring events which don't change their knowledge of the
state: auto-repeat DOWN events or spurious UP events.

-- Jamie
