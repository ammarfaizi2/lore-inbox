Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVLLUwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVLLUwc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVLLUwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:52:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34208 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751221AbVLLUwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:52:31 -0500
Date: Mon, 12 Dec 2005 12:51:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@suse.de>,
       Brian King <brking@us.ibm.com>
Subject: Re: Memory corruption & SCSI in 2.6.15
In-Reply-To: <1134419609.6989.116.camel@gaston>
Message-ID: <Pine.LNX.4.64.0512121250130.15597@g5.osdl.org>
References: <1134371606.6989.95.camel@gaston>  <Pine.LNX.4.64.0512120909460.15597@g5.osdl.org>
 <1134419609.6989.116.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ I applied Brian's patch, so hopefully it was the same issue, and current 
  git doesn't show this problem any more ]

On Tue, 13 Dec 2005, Benjamin Herrenschmidt wrote:
>
> > Also, enabling DEBUG_PAGEALLOC might help, but that's not available on 
> > powerpc.
> 
> Remind me what is needed to get that working ? Unmapping of linear
> mapping pages ? (I suppose I could do that if I also disable using large
> pages for it).

Yes, basically you'd have to allow the kernel mapping being unmapped one 
page at a time. 

And yes, it's inefficient. Don't use it for performance measurements ;)

			Linus
