Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269521AbRHCRvo>; Fri, 3 Aug 2001 13:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269527AbRHCRve>; Fri, 3 Aug 2001 13:51:34 -0400
Received: from H73.C223.tor.velocet.net ([216.138.223.73]:18949 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S269521AbRHCRvU>; Fri, 3 Aug 2001 13:51:20 -0400
Date: Fri, 3 Aug 2001 13:46:32 -0400
From: William Park <opengeometry@yahoo.ca>
To: Paul <pstroud@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mulitple 3c509 cards 2.4.x Kernel
Message-ID: <20010803134632.B914@node0.opengeometry.ca>
Mail-Followup-To: Paul <pstroud@bellsouth.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B6ADBA7.2FC0AE2A@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B6ADBA7.2FC0AE2A@bellsouth.net>; from pstroud@bellsouth.net on Fri, Aug 03, 2001 at 01:13:12PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 01:13:12PM -0400, Paul wrote:
> I have a x86 server with multiple(2) 3c509 cards. When I build the
> 3c509 driver into the kernel. It will only pick up a single card. The
> cards are NOT in pnp mode according to isapnp on boot. I have added:
> 
> append = "ether=3,0x300,0,0,eth0 ether=10,0x280,0,0,eth1"
> 
> to the lilo file and still only one card is detected. The io ports and
> irq's come direct from /proc with  the 2.2.13 kernel in place. There
> are no messages about anything failing, only the message that the one
> card was found. It appears the card on the higher io(0x300) is the
> only one that is ever found.
> 
> The machine is an old p100 with no no other cards except the video
> card.  I have tested this with every kernel from 2.4.0-testxx to the
> 2.4.6 kernel. I see nothing in the changelog for 2.4.7 that leads me
> to believe it is fixed in that kernel.
> 
> Please CC me on any reply or request as I am not a member of the list.
> 
> Thanks, Paul Stroud

Did you configure your cards (ie. IRQ, IO) using DOS driver or
'3c5x9setup.c'?  It could be that they are both waiting at the same
default irq/io.

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
8 CPUs cluster, (Slackware) Linux, Python, LaTeX, Vim, Mutt, Sc.
