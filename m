Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318175AbSHPF4Z>; Fri, 16 Aug 2002 01:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318180AbSHPF4Z>; Fri, 16 Aug 2002 01:56:25 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:49349 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S318175AbSHPF4Y>;
	Fri, 16 Aug 2002 01:56:24 -0400
To: <linux-kernel@vger.kernel.org>
Subject: PCI MMIO flushing, write-combining etc
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 16 Aug 2002 01:45:54 +0200
Message-ID: <m3d6sjele5.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a few simple questions for you PCI experts (please correct any wrong
assumptions):


Imagine we have a PCI card with 2 MMIO regions: prefetchable PR1 and
non-prefetchable NPR2 (and we are not limited to Pentium-class machines).

I understand writes to PR1 can be reordered, merged, and delayed.
What should I do to flush the write buffers? I understand reading from
PR1 would do. Would reading from NPR2 flush PR1 write buffers?
Would writing to NPR2 flush them?

Now NPR2, the non-prefetchable MMIO region.
Is it possible that the writes there are reordered, merged and/or
delayed (delayed = not making it to the PCI device when the writel()
completes)?


We have ioremap() and ioremap_nocache(). What is the exact difference
between them? Would the ioremap_nocache() disable all A) read- and
B) write-caching on a) prefetchable MMIO b) non-prefetchable MMIO ?

Would the ioremap() enable A) read- and A) write-caching on
a) prefetchable MMIO b) non-prefetchable MMIO ?


Thank you.
-- 
Krzysztof Halasa
Network Administrator
