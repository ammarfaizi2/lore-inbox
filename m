Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLAIfW>; Fri, 1 Dec 2000 03:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQLAIfC>; Fri, 1 Dec 2000 03:35:02 -0500
Received: from fscked.org ([198.88.183.227]:17418 "EHLO fscked.org")
	by vger.kernel.org with ESMTP id <S129226AbQLAIew>;
	Fri, 1 Dec 2000 03:34:52 -0500
Date: Fri, 1 Dec 2000 01:58:46 -0600
From: Mike Perry <mikepery@is.so.fscked.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.17 IP masq bug
Message-ID: <20001201015846.A27594@is.so.fscked.org>
Mail-Followup-To: Mike Perry <mikepery@is.so.fscked.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0012010905400.966-100000@u>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0012010905400.966-100000@u>; from ja@ssi.bg on Fri, Dec 01, 2000 at 09:13:38AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Julian Anastasov (ja@ssi.bg):

> On Fri, 1 Dec 2000, Mike Perry wrote:
> 
> > The bug:
> > When I make a connection from any internal node to the one of the other
> > externally routed machines in my lab, then close it, this external machine then
> > becomes unreachable to successive connects from that node.
> 
> 	This problem can be caused from the ICMP redirect. Can these
> commands help?
> 
> echo 0 > /proc/sys/net/ipv4/conf/all/send_redirects
> echo 0 > /proc/sys/net/ipv4/conf/eth0/send_redirects

Why yes they do. Problem seems to be completely solved. *blush* 
At least it wasn't in the HOWTO.

Thanks!

-- 
Mike Perry
http://so.fscked.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
