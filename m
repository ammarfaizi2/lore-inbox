Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132811AbRAJRTw>; Wed, 10 Jan 2001 12:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135866AbRAJRTl>; Wed, 10 Jan 2001 12:19:41 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:58892 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132811AbRAJRT0>; Wed, 10 Jan 2001 12:19:26 -0500
Date: Wed, 10 Jan 2001 09:19:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marco Colombo <marco@esi.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
In-Reply-To: <Pine.LNX.4.21.0101101619230.16888-100000@Megathlon.ESI>
Message-ID: <Pine.LNX.4.10.10101100915290.4283-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2001, Marco Colombo wrote:
> > 
> > 	case xxx:
> > 		/* fallthrough */ ;
> > 	}
> > 
> > or something (or maybe just a "break" statement), just so that we don't
> > turn the poor C language into line noise (can anybody say "perl" ;)
> 
> Of course, you don't mean that the fallthrough comment and the break
> statement have the same functionality! (well you put the closing
> bracket and I agree that for the last case it's the same).

Note that the warning case we're discussing was really only about case
statements at the end of a compound statement.

In the middle of compound statements we're already fine: it's only the
corner case of a case "statement" without the statement that gcc
historically used to accept without warning, and that the gcc people only
recently noticed that they really shouldn't accept at all.

So that's why a comment and a "break" is equivalent. ONLY for the special
case of the new compile warning, though, obviously (see the subject line,
but yes, I should have made that more explicit).

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
