Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269676AbTHOQOX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269639AbTHOQOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:14:19 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269696AbTHOQKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:10:02 -0400
Date: Fri, 15 Aug 2003 15:02:36 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030815140236.GA16560@mail.jlokier.co.uk>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <20030815123641.GA7204@win.tue.nl> <20030815124318.GA15478@ucw.cz> <20030815132706.GG15911@mail.jlokier.co.uk> <20030815135214.GB15872@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815135214.GB15872@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> >   2. Set up _every_ other key to be non-repeating in software, with
> > 
> >      (a) consecutive DOWN events causing a synthetic UP just before
> >          the second and subsequent DOWNs.
> 
> Won't work on keyboards which send more than one DOWN before an UP.
> There are a bunch of these, notably the broken notebook keyboards.

I forgot to mention 2b: if subsequent DOWNs appear in rapid succession
_soon_ after the first DOWN, it's a buggy laptop.  Ignore those
subsequent DOWNs.

> > After booting, if the user presses "r", it will behave as expected -
> > it's covered by 1.
> > 
> > If the user presses "Fn+F1" or some other unknown key which doesn't
> > report UP events, it won't repeat and it will report DOWN then UP
> > input events, once each time it is pressed.
> 
> Fn+F1 won't most likely generate a keypress event. It'll just change the
> contrast via the BIOS or something.

I meant the keys which started this thread:

    I have a notebook (Dell Latitude D800) which has some keys (actual
    fn+something combinations) that generate Down events but no Up events
    (clever, isn't it).

> I really believe that keys which generate the same scancode when pressed
> and released (as per the report which started the thread) usually happen
> because the keyboard is in some non-native mode.
> 
> I have keyboards which report the same scancode for both press and
> release of several keys (making the keys undistinguishable) unless
> switched to scancode set 3.

If switching to scancode set 3 solves the whole problem, that's great :)

-- Jamie
