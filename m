Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTIRIZA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 04:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbTIRIZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 04:25:00 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1152 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263025AbTIRIY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 04:24:58 -0400
Date: Thu, 18 Sep 2003 09:38:44 +0100
From: John Bradford <john@81-2-122-30.bradfords.org.uk>
Message-Id: <200309180838.h8I8cioM000312@81-2-122-30.bradfords.org.uk>
To: Andries.Brouwer@cwi.nl, john@grabjohn.com, linux-kernel@vger.kernel.org,
       ndiamond@wta.att.ne.jp
Subject: Re: 2.6.0-test5 vs. APM or keyboard driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So far we have heard about precisely one keyboard in the world
> where scancode mode 3 was useful. It is the Japanese keyboard
> of John Bradford. He once wrote
>
> > My keyboard has a distinct ID, and works fine in set 3,
>
> Let me repeat the question:
> John: What ID does this keyboard report?

Sorry I didn't get back to you earlier about this.

It reports ab90.

Obviously at the moment it defaults to being used in set2, which works
as well in 2.6 as it does in 2.4 - the only problem is that the
language keys are indistinguishable from the space key.

Using set3 in 2.6 works, but not without a few problems.

I loaded a Japanese keyboard map, and most keys, (all the alphanumeric
keys), worked fine.  A few symbols didn't, so I started to do some
observations with showkey to see what was going on.

(For anybody new to this discussion - I haven't used the Japanese
keyboard map up until now, because my keyboard emulates a US one when
in set2.)

The Yen key reports keycode 86.  This is defined as less/greater in
the Japanese keyboard map I used.

Backslash/underscore reports keycode 43, which the keymap defines as
bracketright/braceright.

The actual bracketright/braceright key reports 84 on my keyboard,
whereas backslash/underscore in the keymap is defined for keycode 89.

Here are two more interesting problems, though:

Pressing any of the language keys reports nothing, but causes the next
keystroke to be lost.

Right alt and right control both generate keycode 100, and are both
interpreted as alt.

All of these problems should be easily fixable.  The lost keystoke one
didn't happen last time I actually tested set3 in 2.5, (that was a
long time ago, though, around 2.5.40).

I'll get some more useful debug information later, but my serial
terminal is in need of repair at the moment :-(.

John.
