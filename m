Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133027AbRADNRA>; Thu, 4 Jan 2001 08:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132950AbRADNQu>; Thu, 4 Jan 2001 08:16:50 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:14067 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S133027AbRADNQf>; Thu, 4 Jan 2001 08:16:35 -0500
Message-ID: <3A547911.C5320C69@uow.edu.au>
Date: Fri, 05 Jan 2001 00:22:25 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mzyngier@freesurf.fr
CC: linux-kernel@vger.kernel.org, linux-irda@pasta.cs.UiT.No
Subject: Re: [IrDA+SMP] Lockup in handle_IRQ_event
In-Reply-To: <wrpzoh89t1c.fsf@hina.wild-wind.fr.eu.org> <3A53B356.32353C01@uow.edu.au>,
		Andrew Morton's message of "Thu, 04 Jan 2001 10:18:46 +1100" <wrpsnmz63kv.fsf@hina.wild-wind.fr.eu.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc ZYNGIER wrote:
> 
> Using this patch, the machine is solid, and I've been able to play
> with my phone as much as I wanted to (well... while the battery
> lasted, anyway... ;-).
> 
> Here's the patch (which of course includes yours). If it's proved to
> be correct, it would be a good idea to summit it to Linus while
> prerelease is still open to fixes.
> 

Looks fine, Marc.

I note that hashbin_unlock() does a restore_flags() where
the flags were passed in as an argument.  This doesn't
work on SPARC.

Conveniently, hashbin_unlock() is not actually used anywhere.

So I suggest you kill that function altogether, test
it, slap your name on it and send it to da man :)

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
