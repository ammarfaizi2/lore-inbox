Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUJGRga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUJGRga (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUJGRcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:32:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34723 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267497AbUJGRMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 13:12:13 -0400
Date: Thu, 7 Oct 2004 12:15:18 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] 0-order allocation failed
Message-ID: <20041007151518.GA14614@logos.cnet>
References: <200410071318.21091.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410071318.21091.mbuesch@freenet.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 01:18:13PM +0200, Michael Buesch wrote:
> Hi all,
> 
> I'm running 2.4.28 bk snapshot of 2004.09.03
> The machine has an uptime of 7 days, 23:46 now.
> 
> I was running several bittorrent clients inside of
> a screen session. Suddenly they all died (including the
> screen session).
> dmesg sayed this:
> 
> __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> VM: killing process python
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> VM: killing process screen
> 
> I already got this with kernel 2.4.27 vanilla after a
> higher amount of uptime (I think it was over 10 days).
> This was exactly the reason I updated to bk snapshot.
> 
> What can be the reason for this? Is it OOM? (I can't
> really believe it is).

Can you check how much swap space is there available when
the OOM killer trigger? I bet this is the case.

If its not, we have a problem.

> Is it a kernel memory leak?
> 
> With 2.4.26 I never got these errors. And I ran uptimes
> up to 50 days.
