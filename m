Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSFDIfe>; Tue, 4 Jun 2002 04:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316567AbSFDIfd>; Tue, 4 Jun 2002 04:35:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21166 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316545AbSFDIfc>;
	Tue, 4 Jun 2002 04:35:32 -0400
Date: Tue, 4 Jun 2002 10:35:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH/RFC: fix 2.5.20 ramdisk
Message-ID: <20020604083525.GA2512@suse.de>
In-Reply-To: <20020603180627.A23056@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03 2002, Russell King wrote:
> 2.5.20 seems to be incapable of executing binaries in a ramdisk-based
> root filesystem.  The ramdisk in question is an ext2fs, with a 1K
> block size loaded via the compressed ramdisk loader in do_mounts().
> 
> It appears that, in the case of a 1K block sized filesystem, we attempt
> to read two 512-byte sectors into a BIO vector.  The first one is copied
> into the first 512 bytes.  The second sector, however, is copied over
> the first 512 bytes.  Obviously not what we really want.
> 
> Here is _a_ patch which solves this for me, which may not be correct.
> Jens?

Looks good.

-- 
Jens Axboe

