Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267197AbUHIUUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267197AbUHIUUQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267201AbUHIUUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:20:04 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:27554 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S267198AbUHIUTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:19:41 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] QLogic ISP2x00: remove needless busyloop
Date: Mon, 9 Aug 2004 14:19:20 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, ehm@cris.com, grif@cs.ucr.edu,
       linux-kernel@vger.kernel.org
References: <200408091252.58547.bjorn.helgaas@hp.com> <20040809210335.A9711@infradead.org>
In-Reply-To: <20040809210335.A9711@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408091419.20029.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 August 2004 2:03 pm, Christoph Hellwig wrote:
> On Mon, Aug 09, 2004 at 12:52:58PM -0600, Bjorn Helgaas wrote:
> > There's no need to wait for an isp2x00 to recognize a fabric if
> > there's no isp2x00.  Probably nobody will notice the unnecessary
> > slowdown on real hardware, but it's a significant delay on a
> > simulator.
> 
> Don't use that driver.  qla2xxx is the right driver, and qlogicfc is only
> still there and confuses people because davem is lazy and can shout louder
> than others.

I don't use it (note the "there's no isp2x00" bit above).  But it's
still part of ia64 defconfig (which I don't maintain), and it's easier
to tell people "use generic_defconfig" than to tell them to remove
CONFIG_SCSI_QLOGIC_FC by hand.

In general, I think if a driver is in the tree, it should be fair
game for bugfixes.  In fact, I see you did the most recent one to
qlogicfc :-)
