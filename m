Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270632AbTGNQjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270609AbTGNQjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:39:41 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:27613 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270636AbTGNQgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:36:49 -0400
Date: Mon, 14 Jul 2003 13:47:17 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com
Subject: Re: PATCH: make pcmcica devices report pcmcia bus info in gdrvinfo
In-Reply-To: <1058195703.561.76.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55L.0307141346170.29144@freak.distro.conectiva>
References: <200307141221.h6ECLLDM030866@hraefn.swansea.linux.org.uk> 
 <20030714141425.C18177@flint.arm.linux.org.uk> <1058195703.561.76.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jul 2003, Alan Cox wrote:

> On Llu, 2003-07-14 at 14:14, Russell King wrote:
> > >  		strncpy(info.driver, "3c574_cs", sizeof(info.driver)-1);
> > > +		sprintf(info.bus_info, "PCMCIA 0x%lx", dev->base_addr);
> > >  		if (copy_to_user(useraddr, &info, sizeof(info)))
> > >  			return -EFAULT;
> > >  		return 0;
> >
> > We should probably ensure that the bus info is compatible with the bus
> > info which Dominik's going to be using in 2.6.x
>
> I think thats a good point. Marcelo , bin that diff for now

Done.

