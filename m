Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272272AbTGYTeA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272274AbTGYTd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:33:59 -0400
Received: from dsl-213-023-066-245.arcor-ip.net ([213.23.66.245]:6272 "EHLO
	neon.pearbough.net") by vger.kernel.org with ESMTP id S272272AbTGYTdv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:33:51 -0400
Date: Fri, 25 Jul 2003 21:48:45 +0200
From: Axel Siebenwirth <axel@pearbough.net>
To: "Mudama, Eric" <eric_mudama@maxtor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.22-pre8-bk] dma_timer_expiry: dma status == 0x64
Message-ID: <20030725194845.GA723@neon>
Mail-Followup-To: "Mudama, Eric" <eric_mudama@maxtor.com>,
	linux-kernel@vger.kernel.org
References: <785F348679A4D5119A0C009027DE33C102E0D6B8@mcoexc04.mlm.maxtor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D6B8@mcoexc04.mlm.maxtor.com>
User-Agent: Mutt/1.4.1i
Organization: pearbough.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric!

On Fri, 25 Jul 2003, Mudama, Eric wrote:

> 0x64 has the seek complete, write fault, and corrected data bits set...
> 
> you get the short stalls, does the drive then keep functioning, or are the
> stalls fatal/permanent?  The error recovery paths in our disk are generally
> configured to be "heroic", as in "do everything possible to try to get that
> data safely on the media"... this can take several seconds at least,
> depending on the type of error.

At least no reported loss of data. Filesystem is reiserfs.

> Do these same errors happen with other kernels?

It's ok with 2.4.21-pre6-ac1 and 2.6.0-test1-bk. So I go for the kernel
problem. But my knowledge of IDE and harddisks is about null.

> I'd suggest that your drive appears to be having trouble writing to the
> media... I'd back up your data if you can and do a full-pack zeroing/write
> of the drive.  If that completes with no issues, then it's probably fine, if
> that has problems the drive ought to be RMA'd for a replacement... it could
> be one of those few out of a million that dies in the field within a year.
> 
> --eric
> 
> 
> -----Original Message-----
> From: Axel Siebenwirth [mailto:axel@pearbough.net]
> Sent: Friday, July 25, 2003 1:08 PM
> To: linux-kernel@vger.kernel.org
> Subject: [2.4.22-pre8-bk] dma_timer_expiry: dma status == 0x64
> 
> 
> hi,
> 
> this is a bug report?!
> 
> with the linux kernel 2.4.22-pre8 from bk as of this day I get short stalls
> about 5 to 8 seconds resulting in nothing happening with my machine at all.
> (right now it happenend, but I can still type this)
> 
> the kernel reports the following two messages:
> 
> hda: dma_timer_expiry: dma status == 0x64
> hda: DMA interrupt recovery
> hda: lost interrupt
> ...
> hda: dma_timer_expiry: dma status == 0x64
> hda: DMA interrupt recovery
> hda: lost interrupt
> hda: dma_timer_expiry: dma status == 0x64
> hda: DMA interrupt recovery
> hda: lost interrupt
> hda: dma_timer_expiry: dma status == 0x64
> hda: DMA interrupt recovery
> hda: lost interrupt
> 
> and so on.
> 
> so maybe this helps you find an error in the kernel.
> 
> best wishes,
> axel siebenwirth
> 
> P.S. I attached gzipped dmesg and .config
