Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbUAAXNJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 18:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUAAXNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 18:13:09 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:42933 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261799AbUAAXM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 18:12:59 -0500
Subject: Re: swapper: page allocation failure. order:3, mode:0x20
From: Christophe Saout <christophe@saout.de>
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, joneskoo@derbian.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040101224527.GP28023@krispykreme>
References: <20040101093553.GA24788@derbian.org>
	 <20040101101541.GJ28023@krispykreme>
	 <20040101022553.2be5f043.akpm@osdl.org>
	 <20040101130147.GM28023@krispykreme>
	 <1072994888.6532.3.camel@leto.cs.pocnet.net>
	 <20040101224527.GP28023@krispykreme>
Content-Type: text/plain
Message-Id: <1072998783.5199.25.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Jan 2004 00:13:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, den 01.01.2004 schrieb Anton Blanchard um 23:45:

> > This would mean that all users of printk_ratelimit share this. If
> > printk_ratelimit is bombed by one user other perhaps important messages
> > are also suppressed.
> 
> printk_ratelimit is only to be used for things which we can afford to 
> lose (eg our VM debugging messages). Don't use it on anything important :)

Other implementations would probably be overkill, so I'll agree with
you. :)

If printk_ratelimit is called too often there is probably something
wrong going anyway that is worth fixing.


