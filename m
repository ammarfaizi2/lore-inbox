Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUBYReZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUBYReZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:34:25 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:20634 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261472AbUBYReX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:34:23 -0500
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
References: <Pine.LNX.4.44.0402242238020.15091-100000@chimarrao.boston.redhat.com>
	<403CCC77.6030405@techsource.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 25 Feb 2004 09:34:21 -0800
In-Reply-To: <403CCC77.6030405@techsource.com>
Message-ID: <52k72bjc6a.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Feb 2004 17:34:22.0705 (UTC) FILETIME=[9B2CF610:01C3FBC5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Timothy> On the other hand, if something else is better or
    Timothy> adequate, like PCI Express (wasn't that based in
    Timothy> infiniband?), then there's no point.

PCI Express is not an InfiniBand replacement.  While it is true (I
think this is what you meant) that the PCI Express electrical
signaling is based on InfiniBand (they both use multiple lanes of 2.5
Gb/sec high-speed serial), the upper layers of the two standards are
quite different.  PCI Express and InfiniBand are really quite
complementary.  In fact (just to plug my employer :) we have
demonstrated an Infiniband host adapter that has two 4X IB (10 Gb/sec
ports) and plugs into an 8X PCI Express slot:
  http://www.topspin.com/news/pressrelease/pr_021704b.html

PCI Express (once products ship) will be essentially a faster PCI-X
replacement.  You will get a system with PCI Express slots and plug
PCI Express adapter cards into them.  There is something called PCI
Express "Advanced Switching" but that is quite a long way away from
being something you could build a cluster with.

InfiniBand on the other hand has evolved into a cluster interconnect.
In the beginning it was pitched as a PCI replacement but that was
given up long ago.  However, it evolved into an excellent cluster
interconnect.  Right now you can buy 10 Gb/sec host adapters and a
variety of switches (up to 96 ports).  There are a number of quite
large IB clusters already built and in production already.

Best,
  Roland
