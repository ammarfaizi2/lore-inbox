Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTJTRdC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 13:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbTJTRdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 13:33:02 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:57353 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S262687AbTJTRc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 13:32:58 -0400
Date: Mon, 20 Oct 2003 19:30:33 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: "Noah J. Misch" <noah@caltech.edu>
cc: irda-users@lists.sourceforge.net, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [irda-users] [PATCH] Make VLSI FIR depend on X86
In-Reply-To: <Pine.GSO.4.58.0310171456080.13905@blinky>
Message-ID: <Pine.LNX.4.44.0310201138020.4246-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Oct 2003, Noah J. Misch wrote:

> This is a trivial patch against the Kconfig entry for the VLSI FIR driver to
> make it depend on X86.  The in-tree code guarantees that the driver will only
> build on X86, and according to the comments therein no machine of another
> architecture has this hardware anyway.

Well, it would work with any arch, _if_ there was a way to sync the 
streaming pci dma buffers before giving them back to hardware. Last time I 
checked there was no pci_dma api call to achieve this on all platforms. 
For X86 however it's trivial due to cache coherency.

The guy is used with X86 notebooks only - unless whoever owns the 
controller design decides to make some CardBus PC-Card for people with 
notebooks lacking IrDA-support.

> Granted, no human intelligently configuring a kernel for his or her particular
> system would make this mistake, but perhaps someone building a distribution
> kernel would.  I suggest this patch because it keeps the signal to noise ratio
> for those testing allyesconfig builds low.

Valid point, yes.

> This patch applies to the linux-2.5 BK tree as of 0400 UTC 10/20/2003, and for
> some time before that as well.  Please consider for eventual inclusion.  It may
> be too much of a fringe case until 2.6.0 begins its stable series.

Thanks, second this.

Martin

