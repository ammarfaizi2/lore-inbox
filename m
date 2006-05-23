Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWEWRjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWEWRjL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWEWRjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:39:10 -0400
Received: from 131.103.46-69.q9.net ([69.46.103.131]:1683 "EHLO
	exchange.gtcorp.com") by vger.kernel.org with ESMTP
	id S1751105AbWEWRjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:39:09 -0400
Subject: Re: Compact Flash Serial ATA patch
From: Russell McConnachie <russell.mcconnachie@guest-tek.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060523172352.GD9528@one-eyed-alien.net>
References: <1148379397.1182.4.camel@gt-alphapbx2>
	 <20060523172352.GD9528@one-eyed-alien.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 23 May 2006 04:41:03 -0600
Message-Id: <1148380863.1364.1.camel@gt-alphapbx2>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

The patch which stopped the DMA problems was adding the model ID to the
dma blacklist in the libata-core.c file. I will create another patch in
unified diff format, it seems that compact flash uses different device
IDs than regular ATA/ATAPI devices.

On Tue, 2006-05-23 at 10:23 -0700, Matthew Dharm wrote:
> On Tue, May 23, 2006 at 04:16:37AM -0600, Russell McConnachie wrote:
> > I was having some trouble with a serial ATA compact flash adapter with
> > libata. I wrote a small patch for the kernel to work around the sanity
> > check, dma blacklisting and device ID detections in ata_dev_classify(). 
> 
> I've had this problem, too.  Apparently, my CF/SATA bridge doesn't support
> DMA, but libata requires it.
> 
> I don't know if this is the right fix (if nothing else the patch needs to
> be sent in unified diff format), but it's certainly something that needs
> fixing.
> 
> Matt
> 
