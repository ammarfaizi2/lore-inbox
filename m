Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131482AbRAFEwA>; Fri, 5 Jan 2001 23:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131484AbRAFEvu>; Fri, 5 Jan 2001 23:51:50 -0500
Received: from holomorphy.com ([216.36.33.161]:1551 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S131482AbRAFEvk>;
	Fri, 5 Jan 2001 23:51:40 -0500
Date: Fri, 5 Jan 2001 20:51:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: ppp_generic labels
Message-ID: <20010105205134.C27068@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In certain situations, it's possible for one of the jump labels in
drivers/net/ppp_generic.c to get mangled by a macro, causing a failure
in compilation. The following patch ameliorates this somewhat:


diff -r -N linux/drivers/net/ppp_generic.c linux.wli/drivers/net/ppp_generic.c
2345c2345
< 		goto outw;
---
> 		goto ppp_outw;
2364c2364
<  outw:
---
>  ppp_outw:

Many of the jump labels therein also appear nameclash prone; I'm
tempted to prefix them all with "ppp_". If this is only a symptom of a
deeper problem, and should not be done, my apologies for the bandwidth.

Cheers,
Bill
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
