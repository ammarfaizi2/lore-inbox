Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUJGRqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUJGRqN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267679AbUJGRme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:42:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13733 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267595AbUJGRgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 13:36:40 -0400
Date: Thu, 7 Oct 2004 12:39:29 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] 0-order allocation failed
Message-ID: <20041007153929.GB14614@logos.cnet>
References: <200410071318.21091.mbuesch@freenet.de> <20041007151518.GA14614@logos.cnet> <200410071917.40896.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410071917.40896.mbuesch@freenet.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 07:17:30PM +0200, Michael Buesch wrote:
> Quoting Marcelo Tosatti <marcelo.tosatti@cyclades.com>:
> > On Thu, Oct 07, 2004 at 01:18:13PM +0200, Michael Buesch wrote:
> > > Hi all,
> > > 
> > > I'm running 2.4.28 bk snapshot of 2004.09.03
> > > The machine has an uptime of 7 days, 23:46 now.
> > > 
> > > I was running several bittorrent clients inside of
> > > a screen session. Suddenly they all died (including the
> > > screen session).
> > > dmesg sayed this:
> > > 
> > > __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
> > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > VM: killing process python
> > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > VM: killing process screen
> > > 
> > > I already got this with kernel 2.4.27 vanilla after a
> > > higher amount of uptime (I think it was over 10 days).
> > > This was exactly the reason I updated to bk snapshot.
> > > 
> > > What can be the reason for this? Is it OOM? (I can't
> > > really believe it is).
> > 
> > Can you check how much swap space is there available when
> > the OOM killer trigger? I bet this is the case.
> 
> The machine doesn't have swap.

Well then you're probably facing true OOM.

Add some swap.

> > If its not, we have a problem.
> > 
> > > Is it a kernel memory leak?
> > > 
> > > With 2.4.26 I never got these errors. And I ran uptimes
> > > up to 50 days.
