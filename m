Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129551AbQKHSYC>; Wed, 8 Nov 2000 13:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129647AbQKHSXw>; Wed, 8 Nov 2000 13:23:52 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:2310 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129551AbQKHSXf>; Wed, 8 Nov 2000 13:23:35 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC75@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>,
        Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, axp-list@redhat.com,
        linux-kernel@vger.kernel.org
Subject: RE: PCI-PCI bridges mess in 2.4.x
Date: Wed, 8 Nov 2000 10:22:50 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff-

> Also, should we be setting PCI_CACHE_LINE_SIZE for PCI devices as well
> as bridges?

If/when we do set PCI_CACHE_LINE_SIZE, please don't
set it to a hard-coded, inline constant, like 8 (e.g.),
like some drivers do.

Please use something like (PCI_CACHE_LINE_SIZE / 4)
instead.  ["/ 4" to convert bytes to "dwords" or
whatever, since the PCI_CACHE_LINE_SIZE register
is in 4-byte units.]

~Randy
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
----------------------------------------------- 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
