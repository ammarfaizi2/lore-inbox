Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUI1DOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUI1DOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 23:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUI1DO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 23:14:29 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:65212 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267514AbUI1DOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 23:14:20 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Zhu, Yi" <yi.zhu@intel.com>
Subject: [OT] Re: suspend/resume support for driver requires an external firmware
Date: Mon, 27 Sep 2004 22:14:15 -0500
User-Agent: KMail/1.6.2
Cc: <linux-kernel@vger.kernel.org>,
       "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>,
       "Oliver Neukum" <oliver@neukum.org>,
       "Patrick Mochel" <mochel@digitalimplant.org>
References: <3ACA40606221794F80A5670F0AF15F8403BD579D@pdsmsx403>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD579D@pdsmsx403>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409272214.15992.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 September 2004 09:28 pm, Zhu, Yi wrote:
> Dmitry Torokhov wrote:
> > Where do you load your firmware from so that you can bring up
> > the network so you can mount everything via NFS in the first place?
> 
> The firmware locates together w/ the driver in the initrd which could be
> either in the remote PXE server or the local diskettes. It should be
> also
> placed somewhere on the NFS root so that it can be picked up to
> memory during suspend.
> 

Nice try :) but if a card needs a firmware to operate you most likely will
not be able to access any network resources, including PXE. Only some form
of local storage can contain kernel and firmware in this case and I would
think it will be awailable at resume time as well.

Anyway, since there are other kind of devices besides network cards that
have to be availabe before userspace comes up and a generic solution is
always better I think that this part of thread is turning into offtopic...

-- 
Dmitry
