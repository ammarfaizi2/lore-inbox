Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272628AbTHSSNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272584AbTHSSM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:12:57 -0400
Received: from granite.aspectgroup.co.uk ([212.187.249.254]:2291 "EHLO
	letters.pc.aspectgroup.co.uk") by vger.kernel.org with ESMTP
	id S272871AbTHSSFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:05:17 -0400
Message-ID: <353568DCBAE06148B70767C1B1A93E625EAB5D@post.pc.aspectgroup.co.uk>
From: Richard Underwood <richard@aspectgroup.co.uk>
To: "'David S. Miller'" <davem@redhat.com>,
       Stephan von Krawczynski <skraw@ithnet.com>
Cc: willy@w.ods.org, alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: RE: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Tue, 19 Aug 2003 19:05:13 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> 
> In the ARP request we are using the source address in the packet we
> are building for output.
> 
	Well, you shouldn't be! The ARP request represents all FUTURE
packets being sent out that interface, not just the one single packet that
happened to kick of this ARP request.

> If ARP doesn't work using that source address, we can only assume IP
> communication is not possible either.
> 
	That's clearly not a valid assumption. For a start it precludes IP
routeing, but I've also demonstrated it not to be the case with a simple
multi-homed server.

	Thanks,

		Richard
