Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRA2Xbm>; Mon, 29 Jan 2001 18:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129798AbRA2Xbb>; Mon, 29 Jan 2001 18:31:31 -0500
Received: from webmail.metabyte.com ([216.218.208.53]:13319 "EHLO
	webmail.metabyte.com") by vger.kernel.org with ESMTP
	id <S129532AbRA2XbM>; Mon, 29 Jan 2001 18:31:12 -0500
Message-ID: <3A75F4D7.D7957633@metabyte.com>
Date: Mon, 29 Jan 2001 14:55:19 -0800
From: Pete Zaitcev <zaitcev@metabyte.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Maxwell strikes the heart (ECN: Clearing the air)
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jan 2001 22:55:46.0894 (UTC) FILETIME=[9DF72EE0:01C08A46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Gregory Maxwell (greg@linuxpower.cx)
> Date: Sun Jan 28 2001 - 14:42:04 EST 
> 
> On Sun, Jan 28, 2001 at 01:29:52PM +0000, James Sutherland wrote: 
> > > There is nothing silly with the decision, davem is simply a modern day 
> > > internet hero. 
> > 
> > No. If it were something essential, perhaps, but it's just a minor 
> > performance tweak to cut packet loss over congested links. It's not 
> > IPv6. It's not PMTU. It's not even very useful right now! 
> 
> No. ECN is essential to the continued stability of the Internet. Without 
> probabilistic queuing (i.e. RED) and ECN the Internet will continue to have 
> retransmit synchronization and once congested stay congested until people get 
> frustrated and give it up for a little bit. 
> 
> It's a real issue, and it's actually important to have it implemented. It's 
> not just a performance hack. 

I always "knew" that the stability of the Internet is secured by the
exponential backoff in TCP. A small packet loss on uncongested links
is a part of this technique, and it existed long before ATM studies
produced RED (which infiltrated backwards). It also requires sending
stacks to "give up for a little bit" (actually to give up a lot, and
together with the slow start it produced the well known "saw" of the
window size).

So far I fail to see how a repainted NAK, kludged into a NAKless protocol,
would improve stability of the Internet. If anything, it is going to
exaggerate traffic oscillations. I would appreciate couple of links
to reputable studies or discussions on the subject.

-- Pete
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
