Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271185AbRHOOCU>; Wed, 15 Aug 2001 10:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271195AbRHOOCK>; Wed, 15 Aug 2001 10:02:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39552 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271185AbRHOOB4>;
	Wed, 15 Aug 2001 10:01:56 -0400
Date: Wed, 15 Aug 2001 07:02:04 -0700 (PDT)
Message-Id: <20010815.070204.39155321.davem@redhat.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010815151052.C4352@suse.de>
In-Reply-To: <20010815140740.A4352@suse.de>
	<20010815.053524.48804759.davem@redhat.com>
	<20010815151052.C4352@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Wed, 15 Aug 2001 15:10:52 +0200

   On Wed, Aug 15 2001, David S. Miller wrote:
   >    The only truly problematic area is the alt_address thing.
   >    It is would be a nice thing to rip this eyesore out of the scsi
   >    layer anyways.
   
   The SCSI issue was exactly what was on my mind, and is indeed the reason
   why I didn't go all the way and did a complete conversion there. The
   SCSI layer is _not_ very clean in this regard, didn't exactly enjoy this
   part of the work...
   
I just took a quick look at this, and I think I can make this
alt_address thing into a scsi-layer-specific mechanism and
thus be able to safely remove it from struct scatterlist.

Would you like me to whip up such a set of changes?  I'll be
more than happy to work on it.

   >    Yep. Want me to add in the x86 parts of your patch?
   > 
   > Please let me finish up my prototype with sparc64 building and
   > working, then I'll send you what I have ok?
   
   Fine
   
This is forthcoming.

Later,
David S. Miller
davem@redhat.com
