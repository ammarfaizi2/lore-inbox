Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVF1Xnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVF1Xnh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVF1Xmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:42:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1498
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262254AbVF1XIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:08:09 -0400
Date: Tue, 28 Jun 2005 16:07:11 -0700 (PDT)
Message-Id: <20050628.160711.91199588.davem@davemloft.net>
To: kaber@trash.net
Cc: rankincj@yahoo.com, chrisw@osdl.org, bdschuym@pandora.be,
       bdschuym@telenet.be, herbert@gondor.apana.org.au,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net, netfilter-devel@manty.net
Subject: Re: 2.6.12: connection tracking broken?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42BBC6AC.9010704@trash.net>
References: <42BAF48E.70309@trash.net>
	<20050623.124951.130237121.davem@davemloft.net>
	<42BBC6AC.9010704@trash.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Fri, 24 Jun 2005 10:39:08 +0200

> In 2.6.12 we started dropping the conntrack reference when a packet
> leaves the IP layer. This broke connection tracking on a bridge,
> because bridge-netfilter defers calling some NF_IP_* hooks to the bridge
> layer for locally generated packets going out a bridge, where the
> conntrack reference is no longer available. This patch keeps the
> reference in this case as a temporary solution, long term we will
> remove the defered hook calling. No attempt is made to drop the
> reference in the bridge-code when it is no longer needed, tc actions
> could already have sent the packet anywhere.

Patch applied and pushed to stable@kernel.org

Thanks a lot.
