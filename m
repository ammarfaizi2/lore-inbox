Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270708AbTGNSWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270720AbTGNSWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:22:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27595 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270708AbTGNSWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:22:09 -0400
Date: Mon, 14 Jul 2003 20:36:50 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.75: parse error in pci.h if !CONFIG_PCI
Message-ID: <20030714183649.GS12104@fs.tum.de>
References: <20030713102740.GY12104@fs.tum.de> <20030714060754.GA20416@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714060754.GA20416@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 11:07:54PM -0700, Greg KH wrote:
> On Sun, Jul 13, 2003 at 12:27:41PM +0200, Adrian Bunk wrote:
> > I got the following compile error when trying to compile 2.5.75 with 
> > !CONFIG_PCI:
> > 
> > <--  snip  -->
> > 
> > ...
> >   CC      drivers/message/fusion/mptscsih.o
> > In file included from drivers/message/fusion/linux_compat.h:10,
> >                  from drivers/message/fusion/mptbase.h:58,
> >                  from drivers/message/fusion/mptscsih.c:82:
> > include/linux/pci.h:718: error: syntax error before "int"
> > drivers/message/fusion/mptscsih.c:6924: warning: `mptscsih_setup' 
> > defined but not used
> > make[3]: *** [drivers/message/fusion/mptscsih.o] Error 1
> > 
> > <--  snip  -->
> 
> Thanks, the patch below should fix this problem.  I'll send it on to
> Linus in a bit.

Thanks, this patch fixed it.

> greg k-h
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

