Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbUL2BgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbUL2BgS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 20:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUL2BgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 20:36:17 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:15615 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261277AbUL2BgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 20:36:14 -0500
To: Karen Shaeffer <shaeffer@neuralscape.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <200412272150.IBRnA4AvjendsF8x@topspin.com>
	<20041227225417.3ac7a0a6.davem@davemloft.net>
	<52pt0unr0i.fsf@topspin.com>
	<20041228141710.4daebcfb.davem@davemloft.net>
	<52pt0uhupw.fsf@topspin.com>
	<20041229012817.GA18863@synapse.neuralscape.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 28 Dec 2004 17:36:12 -0800
In-Reply-To: <20041229012817.GA18863@synapse.neuralscape.com> (Karen
 Shaeffer's message of "Tue, 28 Dec 2004 17:28:17 -0800")
Message-ID: <52hdm5j377.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][v5][0/24] Latest IB patch queue
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 29 Dec 2004 01:36:13.0192 (UTC) FILETIME=[C7FC7080:01C4ED46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> I think sparc64 is the only such platform where InfiniBand
    Roland> is likely to be of much interest.  However I'll check out
    Roland> all of arch/ and send patches to hook up
    Roland> drivers/infiniband/ to the relevant maintainers once IB
    Roland> makes it upstream.

    Karen> I am interested in Infiniband with x86_64 Opterons.

OK, the current code should work well for you -- x86_64 is probably
the most-tested architecture.

"such platform[s]" in my comment above referred to architectures where
arch/xxx/Kconfig does _not_ include drivers/Kconfig;
arch/x86_64/Kconfig does include that file.  So no change is required
to use the current IB patches on x86_64.  I believe the only
architectures that both support PCI and do not include drivers/Kconfig
in their arch Kconfig are arm, sparc, sparc64 and v850.  Perhaps I'm
wrong, but of those four architectures, sparc64 seems to be the only
one where there would be any interest in using IB.

 - Roland
