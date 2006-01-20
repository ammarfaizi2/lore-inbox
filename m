Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWATL4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWATL4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 06:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWATL4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 06:56:05 -0500
Received: from outmx028.isp.belgacom.be ([195.238.5.49]:12254 "EHLO
	outmx028.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750774AbWATL4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 06:56:03 -0500
Date: Fri, 20 Jan 2006 12:55:43 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Kumar Gala <galak@gate.crashing.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] powerpc: remove useless spinlock from mpc83xx watchdog
Message-ID: <20060120115543.GA6174@infomag.infomag.iguana.be>
References: <Pine.LNX.4.44.0601190057130.8484-100000@gate.crashing.org> <1137664156.8471.16.camel@localhost.localdomain> <20060119164811.GB4418@dmt.cnet> <1137708739.8471.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137708739.8471.69.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

> On Iau, 2006-01-19 at 14:48 -0200, Marcelo Tosatti wrote:
> > On Thu, Jan 19, 2006 at 09:49:16AM +0000, Alan Cox wrote:
> > > 
> > > 	f = open("/dev/watchdog", O_RDWR);
> > > 	fork();
> > > 	while(1) {
> > > 		write(f, "Boing", 5);
> > > 	}
> > 
> > Oops.
> > 
> > At least 50% of the watchdog drivers rely solely on the "wdt_is_open"
> > atomic variable and are broken with respect to synchronization.
> 
> What an excellent janitors project

I'll have a look at it from a global point of view.

Greetings,
Wim.

