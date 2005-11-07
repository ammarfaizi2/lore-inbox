Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVKGDd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVKGDd0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVKGDd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:33:26 -0500
Received: from verein.lst.de ([213.95.11.210]:24286 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932419AbVKGDdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:33:25 -0500
Date: Mon, 7 Nov 2005 04:33:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       axboe@suse.de
Subject: Re: [PATCH 13/25] loop: move ioctl32 code to loop.c
Message-ID: <20051107033322.GA15864@lst.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162715.758021000@b551138y.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105162715.758021000@b551138y.boeblingen.de.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 05:27:03PM +0100, Arnd Bergmann wrote:
> The loop device driver is the only user of its ioctl
> commands, so we can move the conversion handlers
> for 32 bit emulation into the driver itself.
> 
> This patch just moves over the function, it would
> probably be a good idea to get rid of get_fs/set_fs
> calls here by integrating better with the driver.

Yes.  just moving over is pointless.  for things like loop where
there's just one driver implementing the api moving it there does
make sense, but please bring the compat layer up to standards first.

