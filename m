Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264892AbSLBROU>; Mon, 2 Dec 2002 12:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264901AbSLBROU>; Mon, 2 Dec 2002 12:14:20 -0500
Received: from verein.lst.de ([212.34.181.86]:45321 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S264892AbSLBROT>;
	Mon, 2 Dec 2002 12:14:19 -0500
Date: Mon, 2 Dec 2002 18:21:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] remove IDESCSI_SG_TRANSFORM (compile fix)
Message-ID: <20021202182131.A32468@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, andre@linux-ide.org,
	linux-kernel@vger.kernel.org
References: <20021129235353.A13377@lst.de> <20021130004435.GB3182@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021130004435.GB3182@beaverton.ibm.com>; from andmike@us.ibm.com on Fri, Nov 29, 2002 at 04:44:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 04:44:35PM -0800, Mike Anderson wrote:
> Thanks for catching this Christoph I thought the only use was inside
> SCSI. I could make a patch to scsi-misc to add tag back in. Another
> option if it is still needed is to switch to "->name == "generic").
> 
> Though I have not used this interface I thought if one was using an sg
> device to a ide-scsi device and the flag was set that sg commands that
> where not 100% the same as ATAP commands where translated.

Well, imho IDESCSI_SG_TRANSFORM is broken in 2.5.  Now that ever block
driver implements the sg ioctls a sg request can come from sd or sr
aswell.

