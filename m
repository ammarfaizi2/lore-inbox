Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTEDFmj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 01:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263516AbTEDFmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 01:42:37 -0400
Received: from verein.lst.de ([212.34.181.86]:44812 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263510AbTEDFmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 01:42:35 -0400
Date: Sun, 4 May 2003 07:55:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: =?iso-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH 2.5] [TRIVIAL] Get rid of magic numbers in drivers/block/genhd.c
Message-ID: <20030504075502.A6915@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	=?iso-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <20030504000425.726daf8b.l.s.r@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030504000425.726daf8b.l.s.r@web.de>; from l.s.r@web.de on Sun, May 04, 2003 at 12:04:25AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 12:04:25AM +0200, René Scharfe wrote:
> Hi Christoph,
> 
> a few days ago you cleaned up disk_name() in fs/partitions/check.c. It
> is now guaranteed to write no more than BDEVNAME_SIZE into the provided
> buffer.
> 
> There are two buffers in drivers/block/genhd.c, that are used solely for
> calling disk_name(), and have a size of 64. The patch below replaces
> these magic numbers with BDEVNAME_SIZE.
> 
> Additionally it corrects the comment at the top of disk_name(): The md
> driver does not call that function, the genhd driver does.

Looks fine to me.

Rusty, is the trivial patch bot still active?  I haven't seen Marcelo
or Linus merging trivial patches for ages (or maybe I've missed
something?)
