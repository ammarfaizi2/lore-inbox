Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135222AbREFIkk>; Sun, 6 May 2001 04:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135217AbREFIka>; Sun, 6 May 2001 04:40:30 -0400
Received: from ns.suse.de ([213.95.15.193]:29713 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135216AbREFIkL>;
	Sun, 6 May 2001 04:40:11 -0400
Date: Sun, 6 May 2001 10:34:50 +0200
From: Andi Kleen <ak@suse.de>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: "David S. Miller" <davem@redhat.com>, Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] arp_filter patch for 2.4.4 kernel.
Message-ID: <20010506103450.A29403@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.33.0105051550000.20277-100000@twinlark.arctic.org> <Pine.LNX.4.33.0105051556280.20277-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0105051556280.20277-100000@twinlark.arctic.org>; from dean-list-linux-kernel@arctic.org on Sat, May 05, 2001 at 03:57:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 03:57:38PM -0700, dean gaudet wrote:
> also -- isn't it kind of wrong for arp to respond with addresses from
> other interfaces?

Usually it makes sense, because it increases your chances of successfull
communication. IP addresses are owned by the complete host on Linux, not by 
different interfaces.

For some weirder setups (most of them just caused by incorrect routing
tables, but also a few legimitate ones; including incoming load balancing
via multipath routes) it causes problems, so arpfilter was invented to 
sync ARP replies with the routing tables as needed.

> 
> what if ip_forward is 0?  or if there's some other sort of routing policy
> in effect?

ARP filter has nothing to do with forwarding.

There is magic ARP proxying if linux knows the answer to an ARP request
on a different interface, but it's a completely independent thing.


-Andi
