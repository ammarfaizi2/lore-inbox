Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRBYPQ0>; Sun, 25 Feb 2001 10:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129360AbRBYPQQ>; Sun, 25 Feb 2001 10:16:16 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:54916 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129359AbRBYPQM>; Sun, 25 Feb 2001 10:16:12 -0500
Message-ID: <3A9920B6.393E63B2@coplanar.net>
Date: Sun, 25 Feb 2001 10:11:50 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New net features for added performance
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com> <3A98F417.C38A67BE@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

(kernel profile of TCP tx/rx)So, naively, the most which can be saved here by
optimising

> the skb and memory usage is 5% of networking load. (1% of
> system load @100 mbps)
>

For a local tx/rx.  (open question) What happens with
a router box with netfilter and queueing?  Perhaps
this type of optimisation will help more in that case?

think about a box with 4 1G NICs being able to
route AND do QoS per conntrack connection
(ala RSVP and such)

Really what I'm looking for is something like SGI's
STP (Scheduled Transfer Protocol).  mmap your
tcp recieve buffer, and have a card smart enough
to figure out header alignment, (i.e. know header
size based on protocol number) transfer only that,
let the kernel process it, then tell the card to DMA
the data from the buffer right into process memory.
(or other NIC)

Make it possible to have the performance of a
Juniper network processor + flexiblity of Linux.

