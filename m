Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267517AbUI1D15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUI1D15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 23:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUI1D15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 23:27:57 -0400
Received: from smtp.knology.net ([24.214.63.101]:688 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S267517AbUI1D1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 23:27:55 -0400
Subject: Re: [OT] Re: suspend/resume support for driver requires an
	external firmware
From: David Dillow <dave@thedillows.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: "Zhu, Yi" <yi.zhu@intel.com>, linux-kernel@vger.kernel.org,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Oliver Neukum <oliver@neukum.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <200409272214.15992.dtor_core@ameritech.net>
References: <3ACA40606221794F80A5670F0AF15F8403BD579D@pdsmsx403>
	 <200409272214.15992.dtor_core@ameritech.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1096342073.20234.1.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Sep 2004 23:27:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 23:14, Dmitry Torokhov wrote:
> On Monday 27 September 2004 09:28 pm, Zhu, Yi wrote:
> > Dmitry Torokhov wrote:
> > > Where do you load your firmware from so that you can bring up
> > > the network so you can mount everything via NFS in the first place?
> > 
> > The firmware locates together w/ the driver in the initrd which could be
> > either in the remote PXE server or the local diskettes. It should be
> > also
> > placed somewhere on the NFS root so that it can be picked up to
> > memory during suspend.
> > 
> 
> Nice try :) but if a card needs a firmware to operate you most likely will
> not be able to access any network resources, including PXE. Only some form
> of local storage can contain kernel and firmware in this case and I would
> think it will be awailable at resume time as well.

The 3Com 3cr990 family also needs external firmware (currently built
into the kernel, but it's on my TODO list to move to the loader), but it
contains enough firmware support in its flash to do PXE.
