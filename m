Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbVKONYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbVKONYU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 08:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbVKONYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 08:24:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14251 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932516AbVKONYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 08:24:19 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: "Tue, 15 Nov 2005 14:18:51 +0100" <grundig@teleline.es>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051115141851.18c2c276.grundig@teleline.es>
References: <58MJb-2Sn-37@gated-at.bofh.it> <58NvO-46M-23@gated-at.bofh.it>
	 <58Rpx-1m6-11@gated-at.bofh.it> <58UGF-6qR-27@gated-at.bofh.it>
	 <58UQf-6Da-3@gated-at.bofh.it> <437933B6.1000503@shaw.ca>
	 <1132020468.27215.25.camel@mindpipe> <20051115032819.GA5620@redhat.com>
	 <43795575.9010904@wolfmountaingroup.com>
	 <20051115050658.GA13660@redhat.com>
	 <43797E05.5090107@wolfmountaingroup.com>
	 <17273.34218.334118.264701@cse.unsw.edu.au>
	 <4379846E.2070006@wolfmountaingroup.com>
	 <20051115141851.18c2c276.grundig@teleline.es>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Nov 2005 14:24:05 +0100
Message-Id: <1132061045.2822.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 14:18 +0100, Tue, 15 Nov 2005 14:18:51 +0100
wrote:
> El Mon, 14 Nov 2005 23:47:10 -0700,
> "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com> escribió:
> 
> > Great point, and you are correct that MS DOS had bigger stacks than 4K. 
> > Onward through the fog ....
> 
> 
> And Linux had stacks bigger than 4K until recently and could be made
> bigger again. 

well ......

in 2.4 kernels you had a 4K stack as well (even though it was 8Kb in
size, you lost 1.5Kb to the task struct and you lost 2 to 2.5 Kb to irq
context, net usable was 4Kb). In 2.6 the task struct moved off the
stack, and the 4KSTACK feature allowed you to split the irq stack usage
off to a seperate stack, still giving you 4Kb available.. that's still
the same as 2.4 effectively. 2.6 also has (and I wish it becomes "had"
soon) an option to get 6Kb effective stack space instead. This is an
increase of 2Kb compared to 2.4. 

