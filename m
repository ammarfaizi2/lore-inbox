Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270550AbUJTUYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270550AbUJTUYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270531AbUJTUUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:20:36 -0400
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:22542 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S270500AbUJTUPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:15:50 -0400
Date: Wed, 20 Oct 2004 15:15:21 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: cciss update [2/2] fixes for Steeleye Lifekeeper
Message-ID: <20041020201521.GB21452@beardog.cca.cpqcorp.net>
References: <20041013212253.GB9866@beardog.cca.cpqcorp.net> <20041014083900.GB7747@infradead.org> <1097764660.2198.11.camel@mulgrave> <20041014183948.GA12325@infradead.org> <1097852716.1718.9.camel@mulgrave> <20041018163532.GA24511@beardog.cca.cpqcorp.net> <1098128731.2011.296.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098128731.2011.296.camel@mulgrave>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 02:45:24PM -0500, James Bottomley wrote:
> On Mon, 2004-10-18 at 11:35, mikem wrote:
> > This patch only registers the controller if no logical drives are configured. It will not result in all possible logical drives being added. I added printk's to the driver to show me what I'm registering.
> > What I see is the controller registers every time, and only drives that are phsically configured are registered. That is true for reserved drives, also.
> 
> It also looks like this device is always the one used when the array
> comes on line, so it's only a shadow for as long as the actual array has
> none of it's storage configured.  OK.
> 
> The code also seems to imply that we use a single block queue for all of
> the array devices ... isn't that a bit inefficient?
> 
> James
Yes, it's not a perfect solution, but I have yet to complete my fairness algorithm for the per drive queues.

mikem
> 
> 
> 
> 
