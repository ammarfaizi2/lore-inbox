Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278591AbRJSSsE>; Fri, 19 Oct 2001 14:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278594AbRJSSry>; Fri, 19 Oct 2001 14:47:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26758 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278591AbRJSSrn>;
	Fri, 19 Oct 2001 14:47:43 -0400
Date: Fri, 19 Oct 2001 14:48:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Albert Bartoszko <albertb@nt.kegel.com.pl>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12
In-Reply-To: <Pine.LNX.4.33.0110191527430.2675-200000@bellatrix.tat.physik.uni-tuebingen.de>
Message-ID: <Pine.GSO.4.21.0110191422570.24783-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Oct 2001, Richard Guenther wrote:

> Hi Linus,
> 
> As Al pissed me off again with complaining about binfmt_misc, please
> apply the attached patch which corrects the 'not C code' line and
> fixes the problem Albert noticed. This doesnt fix various assumptions
> about the /proc code that were either valid at the time of writing
> binfmt_misc or badly/not documented.

Like, say it, "thou shalt not dereference user-supplied pointers for verily,
copy_from_user() is there for purpose"?

Or "tons of blind sprintf() calls can really ruin your day when you overflow
the buffer"?

Or that checking the values of arguments, while a noble thing, should
be done _before_ you use them?

Or, say it, one about meaning of
        if ((count == 1) && !(buffer[0] & ~('0' | '1'))) {
not being the same as
        if (count == 1 && (buffer[0] == '0' || buffer[0] == '1')) {
Darn that Ritchie guy - he should've documented that stuff.  Oh, wait -
he had actually done that...

Please, learn C.  Then learn some basic stuff about kernel programming.
Then feel free to start mouthing off.

As for the version in -ac and maintaining it - sure I will.


