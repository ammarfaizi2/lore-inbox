Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268868AbRG0Pfi>; Fri, 27 Jul 2001 11:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268867AbRG0PfV>; Fri, 27 Jul 2001 11:35:21 -0400
Received: from [194.213.32.142] ([194.213.32.142]:6916 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S268865AbRG0Pee>;
	Fri, 27 Jul 2001 11:34:34 -0400
Date: Mon, 23 Jul 2001 12:56:35 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>,
        "David S. Miller" <davem@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@redhat.com>,
        David Woodhouse <dwmw2@redhat.com>, linux-scsi@vger.kernel.org,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.7-pre9..
Message-ID: <20010723125635.A35@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0107192208070.14141-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0107192208070.14141-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jul 19, 2001 at 10:17:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi!

> I've changed all generic code, so drivers are all expected to compile and
> work. However, some SCSI drivers use the semaphore trick in their own
> code, and I've not mucked with that. It's not worth worrying about too
> much, as the race is basically impossible to hit (famous last words), but

I smell problems in usb/storage/*...

<evil>
What about adding strategic udelay() somewhere so race is easier to hit?
</evil>
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

