Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbREVVE1>; Tue, 22 May 2001 17:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbREVVES>; Tue, 22 May 2001 17:04:18 -0400
Received: from are.twiddle.net ([64.81.246.98]:34177 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262821AbREVVEE>;
	Tue, 22 May 2001 17:04:04 -0400
Date: Tue, 22 May 2001 14:02:06 -0700
From: Richard Henderson <rth@twiddle.net>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: alpha iommu fixes
Message-ID: <20010522140206.B4662@twiddle.net>
Mail-Followup-To: Jonathan Lundell <jlundell@pobox.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
In-Reply-To: <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random> <20010521155151.A10403@jurassic.park.msu.ru> <20010521105339.A1907@twiddle.net> <20010522025658.A1116@athlon.random> <20010522162916.B15155@athlon.random> <20010522184409.A791@jurassic.park.msu.ru> <20010522170016.D15155@athlon.random> <20010522132815.A4573@twiddle.net> <p05100312b7307eda5292@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p05100312b7307eda5292@[207.213.214.37]>; from jlundell@pobox.com on Tue, May 22, 2001 at 01:48:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 01:48:23PM -0700, Jonathan Lundell wrote:
> 64KB for 8-bit DMA; 128KB for 16-bit DMA. [...]  This doesn't
> apply to bus-master DMA, just the legacy (8237) stuff.

Would this 8237 be something on the ISA card, or something on
the old pc mainboards?  I'm wondering if we can safely ignore
this issue altogether here...

> There was also a 24-bit address limitation.

Yes, that's in the number of address lines going to the isa card.
We work around that one by having an iommu arena from 8M to 16M
and forcing all ISA traffic to go through there.


r~
