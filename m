Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270288AbUJTJBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270288AbUJTJBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270138AbUJTI4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 04:56:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:37790 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270067AbUJTIzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 04:55:17 -0400
Subject: Re: New consolidate irqs vs . probe_irq_*()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20041020084838.GA25798@elte.hu>
References: <16758.3807.954319.110353@cargo.ozlabs.ibm.com>
	 <20041020083358.GB23396@elte.hu> <1098261745.6263.9.camel@gaston>
	 <20041020084838.GA25798@elte.hu>
Content-Type: text/plain
Message-Id: <1098262403.6278.16.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 18:53:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 18:48, Ingo Molnar wrote:

> yeah. I've put it into a separate autoprobe.c file specifically for that
> reason, you can exclude it in the Makefile and can provide your own
> architecture version. Or should we make the no-autoprobing choice
> generic perhaps?

I like this later option... How may archs actually had autoprobing
implemented and actually used ?

Well, I'll do some grep'ing around tonight as I do the NO_IRQ stuff
and see what makes more sense. I don't think an arch that didn't have
autoprobing needs it now, besides, it's not exactly a reliable
mecanism...

Ben.


