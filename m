Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWC2Vuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWC2Vuf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 16:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWC2Vuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 16:50:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:22429 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750993AbWC2Vuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 16:50:35 -0500
Date: Thu, 30 Mar 2006 07:49:57 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060330074957.C921158@wobbly.melbourne.sgi.com>
References: <20060329122841.GC8186@suse.de> <442A8883.9060909@garzik.org> <20060329132724.GF8186@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060329132724.GF8186@suse.de>; from axboe@suse.de on Wed, Mar 29, 2006 at 03:27:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 03:27:25PM +0200, Jens Axboe wrote:
> On Wed, Mar 29 2006, Jeff Garzik wrote:
> > to cause sys_splice() to default to supported?
> 
> It should probably work, the fs guys should know more about that. Any fs
> that ->prepare_write(), ->commit_write() works for can use
> generic_file_splice_write(). I prefer to keep it sane for now, mason
> tells me that eg xfs might need special care.

It looks pretty straightforward to get XFS support done - we will
likely need routines that wrap around generic_file_splice_read /
write to handle offline files for an HSM, etc, but not too tricky.
I'll make the XFS changes once the generic support is in place.

cheers.

-- 
Nathan
