Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272126AbTGYO1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 10:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272127AbTGYO1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 10:27:51 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:38466 "EHLO
	mwinf0502.wanadoo.fr") by vger.kernel.org with ESMTP
	id S272126AbTGYO1n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 10:27:43 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Valdis.Kletnieks@vt.edu
Subject: Re: [2.4.22-pre7] speedtouch.o unresolved symbols
Date: Fri, 25 Jul 2003 16:43:31 +0200
User-Agent: KMail/1.5.2
Cc: koraq@xs4all.nl, linux-kernel@vger.kernel.org
References: <20030724202048.GA16411@spearhead> <200307250855.24218.baldrick@wanadoo.fr> <200307251426.h6PEQs9g003992@turing-police.cc.vt.edu>
In-Reply-To: <200307251426.h6PEQs9g003992@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200307251643.32003.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 July 2003 16:26, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 25 Jul 2003 08:55:24 +0200, Duncan Sands <baldrick@wanadoo.fr>  said:
> > On Thursday 24 July 2003 22:20, koraq@xs4all.nl wrote:
> > > /lib/modules/2.4.22-pre7/kernel/drivers/usb/speedtch.o depmod:
> > > shutdown_atm_dev_R0b9b1467
> > > depmod:         atm_charge_Rf874f17b
> > > depmod:         atm_dev_register_Rc23701a4
> > > make: *** [_modinst_post] Error 1
> >
> > You need to enable ATM support (CONFIG_ATM).  To do this, you
> > need to enable support for experimental code (CONFIG_EXPERIMENTAL).
>
> Also, the Speedtouch driver appears to be missing a #ifdef CONFIG_ATM or
> two?

>From drivers/usb/Config.in

   if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
      dep_tristate '  Alcatel Speedtouch USB support' CONFIG_USB_SPEEDTOUCH $CONFIG_ATM $CONFIG_USB
   fi

Now the question is: why is this not enough?

Duncan.
