Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276477AbRJ2Qzc>; Mon, 29 Oct 2001 11:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276534AbRJ2QzW>; Mon, 29 Oct 2001 11:55:22 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:3571 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S276477AbRJ2QzL>; Mon, 29 Oct 2001 11:55:11 -0500
Date: Mon, 29 Oct 2001 11:50:46 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch to make 2.4.13 compile on s390
Message-ID: <20011029115046.A9687@devserv.devel.redhat.com>
In-Reply-To: <20011029015210.A10144@devserv.devel.redhat.com> <E15yA2A-0002GW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15yA2A-0002GW-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 29, 2001 at 10:52:46AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 29 Oct 2001 10:52:46 +0000 (GMT)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>

> > --- linux-2.4.13-0.2/arch/s390/config.in	Mon Oct 29 04:28:40 2001
> > +++ linux-2.4.13-0.2-t1/arch/s390/config.in	Mon Oct 29 06:22:48 2001
> > +define_bool CONFIG_GENERIC_ISA_DMA y
> 
> Please tell me where you find an S/390 mainframe with ISA bus. I think you
> may have fixed the effect not the cause.

This picks empty placeholders for request_dma, free_dma
that kernel/dma.c provides. Before, dma.o always was
compiled regardless of CONFIG_GENERIC_ISA_DMA.

-- Pete
