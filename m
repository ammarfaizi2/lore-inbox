Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVCNIel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVCNIel (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 03:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVCNIek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 03:34:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:65175 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261339AbVCNIei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 03:34:38 -0500
Subject: Re: [PATCH] break_lock forever broken
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42354A3F.4030904@yahoo.com.au>
References: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com>
	 <20050311203427.052f2b1b.akpm@osdl.org>
	 <Pine.LNX.4.61.0503122311160.13909@goblin.wat.veritas.com>
	 <20050314070230.GA24860@elte.hu> <42354562.1080900@yahoo.com.au>
	 <20050314081402.GA26589@elte.hu>  <42354A3F.4030904@yahoo.com.au>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 09:34:30 +0100
Message-Id: <1110789270.6288.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Yes that's the tradeoff. I just feel that the former may be better,
> especially because the latter can be timing dependant (so you may get
> things randomly "happening"), and the former is apparently very low
> overhead compared with the cost of taking the lock. Any numbers,
> anyone?

as I said, since the cacheline just got dirtied, the write is just half
a cycle which is so much in the noise that it really doesn't matter.


