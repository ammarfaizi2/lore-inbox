Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130195AbQLCPsn>; Sun, 3 Dec 2000 10:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbQLCPse>; Sun, 3 Dec 2000 10:48:34 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:48938 "EHLO
	amsmta04-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130195AbQLCPs2>; Sun, 3 Dec 2000 10:48:28 -0500
Date: Sun, 3 Dec 2000 17:25:33 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: David Ford <david@linux.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Matthew Kirkwood <matthew@hairy.beasts.org>, folkert@vanheusden.com,
        "Theodore Y Ts'o" <tytso@mit.edu>,
        Kernel devel list <linux-kernel@vger.kernel.org>, vpnd@sunsite.auc.dk
Subject: Re: /dev/random probs in 2.4test(12-pre3)
In-Reply-To: <3A295EA3.F0E47E9@linux.com>
Message-ID: <Pine.LNX.4.21.0012031721530.13254-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I know. Still leaves lot's of people that assume that reading /dev/random
> > will return data, or will block.
> >
> > I've seen lots of programs that will assume that if we request x bytes
> > from /dev/random it will return x bytes.
> 
> I find this really humorous honestly.  I see a lot of people assuming that if
> you write N bytes or read N bytes that you will have done N bytes.  There are
> return values for these functions that tell you clearly how many bytes were
> done.

Of course. Lesson one : check return values

> Any programmer who has evolved sufficiently from a scriptie should take
> necessary precautions to check how much data was transferred.  Those who
> don't..well, there is still tomorrow.
> 
> There is no reason to add any additional documentation.  If we did, we'd be
> starting the trend of documenting the direction a mouse moves when it's
> pushed and not to be alarmed if you turn the mouse sideways and the result is
> 90 degrees off.

random devices are different. If it request 10 bytes on random stuff, I
want 10 bytes. Anything less is a waste of the read, because I need 10
bytes.

At least, in my opinion.

Anyone has an insight how other *NIX'es handle this ?

> -d


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
