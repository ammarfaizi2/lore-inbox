Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbSLBVk7>; Mon, 2 Dec 2002 16:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbSLBVk7>; Mon, 2 Dec 2002 16:40:59 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:44959 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263899AbSLBVk6>; Mon, 2 Dec 2002 16:40:58 -0500
Subject: Re: [RFC] remove IDESCSI_SG_TRANSFORM (compile fix)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021202182131.A32468@lst.de>
References: <20021129235353.A13377@lst.de>
	<20021130004435.GB3182@beaverton.ibm.com>  <20021202182131.A32468@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Dec 2002 22:22:04 +0000
Message-Id: <1038867724.8952.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 17:21, Christoph Hellwig wrote:
> On Fri, Nov 29, 2002 at 04:44:35PM -0800, Mike Anderson wrote:
> > Thanks for catching this Christoph I thought the only use was inside
> > SCSI. I could make a patch to scsi-misc to add tag back in. Another
> > option if it is still needed is to switch to "->name == "generic").
> > 
> > Though I have not used this interface I thought if one was using an sg
> > device to a ide-scsi device and the flag was set that sg commands that
> > where not 100% the same as ATAP commands where translated.
> 
> Well, imho IDESCSI_SG_TRANSFORM is broken in 2.5.  Now that ever block
> driver implements the sg ioctls a sg request can come from sd or sr
> aswell.

Quite possibly, but newer drivers that might used sd/sr via the new
API's should also know about the newer standards. Older sg users are not
always so bright.


