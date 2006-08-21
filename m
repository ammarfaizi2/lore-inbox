Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbWHUHsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWHUHsx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 03:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWHUHsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 03:48:52 -0400
Received: from ns.suse.de ([195.135.220.2]:27354 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965065AbWHUHsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 03:48:52 -0400
From: Andi Kleen <ak@suse.de>
To: David Chinner <dgc@sgi.com>
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow  writeback.
Date: Mon, 21 Aug 2006 09:47:03 +0200
User-Agent: KMail/1.9.3
Cc: Neil Brown <neilb@suse.de>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <17633.2524.95912.960672@cse.unsw.edu.au> <17640.65491.458305.525471@cse.unsw.edu.au> <20060821031505.GQ51703024@melbourne.sgi.com>
In-Reply-To: <20060821031505.GQ51703024@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608210947.03793.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Ouch.  
> > I suspect we are going to see more of this, as USB drive for backups
> > is probably a very attractive option for many.
> 
> I can't see how this would occur on a 2.6 kernel 

I still got the traces to prove it:
http://www.firstfloor.org/~andi/usb-loop-copy-stall-1

e.g. notice the lynx which is stuck in a m/atime update. It was stalling
for a quite long time.

> 
-Andi
