Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132595AbRDKPBK>; Wed, 11 Apr 2001 11:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132600AbRDKPBA>; Wed, 11 Apr 2001 11:01:00 -0400
Received: from mx0.gmx.net ([213.165.64.100]:61174 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S132595AbRDKPAv>;
	Wed, 11 Apr 2001 11:00:51 -0400
Date: Wed, 11 Apr 2001 17:00:45 +0200 (MEST)
From: Andreas Franck <afranck@gmx.de>
To: David Howells <dhowells@cambridge.redhat.com>
Cc: dhowells@cambridge.redhat.com, torvalds@transmeta.com, andrewm@uow.edu.au,
        bcrl@redhat.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
In-Reply-To: <16847.987000228@warthog.cambridge.redhat.com>
Subject: Re: [PATCH] 2nd try: i386 rw_semaphores fix
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0000112505@gmx.net
X-Authenticated-IP: [137.226.38.42]
Message-ID: <24940.987001245@www17.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

> I've been discussing it with some other kernel and GCC people, and they
> think
> that only "memory" is required.

Hmm.. I just looked at my GCC problem report from December, perhaps you're
interested, too:

http://gcc.gnu.org/ml/gcc-bugs/2000-12/msg00554.html

The example in there compiles out-of-the box and is much easier to
experiment on than the whole kernel :-)

It should reflect the situation in the kernel as of December 2000, where no
outputs were declared at all.

I can try this examples again with current GCC snapshots and will see if I
can find a working solution without reserving more registers.

> Apart from the risk of breaking it, you mean? Well, "=m" seems to reserve
> an
> extra register to hold a second copy of the semaphore address, probably
> since
> it thinks EAX might get clobbered.
> 
> Also, as a minor point, it probably ought to be "+m" not "=m".

Perhaps, I'm no real expert on this things, and "=m" worked for me, so
I used it :)

Greetings,
Andreas

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

