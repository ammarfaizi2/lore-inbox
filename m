Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263189AbRFEEB6>; Tue, 5 Jun 2001 00:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbRFEEBs>; Tue, 5 Jun 2001 00:01:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46238 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263189AbRFEEBd>;
	Tue, 5 Jun 2001 00:01:33 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15132.22933.859130.119059@pizda.ninka.net>
Date: Mon, 4 Jun 2001 21:01:25 -0700 (PDT)
To: Chris Wedgwood <cw@f00f.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Woodhouse <dwmw2@infradead.org>, bjornw@axis.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush.
In-Reply-To: <20010605155550.C22741@metastasis.f00f.org>
In-Reply-To: <13942.991696607@redhat.com>
	<3B1C1872.8D8F1529@mandrakesoft.com>
	<15132.15829.322534.88410@pizda.ninka.net>
	<20010605155550.C22741@metastasis.f00f.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Wedgwood writes:
 > On Mon, Jun 04, 2001 at 07:03:01PM -0700, David S. Miller wrote:
 > 
 >     The x86 doesn't have dumb caches, therefore it really doesn't
 >     need to flush anything.  Maybe a mb(), but that is it.
 > 
 > What if the memory is erased underneath the CPU being aware of this?
 > In such a way ig generates to bus traffic...

This doesn't happen on x86.  The processor snoops all transactions
done by other agents to/from main memory.  The processor caches are
always up to date.

Later,
David S. Miller
davem@redhat.com
