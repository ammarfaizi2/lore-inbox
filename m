Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbUK3Tz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbUK3Tz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUK3TxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:53:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:7892 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262288AbUK3TrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:47:00 -0500
Date: Tue, 30 Nov 2004 11:46:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm4
Message-Id: <20041130114633.22eee22d.akpm@osdl.org>
In-Reply-To: <1101836642.25617.63.camel@localhost.localdomain>
References: <20041130095045.090de5ea.akpm@osdl.org>
	<1101837994.2640.67.camel@laptop.fenrus.org>
	<20041130102105.21750596.akpm@osdl.org>
	<1101839110.2640.69.camel@laptop.fenrus.org>
	<20041130103218.513b8ce0.akpm@osdl.org>
	<1101836642.25617.63.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Maw, 2004-11-30 at 18:32, Andrew Morton wrote:
> > "This helps mainly graphic drivers who really need a lot of memory below
> > the 4GB area.  Previous they could only use IOMMU+16MB GFP_DMA, which was
> > not enough memory."
> > 
> > >  Is there code using the zone GFP mask yet ??
> > 
> > Nope.
> 
> You mean its a private hook for a proprietary graphics driver, which
> because it is that can't use it anyway ?

I wasn't aware that this is what I meant.  I dunno what graphics drivers
Andi needs it for, and he is away for a couple of weeks.  It's an
experimental patch, in there for testing.

> That sounds dubious to me as policy has always been to avoid such hooks.

I don't know why you're assuming that it is "such a hook".  Sticking
"gfp_dma32" into google indicates that the applications are quite
different.

