Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263530AbTH0Qsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbTH0Qsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:48:50 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:14241 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263530AbTH0Qss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:48:48 -0400
Subject: Re: [PATCH 2.6][TRIVIAL] Update ide.txt documentation to current
	ide.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mlord@pobox.com,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.51.0308271839110.32333@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0308211225120.23765@dns.toxicfilms.tv>
	 <1061998172.22825.51.camel@dhcp23.swansea.linux.org.uk>
	 <Pine.LNX.4.51.0308271839110.32333@dns.toxicfilms.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062002865.22739.89.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 27 Aug 2003 17:47:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-27 at 17:41, Maciej Soltysiak wrote:
> > >   "hdx=slow"		: insert a huge pause after each access to the data
> > >  			  port. Should be used only as a last resort.
> >
> > Should go - isnt supported any more
> So drivers/ide/ide.c should be updated too.

Yes

> > > + "ide=reverse"		: formerly called to pci sub-system, but now local.
> > > +
> >
> > Better if it said what it did ?
> drivers/ide/ide.c says only this.

It reverses the order that interfaces are detected (and thus assigned
ide*). Or it used to. The hotplug changes may actually mean it doesn't 
do anything any more but that is easy to test.

ie if you had

ide0: AMD74xx 
ide1: PDC202xx

you'd get

ide0: PDC202xx
ide1: AMD74xx

with =reverse

