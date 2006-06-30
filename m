Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWF3K1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWF3K1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 06:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWF3K1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 06:27:37 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:48264 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S932350AbWF3K1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 06:27:36 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E04FF2@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Vitaly Bordug'" <vbordug@ru.mvista.com>
Cc: "'Paul Mackerras'" <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
       Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/7] powerpc: Add mpc8360epb platform support
Date: Fri, 30 Jun 2006 18:27:28 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> Sent: Thursday, June 29, 2006 12:59 AM
> To: Li Yang-r58472
> Cc: 'Paul Mackerras'; linuxppc-dev@ozlabs.org; Phillips Kim-R1AAHA; Chu
> hanjin-r52514; Yin Olivia-r63875; 'linux-kernel@vger.kernel.org'
> Subject: Re: [PATCH 1/7] powerpc: Add mpc8360epb platform support
> 
> On Wed, 28 Jun 2006 22:23:03 +0800
> Li Yang-r58472 <LeoLi@freescale.com> wrote:
> 
[snip]
> 
> >
> >  config MPC834x
> > @@ -24,4 +31,10 @@ config MPC834x
> >  	select PPC_INDIRECT_PCI
> >  	default y if MPC834x_SYS
> >
> > +config MPC836x
> > +	bool
> > +	select PPC_UDBG_16550
> 
> debug option made default?

I'm afraid this is needed to boot.  83xx family platforms need it to initialize early console.  And it does appear in several defconfigs of other platforms.
> > +	select PPC_INDIRECT_PCI
> > +	default y if MPC8360E_PB
> > +
> >  endmenu

