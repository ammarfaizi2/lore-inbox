Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266306AbRGXBDj>; Mon, 23 Jul 2001 21:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266417AbRGXBD3>; Mon, 23 Jul 2001 21:03:29 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:29095 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S266306AbRGXBDT>;
	Mon, 23 Jul 2001 21:03:19 -0400
Message-ID: <3B5CC947.2E027588@candelatech.com>
Date: Mon, 23 Jul 2001 18:03:03 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: sourav@csa.iisc.ernet.in, linux-kernel@vger.kernel.org
Subject: Re: Arp problem
In-Reply-To: <Pine.SOL.3.96.1010724011120.10879A-100000@kohinoor.csa.iisc.ernet.in> <3B5C855C.959ABB@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Chris Friesen wrote:
> 
> Sourav Sen wrote:
> >
> > Hi,
> >         I have a machine with multiple network cards with different IP
> > addresses assigned. All are in the same network (I need this for
> > whatever reason). But when a arp request
> > appears on the wire for any of these IP addresses, all the interfaces go
> > ahead and give their respective ethernet addresses against that IP
> > address (I have seen this with tcpdump). This causes the other machines to
> > pick up wrong ethernet address against the IP address.
> 
> Yep, this is the default behaviour since multiple links on one subnet is
> an unusual situation (I ran into the same problem).  The solution is to apply
> the arpfilter patch to the kernel, recompile, and then write a 1 to
> /proc/sys/net/ipv4/conf/all/arp_filter to enable it for all interfaces.
> This patch enforces that NICs will only respond to arps for IP addresses
> that they own.

The arp-filter patch is in the kernel since about 2.4.4, so you just need
to turn it on...

Ben

> 
> --
> Chris Friesen                    | MailStop: 043/33/F10
> Nortel Networks                  | work: (613) 765-0557
> 3500 Carling Avenue              | fax:  (613) 765-2986
> Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
