Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUHAP6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUHAP6B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 11:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUHAP6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 11:58:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45508 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263736AbUHAP57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 11:57:59 -0400
Date: Sun, 1 Aug 2004 17:57:53 +0200
From: Jens Axboe <axboe@suse.de>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problems
Message-ID: <20040801155753.GA13702@suse.de>
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de> <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de> <20040731210257.GA22560@bliss> <cehqak$1pq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cehqak$1pq$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01 2004, Alexander E. Patrakov wrote:
> Zinx Verituse wrote:
> >I don't believe command filtering is neccessary, since all of the
> >ide-cd ioctls are still there (ioctls that allow playing, reading, etc)
> >Only the SG_IO ioctl itself would have to be checked (i.e., not each
> >individual command available with SG_IO, just the overall ioctl itself,
> >categorizing all of SG_IO more or less as raw IO.  If this isn't doable
> >with the current design, then the ide-cd interface should at least be
> >very conspicuously documented as being extremely insecure as far as
> >"read" access is concerned, as I know I wouldn't expect users to be able
> >to overwrite my drive's firmware simply by granting the read access.
> >
> 
> Remember that it is still possible to write CDs through ide-cd in 2.4.x 
> using some pre-alpha code in cdrecord:
> 
> cdrecord dev=ATAPI:1,1,0 image.iso

(don't trim cc lists on linux-kernel!)

Don't ever use that interface, period. It's not just the cdrecord code
that may be alpha (I doubt it matters, it's easy to use), the interface
it uses is not worth the lines of code it occupies.

-- 
Jens Axboe

