Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVK3X1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVK3X1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVK3X1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:27:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:34492 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751242AbVK3X1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:27:14 -0500
Subject: Re: 2.6.15-rc3-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051130162324.GA15273@infradead.org>
References: <20051129203134.13b93f48.akpm@osdl.org>
	 <20051130162324.GA15273@infradead.org>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 10:18:25 +1100
Message-Id: <1133392706.16726.91.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-30 at 16:23 +0000, Christoph Hellwig wrote:
> On Tue, Nov 29, 2005 at 08:31:34PM -0800, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc3/2.6.15-rc3-mm1/
> > 
> > - Several ISA sound drivers don't compile.  This is due to a collision
> >   between the ALSA and PCMCIA trees, and to breakage in the ALSA tree.
> > 
> > - drivers/serial/jsm/* still doesn't compile.
> 
> Maybe it's time to drop the driver again?  It's known to be very abusive
> of tty internals it shouldn't touch and the vendor blocks adding more
> hardware support to it because it prefers it own (even worse) driver.
> 
> This will give IBM who apparently cares about this hardware the chance to
> reintroduce a proper driver again that supports all hardware and doesn't
> abuse the tty layer.

Aren't UARTs driven by this driver also compatible with the 8250 one ?

Ben.


