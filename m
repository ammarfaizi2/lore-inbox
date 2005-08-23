Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVHWQyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVHWQyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 12:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVHWQyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 12:54:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55016 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932139AbVHWQyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 12:54:19 -0400
Subject: Re: some missing spin_unlocks
From: Arjan van de Ven <arjan@infradead.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: tedu@coverity.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org
In-Reply-To: <20050823.094603.29591786.davem@davemloft.net>
References: <430A5127.5000304@coverity.com>
	 <20050823.094603.29591786.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 18:54:03 +0200
Message-Id: <1124816044.3218.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This one needs more care.  We can't drop the lock, because
> the destroy actions need to be protected by that lock, but
> we can't release the lock after rose_destroy_socket() because
> the object may not even exist any longer.


does it matter? can ANYTHING be spinning on the lock? if not .. can we
just let the lock go poof and not unlock it... 

