Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267440AbTALTwh>; Sun, 12 Jan 2003 14:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbTALTwh>; Sun, 12 Jan 2003 14:52:37 -0500
Received: from AMarseille-201-1-1-174.abo.wanadoo.fr ([193.252.38.174]:51825
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267440AbTALTwg>; Sun, 12 Jan 2003 14:52:36 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042404053.16288.25.camel@irongate.swansea.linux.org.uk>
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
	 <1042399796.525.215.camel@zion.wanadoo.fr>
	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk>
	 <1042401074.525.219.camel@zion.wanadoo.fr>
	 <1042404053.16288.25.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042401776.541.228.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 12 Jan 2003 21:02:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 21:40, Alan Cox wrote:
> On Sun, 2003-01-12 at 19:51, Benjamin Herrenschmidt wrote:
> > What about PCI write posting ? How can we enforce the 400ns delay here ?
> 
> For i/o space it is ok as in*/out* are synchronous. For mmio right now I
> don't know. I need to talk to Andre about that for SATA. I guess for the
> PPC its going to be fun

Thinking about it, it might make sense to provide an hwif->IOSYNC iop along
with {IN/OUT}{B,W,L} that would be a no-op by default for that.

Ben.


