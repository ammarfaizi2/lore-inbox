Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263092AbRFECEl>; Mon, 4 Jun 2001 22:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263093AbRFECEb>; Mon, 4 Jun 2001 22:04:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47517 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263092AbRFECEV>;
	Mon, 4 Jun 2001 22:04:21 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15132.15898.969850.255800@pizda.ninka.net>
Date: Mon, 4 Jun 2001 19:04:10 -0700 (PDT)
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, bjornw@axis.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush. 
In-Reply-To: <14147.991697362@redhat.com>
In-Reply-To: <3B1C1872.8D8F1529@mandrakesoft.com>
	<13942.991696607@redhat.com>
	<14147.991697362@redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Woodhouse writes:
 > > What should it do on i386?  mb()? 
 > 
 > For it to have any use in the situation I described, it would need to 
 > writeback and invalidate the dcache for the affected range. It doesn't seem 
 > to do so, so it seems that it isn't what I require.

It only needs to do that on cpus where the cache is not consistent
with the rest of the system.  x86 caches are fully consistent with the
rest of the system, thus no flushing necessary.

Later,
David S. Miller
davem@redhat.com
