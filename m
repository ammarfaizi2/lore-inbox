Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVKQWSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVKQWSn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVKQWSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:18:43 -0500
Received: from verein.lst.de ([213.95.11.210]:26592 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S964865AbVKQWSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:18:42 -0500
Date: Thu, 17 Nov 2005 23:18:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, wein@de.ibm.com, Horst.Hummel@de.ibm.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] add compat_ioctl methods to dasd
Message-ID: <20051117221825.GA26057@lst.de>
References: <20051104221652.GB9384@lst.de> <20051112093340.GA15702@lst.de> <1132066277.6014.35.camel@localhost.localdomain> <20051115172438.GA10445@lst.de> <20051116084544.GA25181@lst.de> <1132230452.5463.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132230452.5463.10.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 01:27:32PM +0100, Martin Schwidefsky wrote:
> blkdev_ioctl is explicitly called with a NULL file pointer. That can't
> work with block device drivers that use unlocked ioctls. We'd need to
> create a struct file with at least a valid f_dentry->d_inode->i_bdev
> chain in ioctl_by_bdev to make it work with unlocked ioctls. Not nice ..

Yes, you're right.  Looks like we finally need to do the long-planned
sanitizing of the blkdev ioctl interface first.

Let's drop the patch for now.

