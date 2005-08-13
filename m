Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVHMR1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVHMR1J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 13:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVHMR1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 13:27:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29329 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932221AbVHMR1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 13:27:07 -0400
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
	between /dev/kmem and /dev/mem)
From: Arjan van de Ven <arjan@infradead.org>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bda6d13a05081309575498f1bb@mail.gmail.com>
References: <1123796188.17269.127.camel@localhost.localdomain>
	 <1123809302.17269.139.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
	 <1123951810.3187.20.camel@laptopd505.fenrus.org>
	 <bda6d13a05081309575498f1bb@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 13 Aug 2005 19:27:04 +0200
Message-Id: <1123954024.3187.25.camel@laptopd505.fenrus.org>
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


> I believe rootkit detectors, as well as some versions of ps (wchan
> field) use kmem.

ps doesn't use kmem, and besides, in 2.6 we export that directly in
proc. poking in /dev/mem or /dev/kmem is NOT something you "just do".
THere are lots of pitfalls, things like PCI space, memory sizes/holes,
cachability aliases etc etc that can ruin your breakfast if you
use /dev/[k]mem... 

