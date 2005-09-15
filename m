Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbVIOGMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbVIOGMB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOGMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:12:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46237 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932527AbVIOGMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:12:00 -0400
Date: Wed, 14 Sep 2005 23:11:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Lang <dlang@digitalinsight.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 04/11] hpt366: write the full 4 bytes of ROM address, not just low 1 byte
Message-ID: <20050915061136.GZ7762@shell0.pdx.osdl.net>
References: <20050915010343.577985000@localhost.localdomain> <20050915010404.660502000@localhost.localdomain> <Pine.LNX.4.62.0509141917070.8469@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0509141917070.8469@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Lang (dlang@digitalinsight.com) wrote:
> didn't Linus find similar bugs in a couple of the other hpt drivers as 
> well? if so can they be fixed at the same time?

Yes, and they're in this series.  This patch does:

drivers/ide/pci/hpt366.c

And patch 10/11 does:

drivers/ide/pci/cmd64x.c
drivers/ide/pci/hpt34x.c

Additionally, the sungem (5/11) and sunhme (6/11) changes are fallout
from PCI_ROM fixes.

I believe the remainder of the PCI_ROM related patches were primarily
for consistency.

thanks,
-chris
