Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUI0SjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUI0SjT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 14:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUI0SjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 14:39:19 -0400
Received: from mail1.kontent.de ([81.88.34.36]:1249 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S267164AbUI0SjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 14:39:17 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: suspend/resume support for driver requires an external firmware
Date: Mon, 27 Sep 2004 20:37:48 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>,
       "Zhu, Yi" <yi.zhu@intel.com>
References: <3ACA40606221794F80A5670F0AF15F8403BD5791@pdsmsx403> <200409271919.17173.oliver@neukum.org> <200409271319.05112.dtor_core@ameritech.net>
In-Reply-To: <200409271319.05112.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409272037.48916.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 27. September 2004 20:19 schrieb Dmitry Torokhov:
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

Can suspend/resume be handled as power off/power on?
Taking that to the logical conclusion, there is no suspend/resume.
You suspend in order to preserve the system state. The problem
of mobility is no excuse to improperly implement suspension.
You can't expect something to work suspended which wouldn't work
if the system were powered on.

	Regards
		Oliver
