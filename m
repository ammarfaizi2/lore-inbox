Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVJFWYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVJFWYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 18:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbVJFWYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 18:24:48 -0400
Received: from free.hands.com ([83.142.228.128]:63961 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1751015AbVJFWYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 18:24:47 -0400
Date: Thu, 6 Oct 2005 23:24:39 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Michael Concannon <mike@concannon.net>
Cc: Chase Venters <chase.venters@clientec.com>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051006222439.GE10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <200510041840.55820.chase.venters@clientec.com> <20051005102650.GO10538@lkcl.net> <200510060005.09121.chase.venters@clientec.com> <43453E7F.5030801@concannon.net> <20051006192857.GV10538@lkcl.net> <4345855B.3@concannon.net> <20051006212001.GZ10538@lkcl.net> <43459CE4.7060509@concannon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43459CE4.7060509@concannon.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 05:53:40PM -0400, Michael Concannon wrote:

> I think someone already mentioned that the issue is that the delta 
> between an idealized NT registry (which has a few notable hurdles - see 
> above) and what we have to day is simply a matter of "KISS".  What do 
> you gain from complicating the system that cannot be gained with 
> visualization tools on top of what is there? 
 
 it is advocated that storing data in text format is easier
 to recover with a minimum of tools.

 if, as todd sabin's driver shows, you can present the binary data via a
 text-editable filesystem driver, then even _that_ argument goes away.

> Someone wants XML in /proc?  Well, that's just fabulous they can write a 
> virtual filesytem that accomplishes that on top what is there and leave 
> the rest of us out of it :-)  If what they do becomes indespensible for 
> a critical mass, then even better, we mount "xmlprocfs" in our future 
> systems and are fat dumb and happy.

 reiserfs already has had an XML plugin written for it, which resulted
 in the person it was written for thanking the author for writing the
 "best xml database they had ever seen".

 think structured storage and streams (which NTFS used to support, and
 which explorer.exe in nt 3.51 used to support before
 bill/someone-on-high ordered it to be taken out) and now apply that
 principle to XML instead.

> Back to your original point which seemed to be, at least to me, to try 
> to re-evaluate the portioning problem between 
> Hardware/Software/Drive/OS/User/Threads.  

 yes.  seems like ages ago.

> I agree, that the system 
> appears to be strained and chaotic with all OSes chasing an ever 
> increasing and impossibly large array of hardware and all-the while the 
> future is even more complex as it seemingly must be a heavily 
> parallelized future to compensate for the "end of Moore's law".  

 what - the constantly revised one, or the original one?

> Given 
> the hardware in question, though, I am not sure I that I see that Linux 
> should go to micro-kernels to solve the problem...

 i would be delighted to see #ifdef HAVE_L4_MICROKERNEL #endif in the
 linux source code.

 AS AN OPTION.

 that people could choose "bugger that damn l4 trash" or "bugger that
 monolithic trash" as they see fit.

 and the l4linux source code _is_ there for the linux kernel developers
 to pick up and incorporate.

 that they have not chosen to do so - even though it is GPL code -
 leaves me a little puzzled.

 
 
> <rant>
> It seems to me that the driver for "correcting" this is actually closer 
> to the hardware side...  I am flabbergasted as a hardware engineer that 
> at this point in time with the time elapsed between today and the first 
> PCs that things have evolved so little...
 
  ah _ha_.

  as a hardware engineer, what would _you_ like to see a
  modern parallel processor design have - that linux for that
  hardware would have an easy job of knocking the stuffing
  out of anything remotely attempting to come close to it?

  i.e. if you could have the proverbial cart before the
  proverbial horse, and could make decisions about the DESIGN
  of hardware - all of it - BEFORE it was dumped in your lap
  and you were basically impicitly told "we're giving you
  this for free and taking advantage of your willingness to go
  'cool hardware!  let's make it run linux".


  we've already had one suggestion: a CAS-n instruction (a SIMD
  compare-and-store) which can, according to the person who kindly
  suggested it, be used for managing doubly-linked lists.

  anyone got any more?

  want to send them to me, and i will summarise to those people that
  express an interest.

  [i _so_ want this thread to die].

> The same applies to the x86 instruction set - waded through that beast 
> (well all N volumes of it) recently?  WTF?  

 even _decoding_ the x86 instruction set, due to the massive
 number of exceptions / extensions, introduces significant
 instruction latency.
 
 a large amount of an x86 compatible processor is spent
 translating that crap into a simpler _internal_ microcode set
 of instructions.

 unberfrigginlievable.

 oh, these instructions are too slow.  _let's_ go an' add multimedia
 extensions.  *noooooooo.*

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
