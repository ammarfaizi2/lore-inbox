Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290472AbSA3TjG>; Wed, 30 Jan 2002 14:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290495AbSA3Ti5>; Wed, 30 Jan 2002 14:38:57 -0500
Received: from [63.204.6.12] ([63.204.6.12]:33511 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S290472AbSA3Tir>;
	Wed, 30 Jan 2002 14:38:47 -0500
Subject: Re: A modest proposal -- We need a patch penguin
From: "Georg Nikodym" <georgn@somanetworks.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Larry McVoy <lm@bitmover.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201301005260.1989-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201301005260.1989-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 30 Jan 2002 14:38:21 -0500
Message-Id: <1012419503.1460.68.camel@keller>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-30 at 13:23, Linus Torvalds wrote:

[really interesting and insightful comments about revision graphs]

The thing that's missing here is that 'g' (or 1.7) doesn't just refer to
the change that is 'g'.  It's actually a label that implies a point in
time as well as all the change that came before it.  Stated differently,
it is a set.

Using your graph:

        a -> b -> c -> f

                -> d

                -> e

and the way that people currently think (and thus speak) of these
things, saying that you're using a version 'e' kernel is ambiguous
because it may or may not have 'c' or 'd'.  This ambiguity also
complicates the task of reproducing a tree at some known state later.

You, as the center of the known universe may not need to concern
yourself with such trifles, but speaking as one of those fabled
commercial customers, the ability to say unambiguously say what's been
changed (read: fixed) is really important.

All that said, I like your idea about revision graph compression.  My
concerns might simply be mitigated by being able to insert "release"
points (simply a tag that implies/includes all the preceding
changesets).


