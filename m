Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268657AbUIXJlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268657AbUIXJlS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 05:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268652AbUIXJlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 05:41:18 -0400
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:5834 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S268650AbUIXJlK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 05:41:10 -0400
From: Andrew Walrond <andrew@walrond.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: lost memory on a 4GB amd64
Date: Fri, 24 Sep 2004 10:41:08 +0100
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org,
       Sergei Haller <Sergei.Haller@math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> <Pine.LNX.4.58.0409241856120.16011@fb07-calculator.math.uni-giessen.de> <200409241127.38529.rjw@sisk.pl>
In-Reply-To: <200409241127.38529.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409241041.08975.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 Sep 2004 10:27, Rafael J. Wysocki wrote:
>
> > AW> cpu1's bank. How are yours arranged?
> >
> > my board has only four banks, each of them has a 1GB module sitting.
> > (page 26 of ftp://ftp.tyan.com/manuals/m_s2875_102.pdf)
>
> Which is what makes the difference, I think.  IMO, the problem is that
> _both_ CPUs use the same memory bank that is physically attached to only
> one of them which leads to conflicts, apparently (the CPU with memory has
> also PCI/AGP/whatever attached to it via HyperTransport so I can imagine
> there may be issues with overlapping address spaces etc.).  I'd bet that
> there's something wrong either with the BIOS or with the board design
> itself and I don't think there's anything that the kernel can do about it
> (usual disclaimer applies).
>
> Out of couriosity: have you tried to run the kernel with K8 NUMA enabled?
>

Actually, the block diagram on page 9 of the manual suggests that this is 
_not_ a NUMA board, since all DIMMS are connected to cpu1. The block diagram 
for my thunder k8w specifically shows DIMMS associated with individual 
processors.

Which suggests that NUMA show be _disabled_ in the kernel config.

Have you tried it with NUMA disabled? I think I remeber it being on in 
the .config you sent me.

Andrew
