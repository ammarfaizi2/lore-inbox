Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbWIGK5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWIGK5z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 06:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWIGK5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 06:57:55 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:61135 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751494AbWIGK5y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 06:57:54 -0400
Date: Thu, 7 Sep 2006 12:52:37 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Hayim Shaul <hayim@iportent.com>, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, edward_peng@dlink.com.tw,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc6 1/2] dllink driver: porting v1.19 to linux 2.6.18-rc6
Message-ID: <20060907105237.GA21270@electric-eye.fr.zoreil.com>
References: <1157620189.2904.16.camel@localhost.localdomain> <1157620795.14882.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157620795.14882.16.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> :
[...]
> >  	dev->trans_start = jiffies;
> > +	tasklet_enable(&np->tx_tasklet);
> > +	writew(DEFAULT_INTR, ioaddr + IntEnable);
> > +	return;
> 
> this looks like a PCI posting bug

Btw tx_tasklet is introduced in the relevant struct in patch #2.
Patch #1 will not compile.

-- 
Ueimor
