Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbTIHOd1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbTIHOd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:33:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54914 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262248AbTIHOdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:33:23 -0400
Date: Mon, 8 Sep 2003 16:33:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [blockdevices/NBD] huge read/write-operations are splitted by the kernel
Message-ID: <20030908143334.GS840@suse.de>
References: <bjgh6a$82o$1@sea.gmane.org> <20030908085802.GH840@suse.de> <bjhtmm$crf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bjhtmm$crf$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08 2003, Sven Köhler wrote:
> >You'll probably find that if you bump the max_sectors count if your
> >drive to 256 from 255 (that is the default if you haven't set it), then
> >you'll see 128kb chunks all the time.
> 
> Why is 255 the default. It seems to be an inefficient value. Perhaps the 
> NBD itself should set it to 256.

To avoid 8-bit wrap arounds, basically. Not sure it's still very valid,
you are free to compile your kernel with it set to 256. 2.6 uses 256 by
default.

> >See max_sectors[] array.
> 
> Well, i found the declaration, but i can't imagine how to set the values 
> in it.

You can grep for other examples in the kernel, I would imagine?

-- 
Jens Axboe

