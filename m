Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbQLAHq3>; Fri, 1 Dec 2000 02:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129639AbQLAHqU>; Fri, 1 Dec 2000 02:46:20 -0500
Received: from ja.ssi.bg ([193.68.177.189]:23556 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S129460AbQLAHqK>;
	Fri, 1 Dec 2000 02:46:10 -0500
Date: Fri, 1 Dec 2000 09:13:38 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: Mike Perry <mikepery@fscked.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.17 IP masq bug
Message-ID: <Pine.LNX.4.21.0012010905400.966-100000@u>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Fri, 1 Dec 2000, Mike Perry wrote:

> external net, so it can IP masq the other 14 machines. The machines are on a
> switch, and share a semi-switched network segment with a bunch of other
> external IP'd machines (we are all in the same lab, actually).
>
> The bug:
> When I make a connection from any internal node to the one of the other
> externally routed machines in my lab, then close it, this external machine then
> becomes unreachable to successive connects from that node.

	This problem can be caused from the ICMP redirect. Can these
commands help?

echo 0 > /proc/sys/net/ipv4/conf/all/send_redirects
echo 0 > /proc/sys/net/ipv4/conf/eth0/send_redirects


Regards

--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
