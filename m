Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266292AbUIIV1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUIIV1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267588AbUIIVQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:16:58 -0400
Received: from the-village.bc.nu ([81.2.110.252]:16556 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267625AbUIIVMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:12:33 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org, mista.tapas@gmx.net, kr@cybsft.com,
       Mark_H_Johnson@Raytheon.com
In-Reply-To: <20040909130526.2b015999.akpm@osdl.org>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
	 <20040906110626.GA32320@elte.hu>
	 <1094626562.1362.99.camel@krustophenia.net> <20040909192924.GA1672@elte.hu>
	 <20040909130526.2b015999.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094760584.15210.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 21:09:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-09 at 21:05, Andrew Morton wrote:
> I did a patch a while back which switches the swapspace allocator over to
> perform program-virtual-address clustering, but it didn't help much in
> brief testing and I haven't got back onto it.
> 
> And contrary to my above assertion, I don't think it'll help latency ;)

I would still expect the only thing to materially improve swap latency
to be a log structured swap, possibly with a cleaner which tidies
together pages that are referenced together.


You also want contiguous runs of at least 64K and probaly a lot more on
bigger memory systems. 

