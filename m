Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSG3V2N>; Tue, 30 Jul 2002 17:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316589AbSG3V2M>; Tue, 30 Jul 2002 17:28:12 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:16627 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316599AbSG3V17>; Tue, 30 Jul 2002 17:27:59 -0400
Subject: Re: [PATCH] 2.5.29: some compilation fixes for irq frenzy [OSS +
	i8x0 audio]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1028063953.964.13.camel@andyp>
References: <1028062608.964.6.camel@andyp> 
	<1028067951.8510.44.camel@irongate.swansea.linux.org.uk> 
	<1028063953.964.13.camel@andyp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 23:47:35 +0100
Message-Id: <1028069255.8510.46.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 22:19, Andy Pfiffer wrote:
> As luck would have it, I booted the kernel and played the tunes on a
> 2-way P4 Xeon system.  Nothing wedged, but then again, I didn't try to
> break it.
> 
> So, what did I break?

SMP support I think. A lot of the save_flags/cli stuff you changed looks
like it needs to also lock out interrupts on the other processors,
otherwise you can get a DMA pointer being updated under you.


