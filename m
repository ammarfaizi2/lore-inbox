Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276343AbRJDVje>; Thu, 4 Oct 2001 17:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277239AbRJDVjZ>; Thu, 4 Oct 2001 17:39:25 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:33155 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S273996AbRJDVjR>; Thu, 4 Oct 2001 17:39:17 -0400
Date: Thu, 4 Oct 2001 15:39:05 -0600
Message-Id: <200110042139.f94Ld5r09675@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "David S. Miller" <davem@redhat.com>
Cc: arjan@fenrus.demon.nl, kravetz@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
In-Reply-To: <20011004.142523.54186018.davem@redhat.com>
In-Reply-To: <20011004140417.C1245@w-mikek2.des.beaverton.ibm.com>
	<E15pFor-0004sC-00@fenrus.demon.nl>
	<20011004.142523.54186018.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
>    From: arjan@fenrus.demon.nl
>    Date: Thu, 04 Oct 2001 22:14:13 +0100
>    
>    > Comments?
>    
>    2.4.x supports SSE on pentium III/athlons, so the SSE registers need to be
>    saved/restored on a taskswitch as well.... that's not exactly free.
> 
> lat_ctx doesn't execute any FPU ops.  So at worst this happens once
> on GLIBC program startup, but then never again.

Has something changed? Last I looked, the whole lmbench timing harness
was based on using the FPU. That was the cause of the big argument
Larry and I had some years back: my context switch benchmark didn't
use the FPU, and thus was more sensitive to variations (such as cache
misses due to aliasing).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
