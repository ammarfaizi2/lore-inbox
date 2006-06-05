Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750982AbWFELeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWFELeR (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 07:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWFELeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 07:34:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16310 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750979AbWFELeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 07:34:17 -0400
Date: Mon, 5 Jun 2006 13:33:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jirka Lenost Benc <jbenc@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: move zd1201 where it belongs
Message-ID: <20060605113332.GB2132@elf.ucw.cz>
References: <20060605103952.GA1670@elf.ucw.cz> <1149506120.3111.52.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149506120.3111.52.camel@laptopd505.fenrus.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 05-06-06 13:15:20, Arjan van de Ven wrote:
> On Mon, 2006-06-05 at 12:39 +0200, Pavel Machek wrote:
> > zd1201 is wifi adapter, yet it is hiding in drivers/usb/net where
> > noone can find it. This moves Kconfig/Makefile to right place; you
> > still need to manually move .c and .h files.
> > 
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> > 
> > diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
> > index e0874cb..313cfad 100644
> > --- a/drivers/net/wireless/Kconfig
> > +++ b/drivers/net/wireless/Kconfig
> > @@ -503,6 +503,23 @@ config PRISM54
> >  	  say M here and read <file:Documentation/modules.txt>.  The module
> >  	  will be called prism54.ko.
> >  
> > +config USB_ZD1201
> > +	tristate "USB ZD1201 based Wireless device support"
> > +	depends on NET_RADIO
> > +	select FW_LOADER
> 
> do you think it should at least depend in some form or another on
> CONFIG_USB ?

Right, added USB && to depends directive.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
