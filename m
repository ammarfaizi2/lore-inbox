Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282105AbRK1KWO>; Wed, 28 Nov 2001 05:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282118AbRK1KWF>; Wed, 28 Nov 2001 05:22:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27654 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282105AbRK1KVw>;
	Wed, 28 Nov 2001 05:21:52 -0500
Date: Wed, 28 Nov 2001 11:21:26 +0100
From: Jens Axboe <axboe@suse.de>
To: Slo Mo Snail <slomosnail@gmx.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c
Message-ID: <20011128112126.P23858@suse.de>
In-Reply-To: <20011127204819Z282941-17408+21242@vger.kernel.org> <20011127213632Z282969-17409+18118@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011127213632Z282969-17409+18118@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27 2001, Slo Mo Snail wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I think the patch doesn't work :(
> When I try to mount a CD over SCSI emulation I get this nice oops:

Please try this patch, ide-scsi is over writing the io veclist (longer
story: the io_vec_list used to be embedded so memset'ing the bio would
be ok).

BTW, this could be handled smarter with the new scheme -- no need to
link the bio, more segments can be crammed into just one. Someone
playing around with making ide-scsi faster can do that though, I'm just
making it work :-)

kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre2/bio-pre2-2

-- 
Jens Axboe

