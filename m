Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVDDO0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVDDO0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 10:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVDDO0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 10:26:10 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:10719 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261264AbVDDOZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 10:25:47 -0400
Subject: Re: iomapping a big endian area
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "David S. Miller" <davem@davemloft.net>, matthew@wil.cx,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050404141616.GA10384@infradead.org>
References: <1112475134.5786.29.camel@mulgrave>
	 <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
	 <20050402183805.20a0cf49.davem@davemloft.net>
	 <20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>
	 <1112499639.5786.34.camel@mulgrave>
	 <20050402200858.37347bec.davem@davemloft.net>
	 <1112502477.5786.38.camel@mulgrave> <1112601039.26086.49.camel@gaston>
	 <1112623143.5813.5.camel@mulgrave>  <20050404141616.GA10384@infradead.org>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 09:25:05 -0500
Message-Id: <1112624705.5813.19.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 15:16 +0100, Christoph Hellwig wrote:
> The IOC4 device that provides IDE, serial ports and external interrupts
> on Altix systems has a big endian register layour, and the PCI-X bridge
> in those Altix systems can do the swapping if a special bit is set.
> 
> In older kernels that bit was set from the driver through a special API,
> but it seems the firmware does that automatically now.

We already have some unusual code in drivers to support other altix
design ... features ... do you regard this as something that's likely to
be replicated on other platforms, or is it more in the category of a one
off mistake that can be corrected in firmware?

James


