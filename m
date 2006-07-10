Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422629AbWGJOYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422629AbWGJOYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbWGJOYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:24:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50902 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422629AbWGJOYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:24:53 -0400
Subject: Re: Linux v2.6.18-rc1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: will_schmidt@vnet.ibm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Steve Fox <drfickle@us.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1152537672.28828.4.camel@farscape.rchland.ibm.com>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	 <pan.2006.07.07.15.41.35.528827@us.ibm.com>
	 <1152441242.4128.33.camel@localhost.localdomain>
	 <1152537672.28828.4.camel@farscape.rchland.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 15:40:13 +0100
Message-Id: <1152542413.27368.131.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-10 am 08:21 -0500, ysgrifennodd Will Schmidt:
> On Sun, 2006-09-07 at 20:34 +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2006-07-07 at 10:41 -0500, Steve Fox wrote:
> > > We've got a ppc64 machine that won't boot with this due to an IDE error.
> > 
> > What machine precisely ?
> 
> I see a slightly more verbose version on a JS20 blade. 
> 
> hda: dma_timer_expiry: dma status == 0x24
> hda: DMA interrupt recovery
> hda: lost interrupt

That in repeat generally means the IRQ logic on the platform has been
broken. If we don't get interrupts we don't work very well.

Also check if booting with "nodma" set on the relevant ide interface
makes a difference. Just to be sure. If it does then submit patches to
fix the bug.

Alan
