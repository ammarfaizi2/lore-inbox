Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbRGJSSQ>; Tue, 10 Jul 2001 14:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267045AbRGJSSG>; Tue, 10 Jul 2001 14:18:06 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:62403 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267043AbRGJSRy>; Tue, 10 Jul 2001 14:17:54 -0400
Date: Tue, 10 Jul 2001 19:17:19 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mike Black <mblack@csihq.com>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: 2.4.6 and ext3-2.4-0.9.1-246
Message-ID: <20010710191719.B1493@redhat.com>
In-Reply-To: <200107101752.f6AHqXUu022141@webber.adilger.int> <018101c1096a$17e2afc0$b6562341@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <018101c1096a$17e2afc0$b6562341@cfl.rr.com>; from mblack@csihq.com on Tue, Jul 10, 2001 at 01:59:40PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 10, 2001 at 01:59:40PM -0400, Mike Black wrote:
> Yep -- I said __files__ -- I'm less concerned about performance than
> reliability -- I don't think you can RAID1 a swap partition can you?

You can on 2.4.  2.2 would let you do it but it was unsafe --- swap
could interact badly with raid reconstruction.  2.4 should be OK.

> Also,
> having it in files allows me to easily add more swap as needed.
> As far as journalling mode I just used tune2fs to put a journal on with
> default parameters so I assume that's full journaling.

The swap code bypasses filesystem writes: all it does is to ask the
filesystem where on disk the data resides, then it performs IO
straight to those disk blocks.  The data journaling mode doesn't
really matter there.

Cheers,
 Stephen
