Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267851AbUI1PHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267851AbUI1PHd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 11:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267804AbUI1PHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 11:07:32 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:29969 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267851AbUI1PHW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 11:07:22 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: suspend/resume support for driver requires an external firmware
Date: Tue, 28 Sep 2004 18:07:15 +0300
User-Agent: KMail/1.5.4
Cc: Oliver Neukum <oliver@neukum.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       "Zhu, Yi" <yi.zhu@intel.com>
References: <3ACA40606221794F80A5670F0AF15F8403BD5791@pdsmsx403> <200409280147.03957.vda@port.imtp.ilyichevsk.odessa.ua> <200409271806.57992.dtor_core@ameritech.net>
In-Reply-To: <200409271806.57992.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200409281807.15768.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 September 2004 02:06, Dmitry Torokhov wrote:
> On Monday 27 September 2004 05:47 pm, Denis Vlasenko wrote:
> > On Monday 27 September 2004 21:19, Dmitry Torokhov wrote:
> > > On Monday 27 September 2004 12:19 pm, Oliver Neukum wrote:
> > > > > Why not just suspend the device first, then enter the system suspend
> > > > > state; then on resume, resume the device after control has transferred
> > > > > back to userspace. That way, the driver can load the firmware from the
> > > > 
> > > > And thus cause errors in all applications wishing to use the network
> > > > until the firmware is reloaded. It is precisely what cannot be done.
> > > > The firmware must be present on suspend. The question is, how?
> > > 
> > > While non-availability might be an issue for other types of hardware I think
> > > it is ok for network cards. In many cases the interface will have to be
> > > reconfigured at resume anyway (you move from office to home and the network
> > > is completely different). Can't resume be handled by virtually removing/
> > > inserting the device so firmware will be re-loaded as it was just a normal
> > > startup?
> > 
> > Think about situation when all filesystems are NFS-mounted.
> > You absolutely are not allowed to lose your network, or else hotplug
> > (and all fs-backed stuff in general) will die horribly.
> 
> Where do you load your firmware from so that you can bring up the network
> so you can mount everything via NFS in the first place?

>From initrd. I am booting off small DOS partition which holds Linux images,
initrds, loader etc. After boot, I do not mount any local partitions.
--
vda

