Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267677AbTBUXv6>; Fri, 21 Feb 2003 18:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267803AbTBUXv5>; Fri, 21 Feb 2003 18:51:57 -0500
Received: from rth.ninka.net ([216.101.162.244]:36523 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267677AbTBUXv5>;
	Fri, 21 Feb 2003 18:51:57 -0500
Subject: Re: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN
From: "David S. Miller" <davem@redhat.com>
To: John Bradford <john@grabjohn.com>
Cc: "Zephaniah E\\. Hull" <warp@mercury.d2dc.net>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200302212125.h1LLPgxE001759@81-2-122-30.bradfords.org.uk>
References: <200302212125.h1LLPgxE001759@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Feb 2003 16:47:02 -0800
Message-Id: <1045874822.25411.3.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-21 at 13:25, John Bradford wrote:
> What if the first SYN packet, or the response to it is lost, (which is
> more possible on congested links, which is when ECN would be most
> useful), and we disable ECN - then we loose out on functionality we
> could have, and the work around is actually detremental to
> performance.  Once 99% of internet hosts support ECN, we could be
> loosing more than we gain.

How do you know this is the reason for the lost SYN?  What if other
things caused the SYN to be dropped by some intermediate site?

All the workarounds for ECN blackholes violate the protocol and
cause more problems than they solve.

That is why we refuse to implement them, and this is why the ECN
RFCs mark the "suggested workarounds" as optional not required to
implement.

