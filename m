Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264512AbUF1JCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbUF1JCu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 05:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUF1JCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 05:02:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16909 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264512AbUF1JCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 05:02:46 -0400
Date: Mon, 28 Jun 2004 10:02:39 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Chris Wedgwood <cw@f00f.org>,
       Erik Jacobson <erikj@subway.americas.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040628100239.E32206@flint.arm.linux.org.uk>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	Erik Jacobson <erikj@subway.americas.sgi.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
References: <20040625083130.GA26557@infradead.org> <Pine.SGI.4.53.0406250742350.377639@subway.americas.sgi.com> <20040625124807.GA29937@infradead.org> <Pine.SGI.4.53.0406250751470.377692@subway.americas.sgi.com> <20040626235248.GC12761@taniwha.stupidest.org> <Pine.SGI.4.53.0406271908390.524706@subway.americas.sgi.com> <20040628003311.GA23017@taniwha.stupidest.org> <20040628021439.A17654@flint.arm.linux.org.uk> <20040628014443.GA24247@taniwha.stupidest.org> <20040628085429.C32206@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040628085429.C32206@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Mon, Jun 28, 2004 at 08:54:30AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 08:54:30AM +0100, Russell King wrote:
> On Sun, Jun 27, 2004 at 06:44:43PM -0700, Chris Wedgwood wrote:
> > On Mon, Jun 28, 2004 at 02:14:39AM +0100, Russell King wrote:
> > > It's the way its always been done, and the way the tty layer works.
> > > You register a range of ttys that you're going to be driving, and
> > > you own those ttys whether or not you actually have hardware for
> > > them.
> > 
> > How about this (yes, it's a hack but it's really not that bad and will
> > get things working until we can fix this up in 2.7.x):
> 
> If you're going to do that, why not just disable 8250 in the kernels
> configuration?  It has exactly the same effect.  With the change you
> propose, you can't even use 8250 for PCMCIA serial cards.

Note also that I don't want to apply hacks to 8250 _unless_ there is a
clear method to remove those hacks in a later kernel.

To put it another way, I want to see the clean solution, preferably
already developed and reviewed ready for the next development series
before applying the hack to the stable version.

Without this step, we have historically added hacks to the old serial
driver and forgotten about them, because the problem is no longer in
peoples minds.

IOW, I don't have any objection to adding hacks to work around
problems in the same series _provided_ we have a clear way to resolve
those hacks in the next development kernel series.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
