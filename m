Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267732AbTBUV1V>; Fri, 21 Feb 2003 16:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267740AbTBUV1V>; Fri, 21 Feb 2003 16:27:21 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:18821 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S267732AbTBUV1S>; Fri, 21 Feb 2003 16:27:18 -0500
From: jordan.breeding@attbi.com
To: John Bradford <john@grabjohn.com>
Cc: warp@mercury.d2dc.net (Zephaniah E. Hull), Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN
Date: Fri, 21 Feb 2003 21:37:20 +0000
X-Mailer: AT&T Message Center Version 1 (Nov  5 2002)
X-Authenticated-Sender: am9yZGFuLmJyZWVkaW5nQGF0dGJpLmNvbQ==
Message-Id: <20030221212718Z267732-29901+771@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> As far as I can see, though, implementing this gains less than we
> stand to loose.
> 
> What if the first SYN packet, or the response to it is lost, (which is
> more possible on congested links, which is when ECN would be most
> useful), and we disable ECN - then we loose out on functionality we
> could have, and the work around is actually detremental to
> performance.  Once 99% of internet hosts support ECN, we could be
> loosing more than we gain.
> 
> If a site is unreachable, ECN can be disabled, and the RFC violating
> equipment is easily identified.  Automatically disabling ECN just
> hides the problem from the user, who might then not be benefiting from
> ECN, and will quite possibly accept the degraded performance as
> normal.
> 
> John.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I think they may have been talking about disabling ECN capabilities for the packets which never got responded to, what is the loss if 1% of your overall traffic has to be re-transmitted to work but the other 99% just works and you never have to turn ECN off with the sysctl at all?  I think they might have been going for something like this:

http://marc.theaimsgroup.com/?l=linux-kernel&m=102926352817528&w=2 which was brought on by this:

http://marc.theaimsgroup.com/?l=linux-kernel&m=102919814321938&w=2

Jordan
