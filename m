Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbRCSAXe>; Sun, 18 Mar 2001 19:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131318AbRCSAXY>; Sun, 18 Mar 2001 19:23:24 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:58658 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131317AbRCSAXS>; Sun, 18 Mar 2001 19:23:18 -0500
Date: Sun, 18 Mar 2001 19:22:21 -0500
From: Tim Waugh <twaugh@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: Mike Galbraith <mikeg@wen-online.de>, linux-kernel@vger.kernel.org,
        Will Newton <will@misconception.org.uk>
Subject: Re: VIA audio and parport in 2.4.2
Message-ID: <20010318192221.A27150@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0103171951340.440-100000@mikeg.weiden.de> <Pine.LNX.4.33.0103190015080.8534-100000@dogfox.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0103190015080.8534-100000@dogfox.localdomain>; from will@misconception.org.uk on Mon, Mar 19, 2001 at 12:16:26AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2001 at 12:16:26AM +0000, Will Newton wrote:

> In /etc/modules.conf I have:
> 
> options parport_pc irq=none
> 
> but dmesg says:
> 
> parport0: PC-style at 0x378 (0x778), irq 7, dma 3
> [PCSPP,TRISTATE,COMPAT,ECP,DMA]

Jeff, this is a bug with the Via code in parport_pc.c.  Basically, the
problem is that the code that detects the Via doesn't know what
parameters you passed.  I know about the problem, but I don't know the
fix yet.

Tim.
*/
