Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbTHSTDK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTHSTDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:03:04 -0400
Received: from granite.aspectgroup.co.uk ([212.187.249.254]:61684 "EHLO
	letters.pc.aspectgroup.co.uk") by vger.kernel.org with ESMTP
	id S261243AbTHSTAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:00:54 -0400
Message-ID: <353568DCBAE06148B70767C1B1A93E625EAB5F@post.pc.aspectgroup.co.uk>
From: Richard Underwood <richard@aspectgroup.co.uk>
To: "'David S. Miller'" <davem@redhat.com>
Cc: skraw@ithnet.com, willy@w.ods.org, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: RE: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Tue, 19 Aug 2003 20:00:44 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote: 
> > 	IP packets you mean? You don't? ;) It would depend on why you're
> > doing it naturally. Mostly, I'd have thought that if a host 
> doesn't have an
> > IP number it doesn't get to use ARP.
> 
> Of course it gets to use ARP, nothing prevents this.
> 
> If I know that IP X has my configuration information, I
> have every right to send X a packet from zero-net to
> ask for that information before I have any IP addresses
> attached to the interface.
> 
	Ick! And how is IP X going to get the information back? Broadcast
it, too? Here was me thinking that protocols like BOOTP and DHCP were
appropriate for this.

	If you are going to send from 0.0.0.0, then I assume there's
something in the ARP standard to say "don't cache this ARP request" - I must
have missed it. If so, that's a special case - no need to spoil things
elsewhere, though.

> Also, when one specifies a specific device in an output
> address and we cannot find the IP part of the address
> in the routing tables, we still procure a valid route for
> the requester.
> 
	Well, what do you do currently? If the packet you're routeing came
from another host, there's no way in hell you can use their IP address in an
ARP request ... is there? I certainly hope you don't go that far!!!

	If it's a locally generated packet, then the next hop must be on the
same subnet as the address it's coming from - there's your IP number.

> Besides normal IP addresses, multicast tools use these
> facilities.
> 
	Multicast uses ARP? That's news to me!

		Richard
