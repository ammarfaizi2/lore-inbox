Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVBPVzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVBPVzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVBPVzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:55:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:60614 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262093AbVBPVzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:55:03 -0500
X-Authenticated: #8956447
Subject: Re: [Problem] slow write to dvd-ram since 2.6.7-bk8
From: Droebbel <droebbel.melta@gmx.de>
To: Tino Keitel <tino.keitel@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050214111819.GA7691@dose.home.local>
References: <1108301794.9280.18.camel@localhost.localdomain>
	 <20050213142635.GA2035@animx.eu.org>
	 <20050214085320.GA4910@dose.home.local>
	 <1108376734.9495.8.camel@localhost.localdomain>
	 <20050214105332.GA7163@dose.home.local>
	 <1108379351.9495.22.camel@localhost.localdomain>
	 <20050214111819.GA7691@dose.home.local>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 22:55:00 +0100
Message-Id: <1108590900.7407.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.5 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some new information:

2.6.7 is ok, 2.6.7-mm2 is not ok, 2.6.7 with just the linus-patch from
mm2 is ok, 2.6.7 with linus.patch from mm3 isn't.
So I took some of the patches from the broken-out mm2 and tested them
seperately.

The vmscan-dont-reclaim-too-many-pages.patch led to the said reduction
of writing speed. I reverse-applied it to 2.6.8.1, where it seems to
solve the problem. I also reverse-applied it to the current prepatched
Ubuntu-2.6.10. It helped a bit there. Some new errors since 2.6.8, as it
seems... getting depressing a bit, this whole thing.

If you are using 2.6.7-mm1, there is another patch with even greater
impact: abs-fix.patch. Take the same + abs-fix-fix.patch from mm2.

If you might have a look at the vmscan-dont-reclaim-too-many-pages.patch
from
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm2/broken-out/, maybe you will find out something.

Comparing the abs-fix patches from mm1 and mm2 might also help.

This is all I can do for now.

Regards 

David


