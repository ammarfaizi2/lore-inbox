Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbSKKEan>; Sun, 10 Nov 2002 23:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbSKKEan>; Sun, 10 Nov 2002 23:30:43 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:2824 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265469AbSKKEam>;
	Sun, 10 Nov 2002 23:30:42 -0500
Date: Sun, 10 Nov 2002 23:37:25 -0500 (EST)
Message-Id: <200211110437.gAB4bPl390685@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: wli@holomorphy.com, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.46-mm2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


William Lee Irwin III writes:
> On Sun, Nov 10, 2002 at 08:58:28AM -0800, Andrew Morton wrote:

>> It could be the procps thing?  `tiobench --threads 256' shows
>> up as a single process in top and ps due to the new thread
>> consolidation feature. If you run `ps auxm' or hit 'H' in top,
>> all is revealed.  Not my fave feature that.

The feature is both buggy (both false consolidation and failure
to consolidate) and slow. While I do eventually need to add the
feature, I'm not doing so until it can be implemented properly.
So go ahead and enjoy procps-3.1.0 without it:

http://procps.sf.net/

Future-compatibility exists. The "m" and "-m" options are currently
ignored so that you may use them in scripts without causing errors.

Um, BTW, don't we need /proc/42/threads/123/stat and friends
before the Linux 2.6.xx release? Without them, the new clone
flags supposedly let a user hide a task. That's really bad.

> Turns out monitoring things via /proc/ slowed it down by
> some ridiculous factor while it was trying to spawn threads.
> 9 hours became less than 1s when I stopped looking.

Not that procps will ever be fast, but 3.1.0 is a lot faster
than 2.x.xx is. Five out of the last seven releases have
included performance improvements, and more are coming.

You also get IO-wait info in vmstat. Upgrade today! :-)
