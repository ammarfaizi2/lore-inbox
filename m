Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129903AbRALS0D>; Fri, 12 Jan 2001 13:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRALSZx>; Fri, 12 Jan 2001 13:25:53 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:12805 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S129792AbRALSZq>;
	Fri, 12 Jan 2001 13:25:46 -0500
Date: Fri, 12 Jan 2001 19:25:00 +0100
From: Frank de Lange <frank@unternet.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010112192500.A25057@unternet.org>
In-Reply-To: <3A5F3BF4.7C5567F8@colorfullife.com> <20010112183314.A24174@unternet.org> <3A5F4428.F3249D2@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5F4428.F3249D2@colorfullife.com>; from manfred@colorfullife.com on Fri, Jan 12, 2001 at 06:51:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 06:51:36PM +0100, Manfred Spraul wrote:
> Frank, I've attached a proposed kick_IOAPIC pin. Could you try it?
> I'm rebooting with that patch right now.

I added the patch, and tried it out. When the network hangs, I am able to revive it with ALT-SYSRQ-Q. The debug log shows these entries:

Jan 12 19:22:57 behemoth kernel: SysRq: <0> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
Jan 12 19:22:57 behemoth kernel: Before:
Jan 12 19:22:57 behemoth kernel:  00 003 03  0    1    1   1   1    1    1    99
Jan 12 19:22:57 behemoth kernel: After switching to edge:
Jan 12 19:22:57 behemoth kernel:  00 003 03  0    0    1   1   1    1    1    99
Jan 12 19:22:57 behemoth kernel: After switch back:
Jan 12 19:22:57 behemoth kernel:  00 003 03  0    1    1   1   1    1    1    99

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
