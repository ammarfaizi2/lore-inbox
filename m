Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317776AbSFSFSX>; Wed, 19 Jun 2002 01:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317775AbSFSFSW>; Wed, 19 Jun 2002 01:18:22 -0400
Received: from mail.goquest.com ([63.172.73.8]:28840 "HELO mail.goquest.com")
	by vger.kernel.org with SMTP id <S317774AbSFSFSV>;
	Wed, 19 Jun 2002 01:18:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Michael S. Zick" <mszick@goquest.com>
To: Rob Landley <landley@trommello.org>, zaimi@pegasus.rutgers.edu,
       linux-kernel@vger.kernel.org
Subject: Re: kernel upgrade on the fly
Date: Wed, 19 Jun 2002 00:09:32 -0500
X-Mailer: KMail [version 1.2]
References: <Pine.GSO.4.44.0206181703540.26846-100000@pegasus.rutgers.edu> <20020619010945.6725B7D9@merlin.webofficenow.com>
In-Reply-To: <20020619010945.6725B7D9@merlin.webofficenow.com>
MIME-Version: 1.0
Message-Id: <02061900093200.00787@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 June 2002 02:37 pm, Rob Landley wrote:
> On Tuesday 18 June 2002 05:21 pm, zaimi@pegasus.rutgers.edu wrote:
> > Hi all,
> >
> >  has anybody worked or thought about a property to upgrade the kernel
> > while the system is running?  ie. with all processes waiting in their
> > queues while the resident-older kernel gets replaced by a newer one.
>
> > Would anybody else think this to be an interesting property to have for
> > the linux kernel or care to comment on this idea?
> >
Sure,
I know two industries that do such a thing (almost);
Spacecraft and the Telephone Company (any/all);

I did say almost...
I'll speak of the telephone industry, because I am more familar with it...
There they use two (or more) machines, running near the same program...
The one connected to the outside world of hardware is duplicating the 
event in a message, sent to the second...
The second, instead of listening to the outside world is listening to the
messages, duplicating all of the program logic except the hardware i/o.
The memory data structures are identical between the two.
When disaster happens...
Machine two rolls out it's listening modules, rolls in the i/o modules,
sends signal to hardware buss switch to give it the system buss.
Then the fun begins... 
Recover the hardware (or at least the billing information).
Note the three points above:
1) Near identical programs
2) Identical data structures
3) Two sets of CPU hardware

Switching from linux-2.4.x to linux-2.6.x doesn't qualify;

The person who asked this question wants to do it on
a single machine - The price just went way up...

Linux uses internal data structures when and wherever
they are needed.  Updating them all to be consistant 
would be a real b....
Probably you would have to start from scratch and
rebuild them...

Hmm, I think I just said "reboot" the machine with 
the new kernel.

Mike
