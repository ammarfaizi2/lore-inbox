Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263139AbREWP55>; Wed, 23 May 2001 11:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263138AbREWP5s>; Wed, 23 May 2001 11:57:48 -0400
Received: from waste.org ([209.173.204.2]:24616 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S263136AbREWP5i>;
	Wed, 23 May 2001 11:57:38 -0400
Date: Wed, 23 May 2001 10:58:55 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Edgar Toernig <froese@gmx.de>, linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device
 arguments from lookup)
In-Reply-To: <0105231550390K.06233@starship>
Message-ID: <Pine.LNX.4.30.0105231048080.4132-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2001, Daniel Phillips wrote:

> > > > *boggle*
> > > >
> > > >[general sense of unease]
> >
> > I fully agree with Oliver.  It's an abomination.
>
> We are, or at least, I am, investigating this question purely on
> technical grounds - name calling is a noop.  I'd be happy to find a
> real reason why this is a bad idea but so far none has been
> presented.

I will agree that the thing can be done in principle. You're not going to
find anyone who's going to argue that part. All other things being equal,
I actually think it's a neat idea.

The part that is a problem is people, namely people who write programs.
They've had decades to expect that directories are not also files, and if
they happen to do things like check whether a file is not a directory
before opening it, it's _our fault_ if they get confused.

Consider the recent subtle change to fork() that was reversed because it
uncovered an unforseen bug in bash. The proposed change is not at all
subtle, is entirely without precedent, and is likely to break much.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

