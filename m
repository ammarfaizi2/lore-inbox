Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262810AbREVUtR>; Tue, 22 May 2001 16:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262811AbREVUtH>; Tue, 22 May 2001 16:49:07 -0400
Received: from geos.coastside.net ([207.213.212.4]:19900 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S262810AbREVUs6>; Tue, 22 May 2001 16:48:58 -0400
Mime-Version: 1.0
Message-Id: <p05100312b7307eda5292@[207.213.214.37]>
In-Reply-To: <20010522132815.A4573@twiddle.net>
In-Reply-To: <15112.59880.127047.315855@pizda.ninka.net>
 <20010521125032.K30738@athlon.random>
 <15112.62766.368436.236478@pizda.ninka.net>
 <20010521131959.M30738@athlon.random>
 <20010521155151.A10403@jurassic.park.msu.ru>
 <20010521105339.A1907@twiddle.net> <20010522025658.A1116@athlon.random>
 <20010522162916.B15155@athlon.random>
 <20010522184409.A791@jurassic.park.msu.ru>
 <20010522170016.D15155@athlon.random> <20010522132815.A4573@twiddle.net>
Date: Tue, 22 May 2001 13:48:23 -0700
To: Richard Henderson <rth@twiddle.net>, Andrea Arcangeli <andrea@suse.de>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: alpha iommu fixes
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:28 PM -0700 2001-05-22, Richard Henderson wrote:
>On Tue, May 22, 2001 at 05:00:16PM +0200, Andrea Arcangeli wrote:
>>  I'm also wondering if ISA needs the sg to start on a 64k boundary,
>
>Traditionally, ISA could not do DMA across a 64k boundary.
>
>The only ISA card I have (a soundblaster compatible) appears
>to work without caring for this, but I suppose we should pay
>lip service to pedantics.

64KB for 8-bit DMA; 128KB for 16-bit DMA. It's a limitation of the 
legacy third-party-DMA controllers, which had only 16-bit address 
registers (the high part of the address lives in a non-counting 
register). This doesn't apply to bus-master DMA, just the legacy 
(8237) stuff. There was also a 24-bit address limitation.
-- 
/Jonathan Lundell.
