Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135192AbRAJNRp>; Wed, 10 Jan 2001 08:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135568AbRAJNRf>; Wed, 10 Jan 2001 08:17:35 -0500
Received: from [139.102.15.43] ([139.102.15.43]:24551 "EHLO
	online.indstate.edu") by vger.kernel.org with ESMTP
	id <S132959AbRAJNRQ>; Wed, 10 Jan 2001 08:17:16 -0500
From: "Rich Baum" <baumr1@coral.indstate.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 10 Jan 2001 08:17:11 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
Reply-to: richbaum@acm.org
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>, acahalanrth@twiddle.net,
        linux-kernel@vger.kernel.org
Message-ID: <3A5C1A87.27149.604DC6@localhost>
In-Reply-To: <20010110032048.B9486@athlon.random>
In-Reply-To: <Pine.LNX.4.10.10101092304410.3414-100000@penguin.transmeta.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jan 2001, at 23:10, Linus Torvalds wrote:

> 
> 
> On Wed, 10 Jan 2001, Andrea Arcangeli wrote:
> 
> > On Tue, Jan 09, 2001 at 01:31:35PM -0800, Linus Torvalds wrote:
> > > don't have to worry about undocumented extensions etc.
> > 
> > Infact I don't blame gcc maintainers for that, but the standard. Ok, minor
> > issue.
> 
> Yeah, and nothing we can do about it any more.. Oh, well.
> 
> The fact is that the 
> 
> 	case xxx: ;
> 
> syntax is fairly ugly, so I'd prefer the fixup patches to look more like
> 
> 	case xxx:
> 		/* fallthrough */ ;
> 	}
> 
> or something (or maybe just a "break" statement), just so that we don't
> turn the poor C language into line noise (can anybody say "perl" ;)
> 
> I have to say, I think it was Pascal had this "no semicolon needed before
> an 'end'" rule, and I always really hated that. The C statement rules make
> a lo tmore sense, and requiring a statement after a case statement is
> probably a very good requirement from a language standpoint. It's just not
> very pretty - but adding a break or a comment will at least separate out
> the colon and the semi-colon a bit.
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

I'll redo my patch to use break; and then I'll resend it.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
