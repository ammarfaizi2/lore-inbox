Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSG3Vdi>; Tue, 30 Jul 2002 17:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316605AbSG3Vdi>; Tue, 30 Jul 2002 17:33:38 -0400
Received: from air-2.osdl.org ([65.172.181.6]:8911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S316664AbSG3Vch>;
	Tue, 30 Jul 2002 17:32:37 -0400
Subject: Re: [PATCH] 2.5.29: some compilation fixes for irq frenzy [OSS +
	i8x0 audio]
From: Andy Pfiffer <andyp@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1028069255.8510.46.camel@irongate.swansea.linux.org.uk>
References: <1028062608.964.6.camel@andyp> 
	<1028067951.8510.44.camel@irongate.swansea.linux.org.uk> 
	<1028063953.964.13.camel@andyp> 
	<1028069255.8510.46.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Jul 2002 14:35:56 -0700
Message-Id: <1028064957.964.16.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 15:47, Alan Cox wrote:
> On Tue, 2002-07-30 at 22:19, Andy Pfiffer wrote:
> > As luck would have it, I booted the kernel and played the tunes on a
> > 2-way P4 Xeon system.  Nothing wedged, but then again, I didn't try to
> > break it.
> > 
> > So, what did I break?
> 
> SMP support I think. A lot of the save_flags/cli stuff you changed looks
> like it needs to also lock out interrupts on the other processors,
> otherwise you can get a DMA pointer being updated under you.
> 

Thanks.  I'll take a look at it. --Andy


