Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbQLMDse>; Tue, 12 Dec 2000 22:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130075AbQLMDsY>; Tue, 12 Dec 2000 22:48:24 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:43282 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129602AbQLMDsP>; Tue, 12 Dec 2000 22:48:15 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Signal 11 - the continuing saga
Date: 12 Dec 2000 19:17:41 -0800
Organization: Transmeta Corporation
Message-ID: <916pol$5qr$1@penguin.transmeta.com>
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGKENMCIAA.rmager@vgkk.com> <NEBBJBCAFMMNIHGDLFKGAEAHCJAA.rmager@vgkk.com> <20001212191719.A12420@vger.timpanogas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001212191719.A12420@vger.timpanogas.org>,
Jeff V. Merkey <jmerkey@vger.timpanogas.org> wrote:
>On Wed, Dec 13, 2000 at 09:22:55AM +0900, Rainer Mager wrote:
>> 	I have a tiny bash script that launches a Java swing app. If I run my
>> script from an xterm (or gnome-terminal or whatever) then it starts up fine.
>> If, however, I try to launch it from my gnome taskbar's menu then it dies
>> with signal 11 (the Java log is available upon request). This seems to be
>> 100% consistent, since I noticed it yesterday, even across reboots.
>> Interestingly, the same behavior occurs if I try to run the program from
>> withis JBuilder 4.
>> 	So, is this related to the larger signal 11 problems?
>
>There's a corruption bug in the page cache somewhere, and it's 100%
>reproducable.  Finding it will be tough....

Unlikely. If the actual program data was corrupted, it would SIGSEGV
regardless of how it's executed.

I'd guess that the program has a bug, and depending on the arguments and
environment (especially the latter will be different), it shows up or
not. Things like not having a LOCALE set in either case or similar.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
