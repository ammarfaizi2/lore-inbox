Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262721AbSJaQia>; Thu, 31 Oct 2002 11:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265241AbSJaQi3>; Thu, 31 Oct 2002 11:38:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62687 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262721AbSJaQiG>;
	Thu, 31 Oct 2002 11:38:06 -0500
Date: Thu, 31 Oct 2002 11:44:30 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
cc: Dax Kelson <dax@gurulabs.com>, Chris Wedgwood <cw@f00f.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
In-Reply-To: <3DC15931.9030601@verizon.net>
Message-ID: <Pine.GSO.4.21.0210311126450.16688-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Oct 2002, Stephen Wille Padnos wrote:

> >Then give them all the same account and be done with that.  Effect will
> >be the same.
> >  
> >
> 
> Unless I'm missing something, that only works if all the users need 
> *exactly* the same permissions to all files, which isn't a good assumption.

That's the point.  In practice shared writable access to a directory can be
easily elevated to full control of each others' accounts, since most of
userland code is written in implicit assumption that nothing bad happens with
directory structure under it.  And there is nothing kernel can do about that -
attacker does action you had explicitly allowed and your program goes bonkers
since it can't cope with that.  Mechanism used to allow that action doesn't
enter the picture - be it ACLs, groups or something else.

