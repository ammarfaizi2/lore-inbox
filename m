Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129261AbQKDRo6>; Sat, 4 Nov 2000 12:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129095AbQKDRos>; Sat, 4 Nov 2000 12:44:48 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:42511 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129057AbQKDRol>; Sat, 4 Nov 2000 12:44:41 -0500
Date: 04 Nov 2000 13:30:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7pChtmSXw-B@khms.westfalen.de>
In-Reply-To: <200011022106.WAA18428@ns.caldera.de>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3A01D463.9ADEF3AF@Rikers.org> <200011022106.WAA18428@ns.caldera.de>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hch@caldera.de (Christoph Hellwig)  wrote on 02.11.00 in <200011022106.WAA18428@ns.caldera.de>:

> In article <3A01D463.9ADEF3AF@Rikers.org> you wrote:
> > As is being discussed here, C99 has some replacements to the gcc syntax
> > the kernel uses. I believe the C99 syntax will win in the near future,
> > and thus the gcc syntax will have to be removed at some point. In the
> > interim the kernel will either move towards supporting both, or a
> > quantum jump to support the new gcc3+ compiler only. I am hoping a
> > little thought can get put into this such that this change will be less
> > painful down the road.
>
> BTW: the C99 syntax for named structure initializers is supported from
> gcc 2.7.<something> on. But a policy decision has been take to use
> gcc synta in kernel.

Just so everyone knows what we're talking about, some examples from C99:

33 EXAMPLE 9 Arrays can be initialized to correspond to the elements of an  
enumeration by using designators:

enum { member_one, member_two };
const char *nm[] = {
        [member_two] = "member two",
        [member_one] = "member one",
};

34 EXAMPLE 10 Structure members can be initialized to nonzero values  
without depending on their order:

div_t answer = {
        .quot = 2,
        .rem = -1
};

35 EXAMPLE 11 Designators can be used to provide explicit initialization  
when unadorned initializer lists might be misunderstood:

struct { int a[3], b; }
w[] = {
        [0].a = {1},
        [1].a[0] = 2
};


MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
