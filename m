Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280764AbRK2ASD>; Wed, 28 Nov 2001 19:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282211AbRK2ARx>; Wed, 28 Nov 2001 19:17:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32956 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280764AbRK2ARp>;
	Wed, 28 Nov 2001 19:17:45 -0500
Date: Wed, 28 Nov 2001 19:17:42 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Peter Waltenberg <pwalten@au1.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com>
Message-ID: <Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Nov 2001, Peter Waltenberg wrote:

> The problem was solved years ago.
> 
> "man indent"
> 
> Someone who cares, come up with an indentrc for the kernel code, and get it
> into Documentation/CodingStyle
> If the maintainers run all new code through indent with that indentrc
> before checkin, the problem goes away.
> The only one who'll incur any pain then is a code submitter who didn't
> follow the rules. (Exactly the person we want to be in pain ;)).

indent does _not_ solve the problem of:
	* buggers who think that MyVariableIsBiggerThanYourVariable is a
good name
	* buggers who define a function with 42 arguments and body being
	return (foo == bar) ? TRUE : FALSE;
	* buggers who add 1001st broken implementation of memcmp(), call it
FooTurdCompare and prepend it with 20x80 block comment.
	* buggers who use typedefs like WORD, DWORD, BYTE, IMANIDIOTSHOOTME
and other crap from the same source (OK, they don't write the last one
explicitly - not that it wasn't obvious from the rest of their, ahem, code).
	* buggers who use Hungarian notation for no good reason and come up
with structure fields that sound like street names from R'Lyeh
	* buggers who introduce wrappers for standard kernel stuff - like,
say it, typedef int Int32; and sprinkle their crap with per-architecture
ifdefs.
	* buggers who think that cpp is Just The Thing and produce turds that
would make srb cringe in disgust.

Al, -><- close to setting up a Linux Kernel Hall of Shame - one with names of
wankers (both individual and coprorat ones) responsible, their code and
commentary on said code...

