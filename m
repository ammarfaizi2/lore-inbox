Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932714AbVKDBU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbVKDBU3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVKDBU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 20:20:28 -0500
Received: from ozlabs.org ([203.10.76.45]:4770 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932697AbVKDBU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 20:20:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17258.46930.407556.162321@cargo.ozlabs.ibm.com>
Date: Fri, 4 Nov 2005 12:20:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Arjan van de Ven <arjan@infradead.org>, Mel Gorman <mel@csn.ul.ie>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <Pine.LNX.4.64.0511031704590.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au>
	<1130854224.14475.60.camel@localhost>
	<20051101142959.GA9272@elte.hu>
	<1130856555.14475.77.camel@localhost>
	<20051101150142.GA10636@elte.hu>
	<1130858580.14475.98.camel@localhost>
	<20051102084946.GA3930@elte.hu>
	<436880B8.1050207@yahoo.com.au>
	<1130923969.15627.11.camel@localhost>
	<43688B74.20002@yahoo.com.au>
	<255360000.1130943722@[10.10.2.4]>
	<4369824E.2020407@yahoo.com.au>
	<306020000.1131032193@[10.10.2.4]>
	<1131032422.2839.8.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
	<Pine.LNX.4.58.0511031613560.3571@skynet>
	<Pine.LNX.4.64.0511030842050.27915@g5.osdl.org>
	<309420000.1131036740@[10.10.2.4]>
	<Pine.LNX.4.64.0511030918110.27915@g5.osdl.org>
	<311050000.1131040276@[10.10.2.4]>
	<1131040786.2839.18.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0511031006550.27915@g5.osdl.org>
	<312300000.1131041824@[10.1!
 0.2.4]>
	<436AB241.2030403@yahoo.com.au>
	<Pine.LNX.4.64.0511031704590.27915@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> 64kB pages are _only_ usable for databases, nothing else.

Actually people running HPC apps also like 64kB pages since their TLB
misses go down significantly, and their data files tend to be large.

Fileserving for windows boxes should also benefit, since both the
executables and the data files that typical office applications on
windows use are largish.  I got a distribution of file sizes for a
government department office and concluded that 64k pages would only
bloat the page cache by a few percent for that case.

Paul.
