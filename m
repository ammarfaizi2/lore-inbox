Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267435AbTALTpD>; Sun, 12 Jan 2003 14:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbTALTpD>; Sun, 12 Jan 2003 14:45:03 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46486
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267435AbTALTpA>; Sun, 12 Jan 2003 14:45:00 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042401074.525.219.camel@zion.wanadoo.fr>
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
	 <1042399796.525.215.camel@zion.wanadoo.fr>
	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk>
	 <1042401074.525.219.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042404053.16288.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 12 Jan 2003 20:40:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 19:51, Benjamin Herrenschmidt wrote:
> What about PCI write posting ? How can we enforce the 400ns delay here ?

For i/o space it is ok as in*/out* are synchronous. For mmio right now I
don't know. I need to talk to Andre about that for SATA. I guess for the
PPC its going to be fun

> > 2.  The code is racey in some situations with a shared IRQ because we
> > may get an IRQ after we set the handler but before we send the command,
> > or implemnted the other way the command can complete before we set the
> > handler.
> 
> Yup, that's an old problem indeed.

Time for it to die.... 

