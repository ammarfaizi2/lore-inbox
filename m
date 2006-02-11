Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWBKIu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWBKIu5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 03:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWBKIu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 03:50:56 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:53172 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750777AbWBKIu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 03:50:56 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43EDA546.7020103@s5r6.in-berlin.de>
Date: Sat, 11 Feb 2006 09:50:14 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Lee Revell <rlrevell@joe-job.com>, miles.lane@gmail.com,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Dave Jones <davej@redhat.com>
Subject: Re: 2.6.16-rc2-mm1 -- BUG: warning at drivers/ieee1394/ohci1394.c:235/get_phy_reg()
References: <a44ae5cd0602101207s4b2d61d7nc6705067b7913322@mail.gmail.com>	<20060210122131.4b98cfb4.akpm@osdl.org>	<1139624931.19342.46.camel@mindpipe> <20060210203715.57b39b0d.akpm@osdl.org>
In-Reply-To: <20060210203715.57b39b0d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.399) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>>That's a -mm-only warning telling you that get_phy_reg() is doing a
>>>one-millisecond-or-more busywait while local interrupts are disabled.
...
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/broken-out/debug-warn-if-we-sleep-in-an-irq-for-a-long-time.patch

So that's why when I heard of this issue the first time, it was about 
Redhat/ Fedora Core kernels. But even though this issue is very old, no 
bug report got through to linux1394-devel until December 2005.

BTW, why not swap the order of expressions:
		WARN_ON(!(warned++) && in_irq()); 	\
-- 
Stefan Richter
-=====-=-==- --=- -=-==
http://arcgraph.de/sr/
