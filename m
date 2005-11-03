Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbVKCSAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbVKCSAF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbVKCSAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:00:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64947 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030396AbVKCSAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:00:03 -0500
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Arjan van de Ven <arjan@infradead.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Mel Gorman <mel@csn.ul.ie>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
In-Reply-To: <311050000.1131040276@[10.10.2.4]>
References: <4366C559.5090504@yahoo.com.au>
	 <Pine.LNX.4.58.0511010137020.29390@skynet><4366D469.2010202@yahoo.com.au>
	 <Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu>
	 <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu>
	 <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu>
	 <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu>
	 <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost>
	 <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]>
	 <4369824E.2020407@yahoo.com.au> <306020000.1131032193@[10.10.2.4]>
	 <1131032422.2839.8.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
	 <Pine.LNX.4.58.0511031613560.3571@skynet>
	 <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org>
	 <309420000.1131036740@[10.10.2.4]>
	 <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org>
	 <311050000.1131040276@[10.10.2.4]>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 18:59:45 +0100
Message-Id: <1131040786.2839.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
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

On Thu, 2005-11-03 at 09:51 -0800, Martin J. Bligh wrote:

> For amusement, let me put in some tritely oversimplified math. For the
> sake of arguement, assume the free watermarks are 8MB or so. Let's assume
> a clean 64-bit system with no zone issues, etc (ie all one zone). 4K pages.
> I'm going to assume random distribution of free pages, which is 
> oversimplified, but I'm trying to demonstrate a general premise, not get
> accurate numbers.

that is VERY over simplified though, given the anti-fragmentation
property of buddy algorithm

