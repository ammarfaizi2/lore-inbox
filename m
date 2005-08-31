Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVHaLMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVHaLMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 07:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVHaLMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 07:12:52 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:64095 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932364AbVHaLMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 07:12:52 -0400
Date: Wed, 31 Aug 2005 13:12:48 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Jens Axboe <axboe@suse.de>
Cc: colin <colin@realtek.com.tw>, linux-kernel@vger.kernel.org
Subject: Re: A problem about DIRECT IO on ext3
Message-ID: <20050831111248.GA2347@harddisk-recovery.nl>
References: <002501c5ac93$6ef754c0$106215ac@realtek.com.tw> <20050829132947.GA21255@harddisk-recovery.com> <20050831080744.GM4018@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831080744.GM4018@suse.de>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 10:07:45AM +0200, Jens Axboe wrote:
> On Mon, Aug 29 2005, Erik Mouw wrote:
> > There are four prerequisites for direct IO:
> > - the file needs to be opened with O_DIRECT
> > - the buffer needs to be page aligned (hint: use getpagesize() instead
> >   of assuming that a page is 4k
> > - reads and writes need to happen *in* multiples of the soft block size
> > - reads and writes need to happen *at* multiples of the soft block size
> 
> Actually, the buffer only needs to be hard block size aligned, same goes
> for the chunk size used for reads/writes.

OK, so that's different from 2.4 where reads/writes needed to be soft
block aligned and buffers page aligned.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
