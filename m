Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272452AbTGZKtx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 06:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272453AbTGZKtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 06:49:53 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:50538 "EHLO
	mwinf0602.wanadoo.fr") by vger.kernel.org with ESMTP
	id S272452AbTGZKtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 06:49:51 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: koraq@xs4all.nl
Subject: Re: [2.4.22-pre7] speedtouch.o unresolved symbols
Date: Sat, 26 Jul 2003 13:05:45 +0200
User-Agent: KMail/1.5.2
Cc: Valdis.Kletnieks@vt.edu, koraq@xs4all.nl, linux-kernel@vger.kernel.org
References: <20030724202048.GA16411@spearhead> <200307251643.32003.baldrick@wanadoo.fr> <20030726042048.GA515@spearhead>
In-Reply-To: <20030726042048.GA515@spearhead>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307261305.45847.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 July 2003 06:20, koraq@xs4all.nl wrote:
> On Fri, Jul 25, 2003 at 04:43:31PM +0200, Duncan Sands wrote:
> > On Friday 25 July 2003 16:26, Valdis.Kletnieks@vt.edu wrote:
> > > On Fri, 25 Jul 2003 08:55:24 +0200, Duncan Sands <baldrick@wanadoo.fr>  said:
> > > > On Thursday 24 July 2003 22:20, koraq@xs4all.nl wrote:
> > > > > /lib/modules/2.4.22-pre7/kernel/drivers/usb/speedtch.o depmod:
> > > > > shutdown_atm_dev_R0b9b1467
> > > > > depmod:         atm_charge_Rf874f17b
> > > > > depmod:         atm_dev_register_Rc23701a4
> > > > > make: *** [_modinst_post] Error 1
> > > >
> > > > You need to enable ATM support (CONFIG_ATM).  To do this, you
> > > > need to enable support for experimental code (CONFIG_EXPERIMENTAL).
>
> Thx this did work.
>
> > > Also, the Speedtouch driver appears to be missing a #ifdef CONFIG_ATM
> > > or two?
> > >
> > >From drivers/usb/Config.in
> >
> >    if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
> >       dep_tristate '  Alcatel Speedtouch USB support'
> > CONFIG_USB_SPEEDTOUCH $CONFIG_ATM $CONFIG_USB fi
>
> 2.4.22-pre7 only had
>
> dep_tristate '  Alcatel Speedtouch USB support' CONFIG_USB_SPEEDTOUCH
> $CONFIG_ATM $CONFIG_USB
>
> so the change seems to work. The test I'd done with -pre8 was done with a
> copy of the -pre7 config.

Yes, you needed to do "make oldconfig" to sort out the dependencies.

Ciao,

Duncan.
