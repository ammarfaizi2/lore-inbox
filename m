Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUISRxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUISRxd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 13:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUISRxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 13:53:33 -0400
Received: from zamok.crans.org ([138.231.136.6]:33665 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261474AbUISRxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 13:53:31 -0400
To: Alexander ZVYAGIN <Alexander.Zviagine@cern.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DMA is OFF with 2.6.9-rc2*
References: <200409191931.26547.Alexander.Zviagine@cern.ch>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Sun, 19 Sep 2004 19:53:25 +0200
In-Reply-To: <200409191931.26547.Alexander.Zviagine@cern.ch> (Alexander
	ZVYAGIN's message of "Sun, 19 Sep 2004 19:31:26 +0200")
Message-ID: <87u0tup2lm.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander ZVYAGIN <Alexander.Zviagine@cern.ch> writes:

> Hello,
>
> with linux 2.6.9-rc2-mm1 (and with 2.6.9-rc2 too) my hard disk can not use 
> DMA. Even explicit call for 'hdparam -d1 /dev/hda' fails.
> It worked in the past with kernel 2.6.7.
>
> There is a new line
>  "spurious 8259A interrupt: IRQ7."
> in dmesg output as well. And again, I did not have it with the old kernel.

I don't think it is related.

some patches in 2.6.9-rc2-mm1 caused the dma failure (for 2.6.9-rc2,
I don't know)

try unapplying the 3 patches above:

+incorrect-pci-interrupt-assignment-on-es7000-for-platform-gsi.patch
+incorrect-pci-interrupt-assignment-on-es7000-for-platform-gsi-fix.patch
+incorrect-pci-interrupt-assignment-on-es7000-for-pin-zero.patch

(in the reverse order :))
that worked for me, currently running

-- 
Mathieu Segaud


