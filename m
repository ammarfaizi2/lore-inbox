Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUEXFif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUEXFif (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 01:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUEXFif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 01:38:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9706 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263971AbUEXFic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 01:38:32 -0400
Date: Mon, 24 May 2004 09:39:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ben LaHaise <bcrl@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
Message-ID: <20040524073929.GA23216@elte.hu>
References: <1085369393.15315.28.camel@gaston> <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org> <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org> <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Who else has been working on the page tables that could verify this
> for me? Ingo? Ben LaHaise? I forget who even worked on this, because
> it's so long ago we went through all the atomicity issues with the
> page table updates on SMP. There may be some reason that I'm
> overlooking that explains why I'm full of sh*t.

Ben's the master of atomic dirty pte updates! :)

	Ingo
