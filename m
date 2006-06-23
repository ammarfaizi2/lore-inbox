Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932983AbWFWKCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932983AbWFWKCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932986AbWFWKCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:02:05 -0400
Received: from verein.lst.de ([213.95.11.210]:2228 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932983AbWFWKCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:02:03 -0400
Date: Fri, 23 Jun 2006 12:01:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org,
       agk@redhat.com, mbroz@redhat.com, hch@lst.de
Subject: Re: [PATCH 01/15] dm: support ioctls on mapped devices
Message-ID: <20060623100132.GB6985@lst.de>
References: <20060621193121.GP4521@agk.surrey.redhat.com> <20060622151721.GT19222@agk.surrey.redhat.com> <20060622095551.b5c6ddce.akpm@osdl.org> <200606222231.17465.kevcorry@us.ibm.com> <20060622204907.48c0b841.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622204907.48c0b841.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 08:49:07PM -0700, Andrew Morton wrote:
> My head is spinning in a twisty maze of ioctls.  What _should_ we call? 
> file_operations.foo_ioctl() or block_device_operations.foo_ioctl() or
> blkdev_ioctl()?

Neither.  The only valid way to perform ioctls on blockdevices from
kernelspace is ioctl_by_bdev.

