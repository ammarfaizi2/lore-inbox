Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTIVUJT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTIVUJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:09:19 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:13729
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263298AbTIVUJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:09:12 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Keyboard oddness.
Date: Mon, 22 Sep 2003 15:06:08 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200309201633.22414.rob@landley.net> <20030921100436.GA18409@ucw.cz>
In-Reply-To: <20030921100436.GA18409@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309221506.08331.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 September 2003 05:04, Vojtech Pavlik wrote:
> On Sat, Sep 20, 2003 at 04:33:22PM -0400, Rob Landley wrote:
> > I've mentioned my keyboard repeat problems before.  I grepped through the
> > logs and found a whole bunch of these type messages:
> >
> > Aug 17 05:28:48 localhost kernel: atkbd.c: Unknown key (set 2, scancode
> > 0x1d0, on isa0060/serio0) pressed.
> > Aug 19 09:06:51 localhost kernel: atkbd.c: Unknown key (set 2, scancode
> > 0x8e, on isa0060/serio0) pressed.
> > Aug 22 04:33:36 localhost kernel: atkbd.c: Unknown key (set 2, scancode
> > 0xcd,
> >
> > (There's more, it just goes on and on...)
> >
> > Any clues?  (Thinkpad iSeries...  1200, I think.)
>
> What kernel version? Can you test with latest?

So the key repeat problem is still happening with -test5-mm4.  I just had the 
return key stick on me, and gave it a good three seconds to stop repeating 
before I hit another key.  It didn't.   I noticed after it stuck that the 
next time I hit it, it didn't register.  (I unstuck it with the up-arrow key, 
I believe.  But after that one failure to press, it seemed to be nicely 
reset...)

Here's a cut and paste from a tail of /var/log/messages:

Sep 22 12:50:38 localhost  -- landley[984]: LOGIN ON tty1 BY landley
Sep 22 13:24:05 localhost kernel: spurious 8259A interrupt: IRQ7.
Sep 22 14:12:26 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x94, 
on isa0060/serio0) pressed.
Sep 22 14:12:26 localhost kernel: i8042 history: 18 98 18 98 26 a6 39 b9 1f 9f 
15 1f 95 9f 12 94
Sep 22 14:22:05 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xa6, 
on isa0060/serio0) pressed.
Sep 22 14:22:05 localhost kernel: i8042 history: 94 15 95 39 14 b9 18 94 98 39 
b9 23 12 a3 92 a6
Sep 22 14:39:06 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x1cb, 
on isa0060/serio0) pressed.
Sep 22 14:39:06 localhost kernel: i8042 history: cb e0 4b e0 cb e0 4b e0 cb e0 
4b e0 cb 4b e0 cb
Sep 22 14:58:05 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x1d0, 
on isa0060/serio0) pressed.
Sep 22 14:58:05 localhost kernel: i8042 history: 1c 90 9c e0 48 e0 c8 23 0f a3 
8f 1c 9c 50 e0 d0
Sep 22 14:59:46 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xb1, 
on isa0060/serio0) pressed.
Sep 22 14:59:46 localhost kernel: i8042 history: 2d ad 2d ad 17 97 19 99 1e 15 
9e 95 17 97 22 b1
Sep 22 15:02:11 localhost su(pam_unix)[1649]: session opened for user root by 
landley(uid=500)

Any clues?  (This happens to me at least once an hour...)

Rob
