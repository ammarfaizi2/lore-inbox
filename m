Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVAOFOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVAOFOS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 00:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVAOFOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 00:14:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3857 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262198AbVAOFOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 00:14:12 -0500
Date: Sat, 15 Jan 2005 06:14:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Steffen Moser <lists@steffen-moser.de>, linux-kernel@vger.kernel.org,
       David Dyck <david.dyck@fluke.com>
Subject: Re: Linux 2.4.29-rc2
Message-ID: <20050115051410.GD4274@stusta.de>
References: <20050112151334.GC32024@logos.cnet> <20050114225555.GA17714@steffen-moser.de> <20050114231712.GH3336@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114231712.GH3336@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 09:17:12PM -0200, Marcelo Tosatti wrote:
>...
> On Fri, Jan 14, 2005 at 11:55:55PM +0100, Steffen Moser wrote:
>...
> > [1.] One line summary of the problem: 
> > 
> > Kernel module "serial.o" cannot be loaded
> > 
> > 
> > [2.] Full description of the problem/report:
> > 
> > I cannot load the module "serial.o" anymore, so I won't have serial 
> > port support (which is needed to have the machine communicating with
> > the UPS):
> > 
> >  | fsa01:~ # modprobe serial
> >  | /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o: unresolved symbol tty_ldisc_flush
> >  | /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o: unresolved symbol tty_wakeup
> >  | /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o: insmod /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o failed
> >  | /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o: insmod serial failed
> 
> Steffen, 
> 
> Please try this:
>...
> -EXPORT_SYMBOL_GPL(tty_wakeup);
> +EXPORT_SYMBOL(tty_wakeup);
>...
> -EXPORT_SYMBOL_GPL(tty_ldisc_flush);
> +EXPORT_SYMBOL(tty_ldisc_flush);
>...

This shouldn't make any difference unless 2.4.29-rc2 contains non-GPL 
code.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

