Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268392AbRGXRlM>; Tue, 24 Jul 2001 13:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268390AbRGXRlD>; Tue, 24 Jul 2001 13:41:03 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:50700 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268394AbRGXRkt>; Tue, 24 Jul 2001 13:40:49 -0400
Date: Tue, 24 Jul 2001 10:38:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Andrea Arcangeli <andrea@suse.de>, Jeff Dike <jdike@karaya.com>,
        <user-mode-linux-user@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>,
        Jonathan Lundell <jlundell@pobox.com>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <XFMail.20010724103157.davidel@xmailserver.org>
Message-ID: <Pine.LNX.4.33.0107241037120.29495-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Tue, 24 Jul 2001, Davide Libenzi wrote:
>
> Not that much if you look at how incl is "decomposed" internally ( w/o LOCK )
> by the CPU. If you really care about  j  you need an atomic op here, in any case.

Yes, but the "inc" is atomic at least on a UP system. So here "volatile"
might actually _show_ bugs instead of hiding them.

The real isssue, though, is that that is all volatile ever does. It can
show or hide bugs, but it can't fix them.

Of course, some people consider hidden bugs to _be_ fixed. I don't believe
in that particulat philosophy myself.

		Linus

