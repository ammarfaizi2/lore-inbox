Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318561AbSGaXiq>; Wed, 31 Jul 2002 19:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318575AbSGaXiq>; Wed, 31 Jul 2002 19:38:46 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61635 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318561AbSGaXip>;
	Wed, 31 Jul 2002 19:38:45 -0400
Date: Wed, 31 Jul 2002 19:42:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Pavel Machek <pavel@ucw.cz>, Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
In-Reply-To: <15688.27022.143541.447952@wombat.chubb.wattle.id.au>
Message-ID: <Pine.GSO.4.21.0207311852330.8505-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Aug 2002, Peter Chubb wrote:

> >>>>> "Alexander" == Alexander Viro <viro@math.psu.edu> writes:
> 
> Alexander> On Thu, 1 Aug 2002, Peter Chubb wrote:
> 
> Alexander> What the bleedin' hell is wrong with <name> <start> <len>\n
> Alexander> - all in ASCII?  Terminated by \0.  No need for flags, no
> Alexander> need for endianness crap, no need to worry about field
> Alexander> becoming too narrow...
> 
> I guess as it won't be used it for booting that'd be fine...  except I
> really *don't* like the idea of any kind of parser in the kernel

Please.  It's ~6 lines of loop.  And if somebody can't write a "parser"
of such kind correctly, I really don't like the idea of having his
code in the kernel - failing C101 doesn't inspire a lot of confidence.

And I don't see what's the problem on the boot side - finding first entry
with name that starts with (say it) '*', skipping to next space and
converting the following digits into a number...  <shrug>

