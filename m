Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbUKJIky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbUKJIky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 03:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbUKJIky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 03:40:54 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:41857 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261293AbUKJIkw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 03:40:52 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 10 Nov 2004 09:24:07 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: [patch] 2.6.10-rc1-mm4: bttv-driver.c compile error
Message-ID: <20041110082407.GA23090@bytesex>
References: <20041109074909.3f287966.akpm@osdl.org> <1100018489.7011.4.camel@lb.loomes.de> <20041109211107.GB5892@stusta.de> <1100037358.1519.6.camel@lb.loomes.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100037358.1519.6.camel@lb.loomes.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kobject_register failed for <NULL> (-17)

IIRC there was a bug in the driver base and a patch from Gred fixing
that floating around, maybe that one helps?  If not, the please
build with KALLSYMS enabled, so this blob here ...

> Call Trace:[<ffffffff80208fa6>] [<ffffffff80277a9b>]
> [<ffffffff80278002>] 
>        [<ffffffff802f8930>] [<ffffffff8010b0e8>] [<ffffffff8010ea03>] 
>        [<ffffffff8010b050>] [<ffffffff8010e9fb>] 

... will be translated into something readable.

> warning: many lost ticks.
> Your time source seems to be instable or some driver is hogging
> interupts

Hmm, bttv shouldn't generate IRQs when unused.
Anything suspious in /proc/interrupts?

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
