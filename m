Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUJ0HWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUJ0HWx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 03:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUJ0HWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 03:22:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30893 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261529AbUJ0HWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 03:22:45 -0400
Date: Wed, 27 Oct 2004 09:22:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC] Rename SECTOR_SIZE to IDE_SECTOR_SIZE
Message-ID: <20041027072212.GN15910@suse.de>
References: <20041027060828.GA32396@taniwha.stupidest.org> <417F4497.3020205@pobox.com> <20041027065524.GA1524@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027065524.GA1524@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26 2004, Chris Wedgwood wrote:
> On Wed, Oct 27, 2004 at 02:47:51AM -0400, Jeff Garzik wrote:
> 
> > It's highly silly to rename the same name + the same value to
> > multiple different names.
> 
> initially i was going to do that, but when i looked at the code i
> realized the problem is some of the users seem to be semantically
> different and potentially might want to be changed separate to the
> others
> 
> > Put it in a common header somewhere, and only rename the oddballs
> > (if any).
> 
> we could have UNIX_SECTOR_SIZE in blkdev.h but as i said, some users
> really are 512 for different reasons that might change (?)

Please, just call it IO_SECTOR_SIZE or BIO_SECTOR_SIZE to signify that
it's the block io sector size. And use that where it applies, leave the
rest of the unrelated cases alone.

-- 
Jens Axboe

