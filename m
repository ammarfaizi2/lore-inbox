Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbTHSWOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 18:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbTHSWOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 18:14:41 -0400
Received: from granite.aspectgroup.co.uk ([212.187.249.254]:57336 "EHLO
	letters.pc.aspectgroup.co.uk") by vger.kernel.org with ESMTP
	id S261557AbTHSWOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 18:14:37 -0400
Message-ID: <353568DCBAE06148B70767C1B1A93E625EAB60@post.pc.aspectgroup.co.uk>
From: Richard Underwood <richard@aspectgroup.co.uk>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'David S. Miller'" <davem@redhat.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, willy@w.ods.org,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, Marcelo Tosatti <marcelo@conectiva.com.br>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Tue, 19 Aug 2003 23:12:38 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> One thing I agree with you about is that an ARP resolution for an
> address via one path should not block a resolution for it by another
> path since to begin with the two paths may be to different routers
> one of which is down.

Alan,

	I can't believe that you're advocating networking code where:

1) It's not predictable - the route of a packet depends on the ARP reply
generated due to a previous packet.

2) Linux will fail to communicate with the vast majority of routers under
some, fairly basic, conditions.

	I'm certain that Cisco (for example) won't change their ways. I
can't blame them, either - no one else does it this way and there's no good
reason for doing it like this either.

	I think I'm going to give up at this point because I know I'm not
going to get anywhere. A simple static ARP entry will fix my problems,
although I'd prefer a more generic solution.

	Good luck!

		Richard
