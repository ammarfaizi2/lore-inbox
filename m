Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268354AbTCCFPO>; Mon, 3 Mar 2003 00:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268372AbTCCFPO>; Mon, 3 Mar 2003 00:15:14 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:53210 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S268354AbTCCFPG>; Mon, 3 Mar 2003 00:15:06 -0500
Message-ID: <3E62E9D3.60103@kegel.com>
Date: Sun, 02 Mar 2003 21:36:19 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux@trios.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel source spellchecker
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de>	<3E6101DE.5060301@	 kegel.com>	<1046546305.10138.415.camel@spc1.mesatop.com>	<3E6167B1.6040206@kegel.com> 	<3E617428.3090207@kegel.com>	<1046578585.2544.451.camel@spc1.mesatop.com>	<1046604117.12947.16.camel@imladris.demon.co.uk>	<1046612993.7527.472.camel@spc1.mesatop.com>  <3E62C0FF.1090700@kegel.com> <1046661777.7527.518.camel@spc1.mesatop.com>
In-Reply-To: <1046661777.7527.518.camel@spc1.mesatop.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jared Daniel J. Smith" wrote:
> Even a single lost pun because of overenthusiastic spellchecking is
> not worth the cleanup. I would prefer to see typos than lose a single
> intentional 'misspelling'. It would be best if you posted all changes 
> somewhere so that they could be verified manually.
> 
> Consider the following:
> 
> alignment=alignement
> alignmement is French; is this intentional?

No.  All three instances were english typos.

> constants=konstants
> konstants is German; is this intentional?

No.  All three instances were english typos.

> consumer=comsumer
> comsumer is a neologism: http://www.firstmonday.dk/issues/issue5_5/henshall/

That may be, but in the neologism, it seems to be usually partially capitalized,
and the C source sure looks like just a typo:
/* producer/comsumer pointers for Tx/Rx ring */

> Converted=Coverted
> is it a pun on something 'hidden' or is it something transformed?

Allan said it was a copy/paste error and should be fixed.

> descriptor=decriptor,desciptor
> is it descriptor or decrypter?

You be the judge:
      /* Initiliaze Transmit/Receive decriptor and CR3/4 */

All instances I saw were just english typos.

> invocation=invokation
> invokation is German; is this intentional?

No idea, seems to be gone in the current kernel source?

> negative=negativ
> negativ is a legitimate non-English word; is this intentional?

Where I spot-checked it, it was always just an English typo.

> signaled=signalled
> signaling=Signalling
> signaling=signalling
> signalled is a legitimate alternate spelling of signaled.

Thanks, fixed!

> succeeded=succeded
> succeded could also be a typo for 'succeed'
> 
> through=throught,throuth
> throught could also be a typo for 'thought'

Yes.  These will have to be hand-reviewed.  I do recommend absolutely
every change be hand-reviewed just in case.

> writable=writeable
> writeable is a legitimate alternate spelling of writable

You're right, though I had to dig to find a dictionary that agreed with you.

I've updated http://www.kegel.com/kerspell to remove the "signall*" and "writeable"
corrections.  (My stoplist already listed them as acceptable, fwiw.)

Thanks!
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

