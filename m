Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131039AbQLUNCp>; Thu, 21 Dec 2000 08:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131042AbQLUNCf>; Thu, 21 Dec 2000 08:02:35 -0500
Received: from [194.213.32.137] ([194.213.32.137]:9220 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131039AbQLUNCQ>;
	Thu, 21 Dec 2000 08:02:16 -0500
Message-ID: <20001221132800.A1398@bug.ucw.cz>
Date: Thu, 21 Dec 2000 13:28:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: Igmar Palsenberg <maillist@chello.nl>, Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kapm-idled : is this a bug?
In-Reply-To: <20001220101142.A6234@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.21.0012211158170.12934-100000@server.serve.me.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0012211158170.12934-100000@server.serve.me.nl>; from Igmar Palsenberg on Thu, Dec 21, 2000 at 12:00:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > What's the problem with using PID 0 as the idle task ? That's 'standard'
> > > with OS'ses that display the idle task.
> > 
> > Linux has already another thread with pid 0, called "swapper" which is
> > in fact idle. kidle-apmd is different beast.
> 
> Agree that it is different. But it confuses people to have two
> idle-tasks. I suggest that we throw it one big pile, unless having a
> separate apm idle task has a purpose. 

You can't do that. Doing it this way is _way_ better for system
stability, because kidle-apmd sometimes dies due to APM
bug. kidle-apmd dying is recoverable error; swapper dieing is as fatal
as it can be.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
