Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbRG1TMm>; Sat, 28 Jul 2001 15:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267014AbRG1TMd>; Sat, 28 Jul 2001 15:12:33 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:22277 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S267009AbRG1TMU>;
	Sat, 28 Jul 2001 15:12:20 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107281912.XAA17362@ms2.inr.ac.ru>
Subject: Re: [PATCH] Inbound Connection Control mechanism: Prioritized Accept
To: samudrala@us.ibm.com (Sridhar Samudrala)
Date: Sat, 28 Jul 2001 23:12:05 +0400 (MSK DST)
Cc: alan@lxorguk.ukuu.org.uk, samudrala@us.ibm.com,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        lartc@mailman.ds9a.nl, diffserv-general@lists.sourceforge.net,
        rusty@rustcorp.com.au
In-Reply-To: <Pine.LNX.4.21.0107271140330.14328-100000@w-sridhar2.des.sequent.com> from "Sridhar Samudrala" at Jul 27, 1 12:55:25 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> Low priority connections can clog the accept queue only when there are no
> high priority connection requests coming along. As soon as a slot becomes empty
> in the accept queue, it becomes available for a high priority connection.

And in presence of persistent low priority traffic, high priority connection
will not have any chances to take this slot. When high priority connection
arrives all the slots are permanently busy with low ones.

> If that happens, TCP SYN policing can be employed to limit the rate of low 
> priority connections getting into accept queue. 

After this your patch is not required at all. :-)

All the effect is a bit better latency, not a big win.


> dropped simply because there is no room for that class although there is room 
> for higher priority classes and there are no incoming higher priority 
> connections. 

ABC of resource control. If you have finite resource and want to give
better service to class A, you must reserve for it some bits of resource
or must be able to preempt other classes.

Alexey
