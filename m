Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbTHUII6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 04:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbTHUII6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 04:08:58 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:150 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262515AbTHUIIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 04:08:55 -0400
Date: Thu, 21 Aug 2003 10:08:45 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Jamie Lokier <jamie@shareable.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821080845.GC11263@ucw.cz>
References: <20030815105802.GA14836@ucw.cz> <16188.54799.675256.608570@gargle.gargle.HOWL> <20030815135248.GA7315@win.tue.nl> <20030815141328.GA16176@ucw.cz> <16189.58357.516036.664166@gargle.gargle.HOWL> <20030821003606.A3165@pclin040.win.tue.nl> <20030820225812.GB24639@mail.jlokier.co.uk> <20030821015258.A3180@pclin040.win.tue.nl> <20030821000302.GC24970@mail.jlokier.co.uk> <20030821023345.A3204@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821023345.A3204@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 02:33:45AM +0200, Andries Brouwer wrote:

> > So the decision must be: shall we do the wrong thing for keyboards
> > which report DOWN only (the key will appear stuck to some programs),
> > or shall we do the wrong thing for keyboards which report DOWN, no
> > repeat and then UP, by making it look like the key was released early?
> 
> There are many more problems with your synthesized events.
> Look at your "repeat delay + a bit more". Can you specify how much
> "a bit more" is?
> 
> In times of heavy disk activity we lose interrupts.
> Indeed, if I copy a CD image or untar a kernel tree
> my keyboard and mouse are dead for several seconds.

This needs to be fixed. ;)

> There is no guaranteed "a bit more" within which we will see a
> keyboard event.

Worst case we instead of autorepeat will generate a complete keypress
and key release, not too bad, you won't even notice when your system has
a second long response time.

> If the only events that are seen are actual events, and on rare
> occasions we miss an event, that is not so bad. We just hit that
> key again. But if we synthesize events, then a missed key up
> causes autorepeat.
> 
> In fact I see unwanted autorepeat - maybe once a day suddenly
> a single keystroke causes three to five identical characters to
> appear - but I am not sure what mechanism causes this.

If you can find this, I'd be really grateful - some people see that, and
I don't and I can't find any problem in the code.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
