Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129585AbQLAKkP>; Fri, 1 Dec 2000 05:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129625AbQLAKj4>; Fri, 1 Dec 2000 05:39:56 -0500
Received: from indus-bh.indusriver.com ([63.81.64.2]:40951 "EHLO
	post.indusriver.com") by vger.kernel.org with ESMTP
	id <S129585AbQLAKjy>; Fri, 1 Dec 2000 05:39:54 -0500
Message-ID: <3A277808.153AFC0C@indusriver.com>
Date: Fri, 01 Dec 2000 05:06:00 -0500
From: Ben McCann <bmccann@indusriver.com>
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Julian Anastasov <ja@ssi.bg>
CC: Mike Perry <mikepery@fscked.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.17 IP masq bug
In-Reply-To: <Pine.LNX.4.21.0012010905400.966-100000@u>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm curious about how ICMP redirect is causing this problem.
Would you elaborate on how ICMP is involved?

-Ben McCann

Julian Anastasov wrote:
> 
>         Hello,
> 
> On Fri, 1 Dec 2000, Mike Perry wrote:
> 
> > external net, so it can IP masq the other 14 machines. The machines are on a
> > switch, and share a semi-switched network segment with a bunch of other
> > external IP'd machines (we are all in the same lab, actually).
> >
> > The bug:
> > When I make a connection from any internal node to the one of the other
> > externally routed machines in my lab, then close it, this external machine then
> > becomes unreachable to successive connects from that node.
> 
>         This problem can be caused from the ICMP redirect. Can these
> commands help?
> 
> echo 0 > /proc/sys/net/ipv4/conf/all/send_redirects
> echo 0 > /proc/sys/net/ipv4/conf/eth0/send_redirects
> 
> Regards
> 
> --
> Julian Anastasov <ja@ssi.bg>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Ben McCann                              Indus River Networks
                                        31 Nagog Park
                                        Acton, MA, 01720
email: bmccann@indusriver.com           web: www.indusriver.com 
phone: (978) 266-8140                   fax: (978) 266-8111
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
