Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbUD3UsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUD3UsC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUD3UrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:47:19 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:38157 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265117AbUD3UnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:43:00 -0400
Message-ID: <4092BB75.7050400@techsource.com>
Date: Fri, 30 Apr 2004 16:47:49 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>, Hua Zhong <hzhong@cisco.com>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       koke@sindominio.net, "'Rusty Russell'" <rusty@rustcorp.com.au>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
Subject: A compromise that could have been reached.  Re: [PATCH] Blacklist
 binary-only modules lying about their license
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org> <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
In-Reply-To: <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something occurred to me...

It does take some time to get patches to propogate onto people's 
computers.  Linuxant has the problem that they have to be able to work 
in lots of different already-deployed kernels.

I get the impression that Linuxant attempts to load and try a large 
number of drivers in order to detect hardware.  While that isn't 
necessarily the best way to probe for devices, I can see why it would be 
unpleasant to have numerous "taint" messages print out in the general case.

The best solution to this would be both legal (in the sense of them 
being licensed to do this) and solve Linuxant's problem.  How to do this?


Linuxant could have posed this problem to LKML and gotten permission to 
do something "questionable", which is what I am going to suggest:

First:   Do the "GPL\0" thing with the permission of LKML members, 
conditioned on the next two steps.

Second:  Make the Linuxant loader program print out a message that 
explains to users that the kernel is really being tainted, even though 
it doesn't look that way, and also that same message needs to get into 
appropriate system logs.

Third:   Find some way to force on the "tainted" flag in the kernel 
after all the module load attempts have been finished.


I'm not declaring this to be THE solution   It might be crap.  But the 
Linux community does enjoy cooperating with people who are trying to do 
good things and need help.  An argument can be made that there is some 
benefit to what Linuxant does, and that argument is strong enough that 
enough people would probably agree to this sort of compromize.


In fact, in my opinion, if I were a major kernel contributor, I wouldn't 
mind the "questionable workaround" at all if the consequences of it were 
deal with by forcing the "tainting" flag on after the tainting flag had 
been defeated.

Make sense?

