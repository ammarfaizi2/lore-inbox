Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130196AbRAQUEC>; Wed, 17 Jan 2001 15:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130299AbRAQUDm>; Wed, 17 Jan 2001 15:03:42 -0500
Received: from palrel3.hp.com ([156.153.255.226]:64010 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S130196AbRAQUDK>;
	Wed, 17 Jan 2001 15:03:10 -0500
Message-ID: <3A65FA77.9E1C1117@cup.hp.com>
Date: Wed, 17 Jan 2001 12:03:03 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.10.10101171104560.9845-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The fact that I understand _why_ it is done that way doesn't mean that I
> don't think it's a hack. It doesn't allow you to sendfile multiple files
> etc without having nagle boundaries, and the header/trailer stuff really
> isn't a generic solution.

Hmm, I would think that nagle would only come into play if those files
were each less than MSS and there were no intervening application level
reply/request messages for each. So, perhaps rcp, but not FTP nor HTTP.
I'm not sure where the break-even point versus send() is on other OSes,
but it seems to be in the neighborhood of the typical ethernet MSS on
HP-UX.

As for the header/trailer stuff, you're right, I should have spec'd a
separate iovec for each :)

> Also note how I said that it is the BSD people I _despise_. Not The HP-UX

That misunderstanding would be the result of my entering the
conversation in the middle...

> implementation. The HP-UX one is not pretty, but it works. But I hold open
> source people to higher standards. They are supposed to be the people who
> do programming because it's an art-form, not because it's their job.

I'm not sure, but I think I've just been insulted !-) (in case it is not
clear, that is meant as a joke...)

rick jones
-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
