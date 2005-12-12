Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbVLLVBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVLLVBD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 16:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVLLVBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 16:01:03 -0500
Received: from gate.crashing.org ([63.228.1.57]:60895 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751272AbVLLVBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 16:01:02 -0500
Subject: Re: Memory corruption & SCSI in 2.6.15
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@suse.de>,
       Brian King <brking@us.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0512121250130.15597@g5.osdl.org>
References: <1134371606.6989.95.camel@gaston>
	 <Pine.LNX.4.64.0512120909460.15597@g5.osdl.org>
	 <1134419609.6989.116.camel@gaston>
	 <Pine.LNX.4.64.0512121250130.15597@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 07:57:59 +1100
Message-Id: <1134421080.6989.121.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 12:51 -0800, Linus Torvalds wrote:
> [ I applied Brian's patch, so hopefully it was the same issue, and current 
>   git doesn't show this problem any more ]

I'll be able to test in about 1h.

> On Tue, 13 Dec 2005, Benjamin Herrenschmidt wrote:
> >
> > > Also, enabling DEBUG_PAGEALLOC might help, but that's not available on 
> > > powerpc.
> > 
> > Remind me what is needed to get that working ? Unmapping of linear
> > mapping pages ? (I suppose I could do that if I also disable using large
> > pages for it).
> 
> Yes, basically you'd have to allow the kernel mapping being unmapped one 
> page at a time. 
> 
> And yes, it's inefficient. Don't use it for performance measurements ;)

Ok, I'll look into it. It's doable though it will definitely not be
fast :)

Ben.


