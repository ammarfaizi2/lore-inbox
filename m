Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbUKVAXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbUKVAXh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 19:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbUKVAWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 19:22:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45065 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261869AbUKVAVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 19:21:41 -0500
Date: Mon, 22 Nov 2004 00:21:36 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Christoph Hellwig <hch@infradead.org>, Antonino Daplas <adaplas@pol.net>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] cyber2000fb.c: misc cleanups
Message-ID: <20041122002136.A30668@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Christoph Hellwig <hch@infradead.org>,
	Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
	linux-fbdev-devel@lists.sourceforge.net
References: <20041121153614.GR2829@stusta.de> <20041121204752.A23300@flint.arm.linux.org.uk> <20041121205613.GA12634@infradead.org> <20041122000413.A27572@flint.arm.linux.org.uk> <20041122001051.GA3007@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041122001051.GA3007@stusta.de>; from bunk@stusta.de on Mon, Nov 22, 2004 at 01:10:51AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 01:10:51AM +0100, Adrian Bunk wrote:
> Where is this video capture code, and why can't it be included in the 
> kernel?

A version of it was in the Netwinder.Org CVS tree, but since the
machine which used to provide that domain has been impounded by
the provider (because of problems with a third party providing the
hosting for it), that source vanished.

That leaves me as the sole provider of the source code, and the
code has always been in the "experimental but useful" stage.  The
capture code is something which doesn't meet my standards for
mainline kernel inclusion.

However, since the capture is part of the PCI VGA device, the VGA
driver needs to export some hooks so that the capture driver can
safely talk to the VGA chip.  That is what these are for, and, since
they have to be part of the VGA driver itself, I see no reason why
I can't include them as part of the driver that _I_ maintain.

Of course, if it is preferred to put crap code into the kernel, then
that I shall do.  That's contary to what I believe should be merged,
and I'm sure then Christoph will whinge about crap code being included.
So I suspect I can't win either way.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
