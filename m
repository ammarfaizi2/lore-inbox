Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVHaOmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVHaOmY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 10:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVHaOmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 10:42:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8389 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932395AbVHaOmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 10:42:23 -0400
Subject: Re: [PATCH 1/1] Implement shared page tables
From: Arjan van de Ven <arjan@infradead.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Hugh Dickins <hugh@veritas.com>, Dave McCracken <dmccr@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <16640000.1125498711@[10.10.2.4]>
References: <7C49DFF721CB4E671DB260F9@[10.1.1.4]>
	 <Pine.LNX.4.61.0508311143340.15467@goblin.wat.veritas.com>
	 <1125489077.3213.12.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0508311437070.16834@goblin.wat.veritas.com>
	 <16640000.1125498711@[10.10.2.4]>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 16:41:57 +0200
Message-Id: <1125499318.3213.18.camel@laptopd505.fenrus.org>
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


> > Which is indeed a further disincentive against shared page tables.
> 
> Or shared pagetables a disincentive to randomizing the mmap space ;-)
> They're incompatible, but you could be left to choose one or the other
> via config option.
> 
> 3% on "a certain industry-standard database benchmark" (cough) is huge,
> and we expect the benefit for PPC64 will be larger as we can share the
> underlying hardware PTEs without TLB flushing as well.
> 

surely the benchmark people know that the database in question always
mmaps the shared area at the address where the first one started it?
(if not, could make it so ;)



