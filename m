Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUI0Wr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUI0Wr1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 18:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUI0Wr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 18:47:26 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:7439 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267409AbUI0WrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 18:47:13 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: suspend/resume support for driver requires an external firmware
Date: Tue, 28 Sep 2004 01:47:03 +0300
User-Agent: KMail/1.5.4
Cc: Oliver Neukum <oliver@neukum.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       "Zhu, Yi" <yi.zhu@intel.com>
References: <3ACA40606221794F80A5670F0AF15F8403BD5791@pdsmsx403> <200409271919.17173.oliver@neukum.org> <200409271319.05112.dtor_core@ameritech.net>
In-Reply-To: <200409271319.05112.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409280147.03957.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 September 2004 21:19, Dmitry Torokhov wrote:
> On Monday 27 September 2004 12:19 pm, Oliver Neukum wrote:
> > > Why not just suspend the device first, then enter the system suspend
> > > state; then on resume, resume the device after control has transferred
> > > back to userspace. That way, the driver can load the firmware from the
> > 
> > And thus cause errors in all applications wishing to use the network
> > until the firmware is reloaded. It is precisely what cannot be done.
> > The firmware must be present on suspend. The question is, how?
> 
> While non-availability might be an issue for other types of hardware I think
> it is ok for network cards. In many cases the interface will have to be
> reconfigured at resume anyway (you move from office to home and the network
> is completely different). Can't resume be handled by virtually removing/
> inserting the device so firmware will be re-loaded as it was just a normal
> startup?

Think about situation when all filesystems are NFS-mounted.
You absolutely are not allowed to lose your network, or else hotplug
(and all fs-backed stuff in general) will die horribly.
--
vda

