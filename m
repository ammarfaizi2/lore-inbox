Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTHUADN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 20:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbTHUADM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 20:03:12 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:39298 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262386AbTHUADI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 20:03:08 -0400
Date: Thu, 21 Aug 2003 01:03:02 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821000302.GC24970@mail.jlokier.co.uk>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <16188.54799.675256.608570@gargle.gargle.HOWL> <20030815135248.GA7315@win.tue.nl> <20030815141328.GA16176@ucw.cz> <16189.58357.516036.664166@gargle.gargle.HOWL> <20030821003606.A3165@pclin040.win.tue.nl> <20030820225812.GB24639@mail.jlokier.co.uk> <20030821015258.A3180@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821015258.A3180@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> > Synthesising an UP event after receiving a DOWN from the keyboard, and
> > nothing else for that key for > (repeat delay + a bit more) time looks
> > like a good plan to me, UNLESS there are keys which do report UP when
> > the key is released (as opposed to immediately after the DOWN), and
> > also don't repeat.
> 
> And there are keyboards with such keys.

Alas.

For programs which are only interested in key presses, there is no
problem including a synthesised UP event.

But for programs which want to monitor a key and know its state
continuously (this presently includes the software autorepeater, but
it also includes games), none of the behaviours is right.

So the decision must be: shall we do the wrong thing for keyboards
which report DOWN only (the key will appear stuck to some programs),
or shall we do the wrong thing for keyboards which report DOWN, no
repeat and then UP, by making it look like the key was released early?

-- Jamie
