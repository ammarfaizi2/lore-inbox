Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270217AbTGNPEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270635AbTGNPD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:03:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36546
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270217AbTGNPDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:03:00 -0400
Subject: Re: PATCH: make pcmcica devices report pcmcia bus info in gdrvinfo
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com
In-Reply-To: <20030714141425.C18177@flint.arm.linux.org.uk>
References: <200307141221.h6ECLLDM030866@hraefn.swansea.linux.org.uk>
	 <20030714141425.C18177@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058195703.561.76.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 16:15:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 14:14, Russell King wrote:
> >  		strncpy(info.driver, "3c574_cs", sizeof(info.driver)-1);
> > +		sprintf(info.bus_info, "PCMCIA 0x%lx", dev->base_addr);
> >  		if (copy_to_user(useraddr, &info, sizeof(info)))
> >  			return -EFAULT;
> >  		return 0;
> 
> We should probably ensure that the bus info is compatible with the bus
> info which Dominik's going to be using in 2.6.x

I think thats a good point. Marcelo , bin that diff for now

