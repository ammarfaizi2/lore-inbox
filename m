Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269794AbUICUY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269794AbUICUY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269788AbUICUY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 16:24:26 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.68]:22996 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S269790AbUICUWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 16:22:18 -0400
Date: Fri, 03 Sep 2004 16:18:41 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [PATCH 2.6] watch64: generic variable monitoring system
In-reply-to: <20040903121657.355a6a8b@dell_ss3.pdx.osdl.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <200409031618.47521.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <200409031307.01240.jeffpc@optonline.net>
 <200409031319.24863.jeffpc@optonline.net>
 <20040903121657.355a6a8b@dell_ss3.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 03 September 2004 15:16, you wrote:
> - Seems like a big interface for a simple problem.

I agree that the interface could be simplified a lot, however I decided to 
make it as generic as possible so that any part of the kernel can use it. I 
also am contemplating whether it would make sense to remove the capability of 
setting the interval to any value, and just have all variables checked every 
WATCH64_INTERVAL.

> - Code doesn't match the kernel style (read Documentation/CodingStyle)

Agreed. I'm going submit a correction patch.

> - Does it really need RCU and seqlock, wouldn't one suffice

As far as I can tell, it does. RCU to protect the linked list, and seqlock to 
protect the internal 64-bit counter.

Jeff.
- -- 
Research, n.:
  Consider Columbus:
    He didn't know where he was going.
    When he got there he didn't know where he was.
    When he got back he didn't know where he had been.
    And he did it all on someone else's money.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBONGlwFP0+seVj/4RAlAFAJ9OiipyTpCGljodcwYgDSlXaWB3LACgnWLk
ZZLfkwnTFdsihHvTmfR+AuA=
=g5hE
-----END PGP SIGNATURE-----
