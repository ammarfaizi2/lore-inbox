Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAKAVV>; Wed, 10 Jan 2001 19:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbRAKAVL>; Wed, 10 Jan 2001 19:21:11 -0500
Received: from uclink4.Berkeley.EDU ([128.32.25.39]:36104 "EHLO
	uclink4.berkeley.edu") by vger.kernel.org with ESMTP
	id <S129431AbRAKAVB>; Wed, 10 Jan 2001 19:21:01 -0500
Message-ID: <3A5CFE41.D6064638@uclink4.berkeley.edu>
Date: Wed, 10 Jan 2001 16:28:49 -0800
From: Jeremy Huddleston <jeremyhu@uclink4.berkeley.edu>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with module versioning in 2.4.0
In-Reply-To: <E14GVR1-0001J9-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well in any case, the problem was solved by my turning off module
versioning.  Regardless of how and why.  All other things being equal
(as in the .config I provided) CONFIG_MODVERSIONS=y produces the errors
reported (PCMCIA not working, and unix.o not loading) and when it is not
defined, everything works smoothly.

Alan Cox wrote:
> 
> > See below for my origional problem.  It seems the problem lies in the
> > module versioning option.
> 
> Not quite
> 
> > When the system boots, I am spammed with the following line:
> > insmod: /lib/modules/2.4.0/kernel/net/unix/unix.o: insmod net-pf-1
> > failed
> 
> What happens is this
> 
> kernel needs unix sockets
> kernel invokes modprobe
> modprobe opens a unix socket
>         kernel needs unix sockets
>         kernel invokes modprobe
>                 .....

-- 

---- A notice to spammers ----
Unsolicited electronic mail advertisements to my email address is
strictly prohibited. Pursuant to California Business and Professions
Code, Section 17538.45, senders of unsolicited electronic mail
advertisements to me may be subject to a civil penalty of $50 per
message plus attorney's fees.

CBPC 17538.45 provides that 
(c)  No individual, corporation, or other entity shall use or cause to
be used, by initiating an unsolicited electronic mail advertisement, an
electronic mail service provider's equipment located in this state in
violation of that electronic mail service provider's policy prohibiting
or restricting the use of its equipment to deliver unsolicited
electronic mail advertisements to its registered users. [...] 

(f) (1) In addition to any other action available under law, any
electronic mail service provider whose policy on unsolicited electronic
mail advertisements is violated as provided in this section may bring a
civil action to recover the actual monetary loss suffered by that
provider by reason of that violation, or liquidated damages of fifty
dollars ($50) for each electronic mail message initiated or delivered in
violation of this section, up to a maximum of twenty-five thousand
dollars ($25,000) per day, whichever amount is greater. 
    (2) In any action brought pursuant to paragraph (1), the court may
award reasonable attorney's fees to a prevailing party. 

The computer equipment which host my email server are located the State
of California, and CBPC 17538.45 is applicable to them.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
