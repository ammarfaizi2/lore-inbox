Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVDHAAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVDHAAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVDHAAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:00:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13540 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262617AbVDHAAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:00:35 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: iomapping a big endian area
Date: Thu, 7 Apr 2005 16:57:53 -0700
User-Agent: KMail/1.7.2
Cc: Christoph Hellwig <hch@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "David S. Miller" <davem@davemloft.net>, matthew@wil.cx,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1112475134.5786.29.camel@mulgrave> <20050404141616.GA10384@infradead.org> <1112624705.5813.19.camel@mulgrave>
In-Reply-To: <1112624705.5813.19.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504071657.54172.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 4, 2005 7:25 am, James Bottomley wrote:
> On Mon, 2005-04-04 at 15:16 +0100, Christoph Hellwig wrote:
> > The IOC4 device that provides IDE, serial ports and external interrupts
> > on Altix systems has a big endian register layour, and the PCI-X bridge
> > in those Altix systems can do the swapping if a special bit is set.
> >
> > In older kernels that bit was set from the driver through a special API,
> > but it seems the firmware does that automatically now.
>
> We already have some unusual code in drivers to support other altix
> design ... features ... do you regard this as something that's likely to
> be replicated on other platforms, or is it more in the category of a one
> off mistake that can be corrected in firmware?

The whole line of altix pci bridges can do byteswapping, so it's more than 
just one product that could benefit (however slightly).  Not sure about other 
bridges though.

Jesse
