Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbRBAWHB>; Thu, 1 Feb 2001 17:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129239AbRBAWGw>; Thu, 1 Feb 2001 17:06:52 -0500
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:46860 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S129130AbRBAWGl>;
	Thu, 1 Feb 2001 17:06:41 -0500
Date: Thu, 1 Feb 2001 22:06:24 +0000
From: Michael Pacey <michael@wd21.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3Com 3c523 in IBM PS/2 9585: Can't load module in kernel 2.4.1
Message-ID: <20010201220624.E340@kermit.wd21.co.uk>
In-Reply-To: <20010201193250.B340@kermit.wd21.co.uk> <E14ORB4-000571-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14ORB4-000571-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 01, 2001 at 21:21:59 +0000
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Nobody has fixed this driver for 2.4 yet

I sort of guessed this....
 
> > eth0: 3c523 adapter found in slot 3
> > eth0: 3Com 3c523 Rev 0xe at 0x1300
> > eth0: memprobe, Can't find memory at 0xc0000!
> > 3c523.c: No 3c523 cards found
> 
> Yep. Most probably it needs munging to use isa_memcpy_fromio and the like
> or ioremap.

Right... OK.... I'll leave that to someone else

> Are you willing to be test victim for fixes ?

Yes.

I must warn, however, that my testing may only get this detected and not
much else; the card seems to have some problems even in 2.2.17;
particularly, in NFS transfers it keeps saying NFS server not responding
then NFS server OK. The NFS server is fine. I had put this down to a dodgy
co-ax cable (I've run out of external TP transceivers) but I've replaced
the
cable and terminators, and it is still bad.

I've now got the machine working smoothly with a previously-thought-dead
3c529 (currently 2.2.17, planning to upgrade to 2.4.1 - any probs?)

However, pings in 2.2.17 with the 3c523 work fine with even large packet
size, so I'm not sure what's going on there.

The 3c529 was previously DOA. I cleaned the MCA contacts and wham! it
sprang into life. Perhaps I should try this with the 3c523 :)

So, I don't know if the 3c523 hardware is OK. Therefore my testing might be
of limited use. However, if you think it would help I'd be happy to be a
test bed for patches to 2.4.1. Let me know what to patch. I'm off work for
a week as of tomorrow lunchtime so the timing is pretty good :)

And if you think the NFS problems might be fixable, I'll be pleased to
keep the card out of the bucket.

--
Michael Pacey
michael@wd21.co.uk
ICQ: 105498469

wd21 ltd - world domination in the 21st century

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
