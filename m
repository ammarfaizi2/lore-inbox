Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272471AbRIFM0F>; Thu, 6 Sep 2001 08:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272467AbRIFMZt>; Thu, 6 Sep 2001 08:25:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11534 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272466AbRIFMZk>; Thu, 6 Sep 2001 08:25:40 -0400
Subject: Re: kiobuf wrong changes in 2.4.9ac9
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 6 Sep 2001 13:29:53 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox),
        rohit.seth@intel.com
In-Reply-To: <20010906030228.C11329@athlon.random> from "Andrea Arcangeli" at Sep 06, 2001 03:02:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15eyI5-00080I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The above is all about performance and design, about real world
> showstopper the one in 2.4.9ac9 is that kiobuf allocations are going to
> fail during read/writes due mem framentation (this is why it was using
> vmalloc indeed) [those faliures should be easily reprocible on x86 boxes

Vmalloc is extremely expensive on many platforms. It looks very easy to
simple flip between slab and vmalloc based on size.

Let me know how the testing goes - if it works out well then I'll migrate
the -ac tree to the -aa patch when I have time to do the merging
