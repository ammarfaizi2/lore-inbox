Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268329AbTAMUsX>; Mon, 13 Jan 2003 15:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268331AbTAMUsX>; Mon, 13 Jan 2003 15:48:23 -0500
Received: from AMarseille-201-1-3-195.abo.wanadoo.fr ([193.253.250.195]:5488
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268329AbTAMUsW>; Mon, 13 Jan 2003 15:48:22 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ross Biro <rossb@google.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E23114E.8070400@google.com>
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
	 <1042399796.525.215.camel@zion.wanadoo.fr>
	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk>
	 <1042401074.525.219.camel@zion.wanadoo.fr>  <3E230A4D.6020706@google.com>
	 <1042484609.30837.31.camel@zion.wanadoo.fr>  <3E23114E.8070400@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042491409.586.4.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 13 Jan 2003 21:56:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 20:19, Ross Biro wrote:

> and read the alt status register to get a delay.
> 
> This is technically a spec violation, but it's probably safe.  I'm going 
> to send an email to a couple of the drive manufacturers and see what 
> they think.

Or get back to my original idea of an IOSYNC() callback in hwif. For
standard PCI controllers with DMA, it's enough to read the dma_status
register which is on the same bus path. Others will have to provide
some implementation or be unsafe on some non-x86. What do you think ?

Ben.


