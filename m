Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263027AbVAFUSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbVAFUSP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbVAFUQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:16:09 -0500
Received: from zeus.kernel.org ([204.152.189.113]:22721 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263006AbVAFUK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:10:26 -0500
Date: Thu, 6 Jan 2005 11:23:57 -0800
From: Simon Kirby <sim@netnation.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.10-bk7] Oops: ide_dma_timeout_retry
Message-ID: <20050106192357.GA1760@netnation.com>
References: <20050105233359.GA2327@netnation.com> <1105023683.24896.213.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105023683.24896.213.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 04:30:14PM +0000, Alan Cox wrote:

> The initial UncorrectableError is the drive erroring the request due to
> real failure of the drive to get the data. There are some races in the
> base code when that occurs
> 
> rq should never be NULL at that point because after all there has to be
> a request which has timed out. If the timeout isn't being cleared on the
> error path that would make sense of the trace or if the timeout occurred
> at the same time as the error completed it would have raced.
> 
> It could also be due to the fact base 2.6.10 will corrupt requests on
> errors sometimes (which SGI now fixed)

Well, it seems I was able to reproduce it each and every time by trying
to read the one sector.  The drive is now out of the box but I can place
it in my desktop or anywhere else and probably do the same.

I can't seem to find a post with the SGI fixes, and I don't see anything
from a quick skim of the bk8 and bk9 logs (problem reproduced in bk7). 
Could you point me to the relevant thread?

Simon-
