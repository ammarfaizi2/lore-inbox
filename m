Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272324AbTHSS2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272309AbTHSSZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:25:52 -0400
Received: from granite.aspectgroup.co.uk ([212.187.249.254]:62965 "EHLO
	letters.pc.aspectgroup.co.uk") by vger.kernel.org with ESMTP
	id S272975AbTHSSQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:16:36 -0400
Message-ID: <353568DCBAE06148B70767C1B1A93E625EAB5E@post.pc.aspectgroup.co.uk>
From: Richard Underwood <richard@aspectgroup.co.uk>
To: "'David S. Miller'" <davem@redhat.com>
Cc: skraw@ithnet.com, willy@w.ods.org, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: RE: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Tue, 19 Aug 2003 19:16:18 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> > 	Which nicely sums up the bug, really.
> 
> Ok, then how would you propose to be able to send
> packets out an interface _before_ we have addresses
> assigned to it?
> 
	IP packets you mean? You don't? ;) It would depend on why you're
doing it naturally. Mostly, I'd have thought that if a host doesn't have an
IP number it doesn't get to use ARP.

> Linux allows that, and in fact it's a useful feature.
> 
> Consider MSG_DONTROUTE as well.
> 
	Irrelevant, ARP should stick to resolving Layer 2 issues, not be
misused as some Layer 3 routeing protocol.

> BTW, this ARP source address algorithm we use comes from
> ipv6, it would be instructive to go and see why they do
> things the way they do.
> 
	If you'd like to give me a reference, I'd be happy to look at the
spec. It doesn't matter where you got the concept from, though - it's
flawed.

		Richard
