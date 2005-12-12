Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbVLLUf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbVLLUf7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVLLUf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:35:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:28127 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750935AbVLLUf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:35:58 -0500
Subject: Re: Memory corruption & SCSI in 2.6.15
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@suse.de>,
       Brian King <brking@us.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0512120909460.15597@g5.osdl.org>
References: <1134371606.6989.95.camel@gaston>
	 <Pine.LNX.4.64.0512120909460.15597@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 07:33:28 +1100
Message-Id: <1134419609.6989.116.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If it's easily repeatable, doing a "git bisect" to see when it starts 
> happening is the obvious big sledge-hammer thing to try. Even if you don't 
> bisect all the way, just narrowing it down a bit more might help.

Sure, though I assumed it had already be tracked down at least partially
by Brian ;)

> Also, enabling DEBUG_PAGEALLOC might help, but that's not available on 
> powerpc.

Remind me what is needed to get that working ? Unmapping of linear
mapping pages ? (I suppose I could do that if I also disable using large
pages for it).

> There's a raid1 use-after-free bugfix that I just merged and pushed out, 
> but I doubt that one is relevant. But you might try to update.
> 
> 		Linus

