Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTHJMDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 08:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTHJMDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 08:03:21 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:47628 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263398AbTHJMDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 08:03:19 -0400
Date: Sun, 10 Aug 2003 21:03:22 +0900 (JST)
Message-Id: <20030810.210322.104562682.yoshfuji@linux-ipv6.org>
To: davem@redhat.com, hch@infradead.org
CC: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 7/9] convert drivers/scsi to virt_to_pageoff()
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030810045121.31ef7ccc.davem@redhat.com>
References: <20030810.201009.77128484.yoshfuji@linux-ipv6.org>
	<20030810123148.A10435@infradead.org>
	<20030810045121.31ef7ccc.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030810045121.31ef7ccc.davem@redhat.com> (at Sun, 10 Aug 2003 04:51:21 -0700), "David S. Miller" <davem@redhat.com> says:

> On Sun, 10 Aug 2003 12:31:48 +0100
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > You probably want to use pci_map_single here instead..
> 
> I don't think it's wise to mix two changes at once.  Let's get
> the straightforward "obvious" shorthand change in, then we can
> add your enhancement.

Agreed.

BTW, drivers/scsi/3w-xxxx.c says:

   1.02.00.029 - Add missing pci_free_consistent() in tw_allocate_memory().
                 Replace pci_map_single() with pci_map_page() for highmem.
                 Check for tw_setfeature() failure.

Have problems in pci_map_single() with highmem already gone away?

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
