Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWGAJAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWGAJAj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 05:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWGAJAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 05:00:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:43674 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932428AbWGAJAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 05:00:38 -0400
Subject: RE: [PATCH 1/7] powerpc: Add mpc8360epb platform support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: "'Vitaly Bordug'" <vbordug@ru.mvista.com>,
       "'Paul Mackerras'" <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
       Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FF2@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306E04FF2@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 19:00:04 +1000
Message-Id: <1151744404.27137.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 18:27 +0800, Li Yang-r58472 wrote:
> > -----Original Message-----
> > From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> > Sent: Thursday, June 29, 2006 12:59 AM
> > To: Li Yang-r58472
> > Cc: 'Paul Mackerras'; linuxppc-dev@ozlabs.org; Phillips Kim-R1AAHA; Chu
> > hanjin-r52514; Yin Olivia-r63875; 'linux-kernel@vger.kernel.org'
> > Subject: Re: [PATCH 1/7] powerpc: Add mpc8360epb platform support
> > 
> > On Wed, 28 Jun 2006 22:23:03 +0800
> > Li Yang-r58472 <LeoLi@freescale.com> wrote:
> > 
> [snip]
> > 
> > >
> > >  config MPC834x
> > > @@ -24,4 +31,10 @@ config MPC834x
> > >  	select PPC_INDIRECT_PCI
> > >  	default y if MPC834x_SYS
> > >
> > > +config MPC836x
> > > +	bool
> > > +	select PPC_UDBG_16550
> > 
> > debug option made default?
> 
> I'm afraid this is needed to boot.  83xx family platforms need it to initialize early console.  And it does appear in several defconfigs of other platforms.

How so ? Why would having a serial console be mandatory ? Embedded might
want to boot without a console and use the serial port for other things.
This should be left as a config option (though you are welcome to put it
in the defconfig for your platform)
 
> > > +	select PPC_INDIRECT_PCI
> > > +	default y if MPC8360E_PB
> > > +
> > >  endmenu
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

