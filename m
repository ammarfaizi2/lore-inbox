Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132004AbRAQRru>; Wed, 17 Jan 2001 12:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132061AbRAQRrj>; Wed, 17 Jan 2001 12:47:39 -0500
Received: from relay.dera.gov.uk ([192.5.29.49]:9853 "HELO relay.dera.gov.uk")
	by vger.kernel.org with SMTP id <S132004AbRAQRrU>;
	Wed, 17 Jan 2001 12:47:20 -0500
Message-ID: <XFMail.20010117174430.gale@syntax.dera.gov.uk>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <20010117183547.A2528@gruyere.muc.suse.de>
Date: Wed, 17 Jan 2001 17:44:30 -0000 (GMT)
From: Tony Gale <gale@syntax.dera.gov.uk>
To: Andi Kleen <ak@suse.de>
Subject: Re: IP defrag (was RE: ipchains blocking port 65535)
Cc: linux-kernel@vger.kernel.org, Jussi Hamalainen <count@theblah.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17-Jan-2001 Andi Kleen wrote:
> 
> Connection tracking always defrags as needed.
> masquerading/NAT/iptables 
> with connection tracking uses that.
> 
> This means that if any of these are enabled and your machine acts
> as a 
> router lots of CPU could get burned in defragmentation, and packets
> will not forwarded until all fragments arrived.

Hmm... ok, what if I'm on a single nic system using ipchains on the
input and want to always defrag before they hit the ipchains
filter, what settings would I need? No masq., no NAT. (bearing in
mind that ipchains differentiates between SYN+frag and noSYN+frag.

> 
> All very nasty, but unfortunately there is no alternative.
> 

Nasty but necessary. Such is life.

-tony


---
E-Mail: Tony Gale <gale@syntax.dera.gov.uk>
Isn't it nice that people who prefer Los Angeles to San Francisco live there?
		-- Herb Caen

The views expressed above are entirely those of the writer
and do not represent the views, policy or understanding of
any other person or official body.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
