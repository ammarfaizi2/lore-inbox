Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131664AbQLMRSK>; Wed, 13 Dec 2000 12:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131829AbQLMRSA>; Wed, 13 Dec 2000 12:18:00 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:25873 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131664AbQLMRRy>; Wed, 13 Dec 2000 12:17:54 -0500
Date: Wed, 13 Dec 2000 10:43:17 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Signal 11 - the continuing saga
Message-ID: <20001213104317.A15251@vger.timpanogas.org>
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGKENMCIAA.rmager@vgkk.com> <NEBBJBCAFMMNIHGDLFKGAEAHCJAA.rmager@vgkk.com> <20001212191719.A12420@vger.timpanogas.org> <916pol$5qr$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <916pol$5qr$1@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Dec 12, 2000 at 07:17:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2000 at 07:17:41PM -0800, Linus Torvalds wrote:
> In article <20001212191719.A12420@vger.timpanogas.org>,
> Jeff V. Merkey <jmerkey@vger.timpanogas.org> wrote:
> >On Wed, Dec 13, 2000 at 09:22:55AM +0900, Rainer Mager wrote:
> >> 	I have a tiny bash script that launches a Java swing app. If I run my
> >> script from an xterm (or gnome-terminal or whatever) then it starts up fine.
> >> If, however, I try to launch it from my gnome taskbar's menu then it dies
> >> with signal 11 (the Java log is available upon request). This seems to be
> >> 100% consistent, since I noticed it yesterday, even across reboots.
> >> Interestingly, the same behavior occurs if I try to run the program from
> >> withis JBuilder 4.
> >> 	So, is this related to the larger signal 11 problems?
> >
> >There's a corruption bug in the page cache somewhere, and it's 100%
> >reproducable.  Finding it will be tough....
> 
> Unlikely. If the actual program data was corrupted, it would SIGSEGV
> regardless of how it's executed.
> 
> I'd guess that the program has a bug, and depending on the arguments and
> environment (especially the latter will be different), it shows up or
> not. Things like not having a LOCALE set in either case or similar.
> 
> 		Linus

Linus,

I agree that there may be some problem in the code above -- the question is
what has changed to make this behavior emerge?  I see it with a host of 
programs(ssh, make, netscape) -- true all are userspace.  Time permitting, 
I may attempt to track this down in ssh and make in jobserver mode.  It
may be related to some interaction that changed underneath.

Jeff


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
