Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbTHTWgN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTHTWgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:36:13 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:8712 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262278AbTHTWgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:36:09 -0400
Date: Thu, 21 Aug 2003 00:36:06 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821003606.A3165@pclin040.win.tue.nl>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <16188.54799.675256.608570@gargle.gargle.HOWL> <20030815135248.GA7315@win.tue.nl> <20030815141328.GA16176@ucw.cz> <16189.58357.516036.664166@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16189.58357.516036.664166@gargle.gargle.HOWL>; from neilb@cse.unsw.edu.au on Sat, Aug 16, 2003 at 05:57:41PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 05:57:41PM +1000, Neil Brown wrote:

> There are 5 keys in question.  Each one is fn + something else.
> Some of them (wireless, brighter, darker) cause the bios to do
> something, and only generate a keyboard event on a down transition.
> The others (battery, cdeject) don't appear to cause the bios to do
> anything, and generate a keyboard event on both the up and down
> transition, and it is always the same scancode.
> 
> Key      Meaning   2.6 scancode     2.4 (direct) scancode
> fn-F2    wireless    0x13d               e0 08
> fn-F3    battery     0x136               e0 07 
> fn-F10   cdeject     0x13e               e0 09 
> fn-down  darker      0x125               e0 05
> fn-up    brighter    0x12e               e0 06

Thanks - added to the data base.
http://www.win.tue.nl/~aeb/linux/kbd/scancodes-1.html#ss1.12

> For my purposes, I need to use an "ioctl" to set a keycode for each
> scancode, so adding an ioctl to set the no-keyup status is no hassle
> for me.  However the suggest approach of auto-detecting keys which
> have no up event would probably a good idea.

I would be unhappy.
We need a solid keyboard driver that actually works.
Not some fragile construction that has tricks built-in
so as to make things work for every kernel developer.
How many non-kernel-developers are there?
How many strange keyboards?

Andries

