Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267708AbUJRTv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUJRTv2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267798AbUJRTvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:51:18 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:46474 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267708AbUJRTpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:45:55 -0400
Subject: Re: cciss update [2/2] fixes for Steeleye Lifekeeper
From: James Bottomley <James.Bottomley@SteelEye.com>
To: mikem <mikem@beardog.cca.cpqcorp.net>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20041018163532.GA24511@beardog.cca.cpqcorp.net>
References: <20041013212253.GB9866@beardog.cca.cpqcorp.net>
	<20041014083900.GB7747@infradead.org> <1097764660.2198.11.camel@mulgrave>
	<20041014183948.GA12325@infradead.org> <1097852716.1718.9.camel@mulgrave> 
	<20041018163532.GA24511@beardog.cca.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Oct 2004 14:45:24 -0500
Message-Id: <1098128731.2011.296.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 11:35, mikem wrote:
> This patch only registers the controller if no logical drives are configured. It will not result in all possible logical drives being added. I added printk's to the driver to show me what I'm registering.
> What I see is the controller registers every time, and only drives that are phsically configured are registered. That is true for reserved drives, also.

It also looks like this device is always the one used when the array
comes on line, so it's only a shadow for as long as the actual array has
none of it's storage configured.  OK.

The code also seems to imply that we use a single block queue for all of
the array devices ... isn't that a bit inefficient?

James




