Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275940AbTHONdN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 09:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275946AbTHONdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 09:33:13 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:36481 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275940AbTHONdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 09:33:12 -0400
Date: Fri, 15 Aug 2003 14:33:07 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030815133307.GH15911@mail.jlokier.co.uk>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <20030815123641.GA7204@win.tue.nl> <20030815130450.GF15911@mail.jlokier.co.uk> <20030815131040.GA15706@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815131040.GA15706@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> > Several laptops seem to send a key down event 3, 5 or very many times
> > in response to a single press.
> 
> One way this could be handled fairly nicely (although the method is
> maybe too clever to be good) would be to leave the autorepeat up to the
> sw, ignore any successive presses without a release and watch whether
> the keyboard will start autorepeating the key after 250 msec. If it does
> not, then force the key to be released even if we got no release
> scancode.

Perhaps it's too clever, because some users configure the repeat delay
in their BIOS to longer than 250ms.

It is fine if you are able to reliably program the keyboard to use the
250ms delay, though.

Aren't there some keys which report DOWN and UP but which don't repeat?

The PS/2 keyboard protocol is utterly absurd.

-- Jamie
