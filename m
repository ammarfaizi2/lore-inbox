Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTHVHfn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 03:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbTHVHfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 03:35:31 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:34535 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263053AbTHVHdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 03:33:41 -0400
Date: Fri, 22 Aug 2003 09:33:28 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030822073328.GA7473@ucw.cz>
References: <20030815105802.GA14836@ucw.cz> <16188.54799.675256.608570@gargle.gargle.HOWL> <20030815135248.GA7315@win.tue.nl> <20030815141328.GA16176@ucw.cz> <16189.58357.516036.664166@gargle.gargle.HOWL> <20030821003606.A3165@pclin040.win.tue.nl> <20030820225812.GB24639@mail.jlokier.co.uk> <20030821015258.A3180@pclin040.win.tue.nl> <20030821080145.GA11263@ucw.cz> <20030822022709.A3640@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822022709.A3640@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 02:27:09AM +0200, Andries Brouwer wrote:

> On Thu, Aug 21, 2003 at 10:01:45AM +0200, Vojtech Pavlik wrote:
> 
> > > > UNLESS there are keys which do report UP when the key
> > > > is released (as opposed to immediately after the DOWN),
> > > > and also don't repeat.
> > > 
> > > And there are keyboards with such keys.
> > 
> > Are there?
> 
> I owe you an example. See, for example,
> 	http://www.win.tue.nl/~aeb/linux/kbd/scancodes-5.html#ss5.29

Thanks.

> Abbreviated version:
>   Serge van den Boom reports that his LiteOn MediaTouch Keyboard has 18
>   additional keys: Suspend, Coffee, WWW, Calculator, Xfer, Switch window,
>   Close, |<<, >|, [], >>|, Record, Rewind, Menu, Eject, Mute, Volume +,
>   and Volume -. Of these, the keys |<<, >>|, Volume +, Volume - repeat.
>   The others do not, except for the rather special Switch window key.
>   Upon press it produces the LAlt-down, LShift-down, Tab-down, Tab-up sequence;
>   it repeats Tab-down; and upon release it produces the sequence Tab-up,
>   LAlt-up, LShift-up.
> (Up events are as usual for the other 17 keys.)

The code as is now (with the autorepeat and the forced up if the
keyboard itself doesn't start repeating) won't have any problems with
this keyboard.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
