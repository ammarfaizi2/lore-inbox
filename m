Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130609AbRBAP2G>; Thu, 1 Feb 2001 10:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130611AbRBAP14>; Thu, 1 Feb 2001 10:27:56 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.138.204]:51215 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S130609AbRBAP1s>; Thu, 1 Feb 2001 10:27:48 -0500
Date: Thu, 1 Feb 2001 15:27:37 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Serious reproducible 2.4.x kernel hang
In-Reply-To: <20010201144052.B27009@sable.ox.ac.uk>
Message-ID: <Pine.LNX.4.30.0102011524590.30077-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Feb 2001, Malcolm Beattie wrote:

> Chris Evans writes:
> > I've just managed to reproduce this personally on 2.4.0. I've had a report
> > that 2.4.1 is also affected. Both myself and the other person who
> > reproduced this have SMP i686 machines, which may or may not be relevant.
> >
> > To reproduce, all you need to do is get my vsftpd ftp server:
> > ftp://ferret.lmh.ox.ac.uk/pub/linux/vsftpd-0.0.9.tar.gz
>
> I got this just before lunch too. I was trying out 2.4.1 + zerocopy
> (with netfilter configured off, see the sendfile/zerocopy thread for

[...]

I reproduced with 2.4.1.

> Looking at the kernel's EIP every so often to see what was going
> showed remove_wait_queue, add_wait_queue, skb_recv_datagram and
> wait_for_packet mostly. Random thought: if vsftpd did a sendfile and
> then exited, becoming a zombie, could there be a problem with
> tearing down a sendfile mapping? I'm off to read some code.

I get it simply doing CTRL-C at the ftp logon prompt. No sendfile has been
used at this point. Trying to distill a test case...

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
