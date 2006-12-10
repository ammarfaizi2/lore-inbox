Return-Path: <linux-kernel-owner+w=401wt.eu-S933059AbWLJVlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059AbWLJVlP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762646AbWLJVlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:41:15 -0500
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:3960 "EHLO
	smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762639AbWLJVlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:41:14 -0500
Date: Sun, 10 Dec 2006 22:41:09 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: optimalisation for strlcpy (lib/string.c)
Message-ID: <20061210214108.GF30197@vanheusden.com>
References: <20061210212350.GC30197@vanheusden.com>
	<20061210215504.GD47959@gaz.sfgoth.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210215504.GD47959@gaz.sfgoth.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Dec 11 21:32:58 CET 2006
X-Message-Flag: www.vanheusden.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Like the other patch (by that other person), I think it is faster to not
> > do a strlen first.
> Debatable.  You've replaced a call to the highly-optimized memcpy function
> with a byte-by-byte copy.  It's probably a wash performance wise (have you
> benchmarked?) and is certainly less clear.

I tested it outside the kernel.
The test source can be found here:
http://www.vanheusden.com/misc/kernel-strlcpy-opt-test.c


Folkert van Heusden

-- 
Feeling generous? -> http://www.vanheusden.com/wishlist.php
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
