Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131775AbQLVKgA>; Fri, 22 Dec 2000 05:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131919AbQLVKfv>; Fri, 22 Dec 2000 05:35:51 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4356 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131775AbQLVKfh>;
	Fri, 22 Dec 2000 05:35:37 -0500
Message-ID: <20001222110241.B244@bug.ucw.cz>
Date: Fri, 22 Dec 2000 11:02:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Igmar Palsenberg <maillist@chello.nl>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kapm-idled : is this a bug?
In-Reply-To: <20001221132800.A1398@bug.ucw.cz> <200012211927.eBLJROd347633@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200012211927.eBLJROd347633@saturn.cs.uml.edu>; from Albert D. Cahalan on Thu, Dec 21, 2000 at 02:27:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Agree that it is different. But it confuses people to have two
> >> idle-tasks. I suggest that we throw it one big pile, unless having a
> >> separate apm idle task has a purpose. 
> >
> > You can't do that.
> 
> Sure you can, and it makes perfect sense.

No. You lost the way to distinguish between real "idle" spend, and
kapm-idle spend -- they are different, in kapm-idle cpu is slowed down.

> > Doing it this way is _way_ better for system
> > stability, because kidle-apmd sometimes dies due to APM
> > bug. kidle-apmd dying is recoverable error; swapper dieing is as fatal
> > as it can be.
> 
> Good. Maybe the bugs will get fixed then. If the bugs are in
> the BIOS or motherboard hardware, we can have a blacklist.

Ha ha. It was that way. Linus saw it was bad so he fixed it. Bugs are
discovered/fixed anyway, because you get ugly oops. But ugly oops is
better than even uglier oops that does not go to syslog and that kills
you machine hard, you see?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
