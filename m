Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132633AbRDRQha>; Wed, 18 Apr 2001 12:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132872AbRDRQhV>; Wed, 18 Apr 2001 12:37:21 -0400
Received: from smtp102.urscorp.com ([38.202.96.105]:6670 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S132633AbRDRQhP>; Wed, 18 Apr 2001 12:37:15 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: alan@lxorguk.ukuu.org.uk, jgarzik@havoc.gtf.org,
        linux-kernel@vger.kernel.org, Mike Phillips <mikep@linuxtr.net>,
        torvalds@transmeta.com
Subject: Re: [PATCH] Updated Olympic Driver
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OFC657FBF0.E7DC8B96-ON85256A32.00548430@urscorp.com>
Date: Wed, 18 Apr 2001 12:29:35 -0400
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 04/18/2001 12:33:21 PM,
	Serialize complete at 04/18/2001 12:33:21 PM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

Thanks for the comments. This patch has been hanging too long already, the 
drivers should be updated as given and I'll work up all the fixes and 
another patch.

>> +       sisr=readl(olympic_mmio+SISR_RR) ;  /* Read & Reset sisr */

> you should also check for 0xFFFFFFFF, which will happen if the hardware
> disappears...

We catch it in the Adapter Check and gracefully exit. 

>>         struct olympic_tx_status 
olympic_tx_status_ring[OLYMPIC_TX_RING_SIZE];

> With PCI DMA you (theoretically) never pass any members of your private
> struct directly to the chip.  thus, either your comment or code is
> wrong...

On the cards to completely remove these structures from the private struct 
and allocate them in the driver. 

All other comments will be incorporated. 

Mike

