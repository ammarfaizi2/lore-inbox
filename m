Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267880AbUI1PFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267880AbUI1PFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 11:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267804AbUI1PFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 11:05:14 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:27921 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267880AbUI1PFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 11:05:06 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Dmitry Torokhov <dtor_core@ameritech.net>, "Zhu, Yi" <yi.zhu@intel.com>
Subject: Re: [OT] Re: suspend/resume support for driver requires an external firmware
Date: Tue, 28 Sep 2004 18:04:57 +0300
User-Agent: KMail/1.5.4
Cc: <linux-kernel@vger.kernel.org>, "Oliver Neukum" <oliver@neukum.org>,
       "Patrick Mochel" <mochel@digitalimplant.org>
References: <3ACA40606221794F80A5670F0AF15F8403BD579D@pdsmsx403> <200409272214.15992.dtor_core@ameritech.net>
In-Reply-To: <200409272214.15992.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409281804.57226.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 September 2004 06:14, Dmitry Torokhov wrote:
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
> not be able to access any network resources, including PXE.

Unless I have firmware on the initrd ;)

> Only some form
> of local storage can contain kernel and firmware in this case and I would
> think it will be awailable at resume time as well.

initrd is typically destroyed after boot is done.

> Anyway, since there are other kind of devices besides network cards that
> have to be availabe before userspace comes up and a generic solution is
> always better I think that this part of thread is turning into offtopic...

yes
--
vda

