Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbTI1Rw3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 13:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbTI1Rw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 13:52:29 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.102]:2755 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262626AbTI1Rw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 13:52:27 -0400
Message-ID: <3F77203F.8010704@softhome.net>
Date: Sun, 28 Sep 2003 19:54:07 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030831
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] No Swap. Re: [BUG 2.6.90-test5] kernel shits itself with
 48mb ram under moderate load
References: <ArQ0.821.23@gated-at.bofh.it> <ArQ0.821.25@gated-at.bofh.it> <ArQ0.821.21@gated-at.bofh.it> <ArZC.8f1.9@gated-at.bofh.it> <3F75EC3B.4030305@softhome.net> <20030927202148.GA31080@k3.hellgate.ch> <3F76DCEC.60508@softhome.net> <Pine.LNX.4.58.0309281747460.13202@artax.karlin.mff.cuni.cz> <3F771893.1020405@softhome.net> <Pine.LNX.4.58.0309281922050.17752@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.58.0309281922050.17752@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:
> 
>>>
>>>Yes, it should. If you have 0.25GB, it can be copied into cache. If you
>>>have 0.125GB, it doesn't fit there.
>>
>>   So you want to say to effectively copy (or whatever) 40GB harddrive I
>>have to have 40GB of RAM? Ridiculous.
> 
> Other unices (Solaris, IRIX) don't have dynamic cache that resizes
> according to RAM, always copy data from disk to disk and so they are

   It is slow. But when someone compile something on our Linux cross 
compilation server - everyone else is out - "jerky" is not suffieciently 
hard word to describe how it works under load. (I hope 2.6 fixes this.)

   Sun Ultra 10 (Solaris 8) is magnitude slower, but when someone 
compiles something big - people still _*can*_ work on it. "find | xargs 
grep" is still ok. I notice usually background compilations by fact that 
:w takes visibly longer. But I can work.

   That's what matters. Try to work in vim if it is permanently get 
swaped out. _*Very*_ _*very*_ not nice.
   And there is no memory pressure - kernel just decided to enlarge I/O 
cache... 100% stupid.

   I personally prefer to have statical I/O cache - never saw it working 
reliably with dynamic allocation.

> order-of-magnitude slower than Linux. Did you ever tried to grep for
> symbols in linux source tree unpacked on Solaris box with 512MB RAM? ---
> it's just as slow as linux with very few RAM, because Solaris can't cache
> data in RAM.
> 

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

