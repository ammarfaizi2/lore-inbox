Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVLLJic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVLLJic (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 04:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVLLJic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 04:38:32 -0500
Received: from canuck.infradead.org ([205.233.218.70]:12710 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751145AbVLLJib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 04:38:31 -0500
Subject: Re: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, matthew@wil.cx, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, paulus@samba.org,
       linuxppc-dev@ozlabs.org, lethal@linux-sh.org, kkojima@rr.iij4u.or.jp,
       linux-mtd@lists.infradead.xn--org-boa
In-Reply-To: <20051211193118.GR23349@stusta.de>
References: <20051211185212.GQ23349@stusta.de>
	 <20051211192109.GA22537@flint.arm.linux.org.uk>
	 <20051211193118.GR23349@stusta.de>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 10:38:15 +0100
Message-Id: <1134380295.10234.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.8 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on canuck.infradead.org summary:
	Content analysis details:   (2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.8 HELO_DYNAMIC_IPADDR    Relay HELO'd using suspicious hostname (IP addr 1)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-11 at 20:31 +0100, Adrian Bunk wrote:
> Either the depency of MTD_OBSOLETE_CHIPS on BROKEN is correct (in
> which case CONFIG_MTD_OBSOLETE_CHIPS=y wouldn't bring you anything),
> or the dependency on BROKEN is not correct and should be corrected.
> 
> David, can you comment on this issue?

I don't see any justification for MTD_OBSOLETE_CHIPS depending on
BROKEN. That option covers a few of the obsolete chip drivers which
people shouldn't be using any more -- and I'm perfectly willing to
believe that one or two of those don't work any more, but if that's the
case then those individual drivers ought to be marked BROKEN (or just
removed). We shouldn't mark MTD_OBSOLETE_CHIPS broken.

I'd like to see the collie_defconfig updated to use the appropriate CFI
driver back end.

-- 
dwmw2

