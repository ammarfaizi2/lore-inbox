Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTHTW6W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTHTW6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:58:22 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:34178 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262312AbTHTW6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:58:17 -0400
Date: Wed, 20 Aug 2003 23:58:12 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030820225812.GB24639@mail.jlokier.co.uk>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <16188.54799.675256.608570@gargle.gargle.HOWL> <20030815135248.GA7315@win.tue.nl> <20030815141328.GA16176@ucw.cz> <16189.58357.516036.664166@gargle.gargle.HOWL> <20030821003606.A3165@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821003606.A3165@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> > For my purposes, I need to use an "ioctl" to set a keycode for each
> > scancode, so adding an ioctl to set the no-keyup status is no hassle
> > for me.  However the suggest approach of auto-detecting keys which
> > have no up event would probably a good idea.
> 
> I would be unhappy.
> We need a solid keyboard driver that actually works.
> Not some fragile construction that has tricks built-in
> so as to make things work for every kernel developer.

Synthesising an UP event after receiving a DOWN from the keyboard, and
nothing else for that key for > (repeat delay + a bit more) time looks
like a good plan to me, UNLESS there are keys which do report UP when
the key is released (as opposed to immediately after the DOWN), and
also don't repeat.

Unrelated: I have some messages from my laptop, Toshiba Satellite 4070CDT:

  atkbd.c: Unknown key (set 2, scancode 0x94, in isa0060/serio0) pressed.
  atkbd.c: Unknown key (set 2, scancode 0xbf, in isa0060/serio0) pressed.
  atkbd.c: Unknown key (set 2, scancode 0xa1, in isa0060/serio0) pressed.

Enjoy,
-- Jamie
