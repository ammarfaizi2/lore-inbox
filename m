Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135856AbRD2SFq>; Sun, 29 Apr 2001 14:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135868AbRD2SFg>; Sun, 29 Apr 2001 14:05:36 -0400
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:24335 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S135856AbRD2SFX>;
	Sun, 29 Apr 2001 14:05:23 -0400
Date: Sun, 29 Apr 2001 20:04:19 +0200
From: Frank de Lange <frank@unternet.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Severe trashing in 2.4.4
Message-ID: <20010429200419.C11681@unternet.org>
In-Reply-To: <20010429194631.A11681@unternet.org> <Pine.GSO.4.21.0104291349530.2210-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0104291349530.2210-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Apr 29, 2001 at 01:58:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 01:58:52PM -0400, Alexander Viro wrote:
> Hmm... I'd say that you also have a leak in kmalloc()'ed stuff - something
> in 1K--2K range. From your logs it looks like the thing never shrinks and
> grows prettu fast...

Same goes for buffer_head:

buffer_head        44236  48520     96 1188 1213    1 :  252  126

quite high I think. 2.4.3 shows this, after about the same time and activity:

buffer_head          891   2880     96   72   72    1 :  252  126

Cheers//Frank

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
