Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269240AbTCBQva>; Sun, 2 Mar 2003 11:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269241AbTCBQva>; Sun, 2 Mar 2003 11:51:30 -0500
Received: from cub.phpwebhosting.com ([66.33.48.250]:54277 "HELO
	cub.phpwebhosting.com") by vger.kernel.org with SMTP
	id <S269240AbTCBQv1> convert rfc822-to-8bit; Sun, 2 Mar 2003 11:51:27 -0500
From: "Jared Daniel J. Smith" <linux@trios.org>
To: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.6 (1006) - Licensed Version
Date: Sun, 2 Mar 2003 10:56:59 -0800
Subject: Re: [PATCH] kernel source spellchecker
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20030302165127Z269240-29902+1551@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding these two cautious comments:

==========================================================================
I wouldn't go that far. Better give a list of speling mistakes (file/line)
and fix them by hand. It won't need to be done more than occasionally, so
the overhead is not too bad. --Dr. Horst H. von Brand 

It might also be worth adding a list of 'suspect' spellings -- which
require human intervention. Such items might include 'indices=indexes'
and 'erratum=errata' although you can't do it automatically because
sometimes the right-hand side is actually correct. --David Woodhouse
==========================================================================

I fully agree.

I have tried to automatically spell-check long, complex texts for years,
with numerous algorithms; all of them fail for one reason or another,
and I find that the only proper way to do it is the tedious work by hand.

Even a single lost pun because of overenthusiastic spellchecking is
not worth the cleanup. I would prefer to see typos than lose a single
intentional 'misspelling'. It would be best if you posted all changes 
somewhere so that they could be verified manually.

Consider the following:

alignment=alignement
alignmement is French; is this intentional?

constants=konstants
konstants is German; is this intentional?

consumer=comsumer
comsumer is a neologism: http://www.firstmonday.dk/issues/issue5_5/henshall/

Converted=Coverted
is it a pun on something 'hidden' or is it something transformed?

descriptor=decriptor,desciptor
is it descriptor or decrypter?

invocation=invokation
invokation is German; is this intentional?

negative=negativ
negativ is a legitimate non-English word; is this intentional?

signaled=signalled
signaling=Signalling
signaling=signalling
signalled is a legitimate alternate spelling of signaled.

succeeded=succeded
succeded could also be a typo for 'succeed'

through=throught,throuth
throught could also be a typo for 'thought'

writable=writeable
writeable is a legitimate alternate spelling of writable

Thank you,

-Jared


