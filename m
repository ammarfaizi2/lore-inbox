Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSHAVVe>; Thu, 1 Aug 2002 17:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSHAVVe>; Thu, 1 Aug 2002 17:21:34 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:44293 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317181AbSHAVVc>;
	Thu, 1 Aug 2002 17:21:32 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208012124.g71LObi394284@saturn.cs.uml.edu>
Subject: Re: 2.5.28 and partitions
To: viro@math.psu.edu (Alexander Viro)
Date: Thu, 1 Aug 2002 17:24:37 -0400 (EDT)
Cc: thunder@ngforever.de (Thunder from the hill),
       peter@chubb.wattle.id.au (Peter Chubb), pavel@ucw.cz (Pavel Machek),
       Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0208011610020.12627-100000@weyl.math.psu.edu> from "Alexander Viro" at Aug 01, 2002 04:31:20 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> [...]
>> On Wed, 31 Jul 2002, Alexander Viro wrote:

>>> What the bleedin' hell is wrong with <name> <start> <len>\n - all in ASCII?  
>>> Terminated by \0.  No need for flags, no need for endianness crap, no
>>> need to worry about field becoming too narrow...

There's just that little overflow problem to worry about,
trailing garbage, encouragement of assumptions about the
maximum size... is that a %d or a %llu or what?

Given n fields and an constant c>5, there will be at least
exp(c,n) ways to parse and generate the data. All will be
implemented. In addition to disagreement over the format,
most parsers will be buggy.

You just like ASCII because that's the Plan 9 way.
There's a time and place for ASCII, and this isn't it.

> More powerful in which way?  I see where it's less powerful - sizeof(long)
> is platform-dependent and so is endianness.  More powerful?  Maybe, if

type safety, given a C struct with proper alignment

> Should we declare that arithmetics is dangerous?

We should use FORTRAN or Pascal, with overflow/underflow
trapping enabled for integer math and array access. :-)
