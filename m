Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbTHYTgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 15:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbTHYTgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 15:36:32 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:3717 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S262193AbTHYTg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 15:36:27 -0400
Date: Mon, 25 Aug 2003 20:36:00 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030825193600.GA24233@mail.jlokier.co.uk>
References: <20030815141328.GA16176@ucw.cz> <16189.58357.516036.664166@gargle.gargle.HOWL> <20030821003606.A3165@pclin040.win.tue.nl> <20030820225812.GB24639@mail.jlokier.co.uk> <20030821015258.A3180@pclin040.win.tue.nl> <20030821080145.GA11263@ucw.cz> <20030822022709.A3640@pclin040.win.tue.nl> <20030822073328.GA7473@ucw.cz> <20030825042235.GB20529@mail.jlokier.co.uk> <20030825082248.GA3341@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825082248.GA3341@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> > That works well for typing, but if someone tries to use these keys in
> > an action game, they will disappointed with the forced-up code - the
> > game will see the key pressed and released, even when the user holds
> > the key down for a long time.
> 
> Indeed. Are you expecting a game to be able to use the WWW or Calculator
> keys for anything useful?

Of course.  It's not unusual for a game to have a "define keys"
option, where you press a key for each action, to set the key
bindings.  Sometimes you pick mnemonic keys; other times, you pick
keys because of how their position feels, like making a custom joypad.

On my Microsoft multimedia keyboard there are about 20 keys that I
could see being useful for that, especially as mnemonic keys.

> > There is only one solution which works well that I can see: do the
> > forced-up thing by default, but as soon as you see a real UP event
> > from a key, disabled forced-up _for that key_ in future.
> 
> Won't work. There are keyboards that forget to send a key up event
> sometimes. They usually send it, but from time to time they don't.
> We need to cover these keyboards, too. It's actually the main reason for
> the whole forced up thingy.

:(  That's a shame, and a peculiar bug too.  Then I agree that
forced-up is needed all the time, if we do not know what triggers the
keyboard to forget to send one or have any way to detect it.

It is not so bad, because even the multimedia keys will be fine on
good quality keyboards.

> I'll give you a kernel/module option to disable the forced up effect if
> you have a perfect keyboard. You can then also enable the untranslated
> mode and set 3. But the default will be translated set 2 with forced
> keyups if a key is not repeating.

Fair enough, I agree.

-- Jamie
