Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272415AbTGZECE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 00:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272416AbTGZECE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 00:02:04 -0400
Received: from roadie.xs4all.nl ([80.126.43.246]:7552 "EHLO www.spearhead.org")
	by vger.kernel.org with ESMTP id S272415AbTGZECC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 00:02:02 -0400
Date: Sat, 26 Jul 2003 06:20:48 +0200
From: koraq@xs4all.nl
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: Valdis.Kletnieks@vt.edu, koraq@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: [2.4.22-pre7] speedtouch.o unresolved symbols
Message-ID: <20030726042048.GA515@spearhead>
References: <20030724202048.GA16411@spearhead> <200307250855.24218.baldrick@wanadoo.fr> <200307251426.h6PEQs9g003992@turing-police.cc.vt.edu> <200307251643.32003.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307251643.32003.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 04:43:31PM +0200, Duncan Sands wrote:
> On Friday 25 July 2003 16:26, Valdis.Kletnieks@vt.edu wrote:
> > On Fri, 25 Jul 2003 08:55:24 +0200, Duncan Sands <baldrick@wanadoo.fr>  said:
> > > On Thursday 24 July 2003 22:20, koraq@xs4all.nl wrote:
> > > > /lib/modules/2.4.22-pre7/kernel/drivers/usb/speedtch.o depmod:
> > > > shutdown_atm_dev_R0b9b1467
> > > > depmod:         atm_charge_Rf874f17b
> > > > depmod:         atm_dev_register_Rc23701a4
> > > > make: *** [_modinst_post] Error 1
> > >
> > > You need to enable ATM support (CONFIG_ATM).  To do this, you
> > > need to enable support for experimental code (CONFIG_EXPERIMENTAL).

Thx this did work.

> >
> > Also, the Speedtouch driver appears to be missing a #ifdef CONFIG_ATM or
> > two?
> 
> >From drivers/usb/Config.in
> 
>    if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
>       dep_tristate '  Alcatel Speedtouch USB support' CONFIG_USB_SPEEDTOUCH $CONFIG_ATM $CONFIG_USB
>    fi

2.4.22-pre7 only had 

dep_tristate '  Alcatel Speedtouch USB support' CONFIG_USB_SPEEDTOUCH $CONFIG_ATM $CONFIG_USB

so the change seems to work. The test I'd done with -pre8 was done with a copy of the -pre7 config.

Regards,
Mark de Wever
