Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129859AbRAIVbe>; Tue, 9 Jan 2001 16:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRAIVbZ>; Tue, 9 Jan 2001 16:31:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39302 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131751AbRAIVbK>;
	Tue, 9 Jan 2001 16:31:10 -0500
Date: Tue, 9 Jan 2001 13:13:52 -0800
Message-Id: <200101092113.NAA05515@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: sct@redhat.com
CC: mingo@elte.hu, hch@caldera.de, riel@conectiva.com.br, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org, sct@redhat.com
In-Reply-To: <20010109142542.G4284@redhat.com> (sct@redhat.com)
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010109122810.A3115@caldera.de> <Pine.LNX.4.30.0101091241490.2424-100000@e2> <20010109142542.G4284@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 9 Jan 2001 14:25:42 +0000
   From: "Stephen C. Tweedie" <sct@redhat.com>

   Perhaps tcp can merge internal 4K requests, but if you're doing udp
   jumbograms (or STP or VIA), you do need an interface which can give
   the networking stack more than one page at once.

All network protocols can use the current interface and get the result
you are after, see MSG_MORE.  TCP isn't "special" in this regard.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
