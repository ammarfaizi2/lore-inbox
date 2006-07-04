Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWGDHAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWGDHAQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWGDHAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:00:15 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:29059 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751092AbWGDHAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:00:14 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E05003@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>
Cc: "'Vitaly Bordug'" <vbordug@ru.mvista.com>,
       "'Paul Mackerras'" <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
       Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/7] powerpc: Add mpc8360epb platform support
Date: Tue, 4 Jul 2006 15:00:04 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> Sent: Saturday, July 01, 2006 5:00 PM
> To: Li Yang-r58472
> Cc: 'Vitaly Bordug'; 'Paul Mackerras'; linuxppc-dev@ozlabs.org; Phillips
> Kim-R1AAHA; Chu hanjin-r52514; Yin Olivia-r63875;
> 'linux-kernel@vger.kernel.org'
> Subject: RE: [PATCH 1/7] powerpc: Add mpc8360epb platform support
> 
> On Fri, 2006-06-30 at 18:27 +0800, Li Yang-r58472 wrote:
> > > -----Original Message-----
> > > From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> > > Sent: Thursday, June 29, 2006 12:59 AM
> > > To: Li Yang-r58472
> > > Cc: 'Paul Mackerras'; linuxppc-dev@ozlabs.org; Phillips Kim-R1AAHA; Chu
> > > hanjin-r52514; Yin Olivia-r63875; 'linux-kernel@vger.kernel.org'
> > > Subject: Re: [PATCH 1/7] powerpc: Add mpc8360epb platform support
> > >
> > > On Wed, 28 Jun 2006 22:23:03 +0800
> > > Li Yang-r58472 <LeoLi@freescale.com> wrote:
> > >
> > [snip]
> > >
> > > >
> > > >  config MPC834x
> > > > @@ -24,4 +31,10 @@ config MPC834x
> > > >  	select PPC_INDIRECT_PCI
> > > >  	default y if MPC834x_SYS
> > > >
> > > > +config MPC836x
> > > > +	bool
> > > > +	select PPC_UDBG_16550
> > >
> > > debug option made default?
> >
> > I'm afraid this is needed to boot.  83xx family platforms need it to
> initialize early console.  And it does appear in several defconfigs of other
> platforms.
> 
> How so ? Why would having a serial console be mandatory ? Embedded might
> want to boot without a console and use the serial port for other things.
> This should be left as a config option (though you are welcome to put it
> in the defconfig for your platform)

The problem is that we don't have this PPC_UBDG_16550 option configurable now, and it is only made by default for several boards including pseries, chrp, prep, cell, and all 83xx and 85xx platforms.  If we need to change the whole thing, how should we do it?
> 
> > > > +	select PPC_INDIRECT_PCI
> > > > +	default y if MPC8360E_PB
> > > > +
> > > >  endmenu
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
