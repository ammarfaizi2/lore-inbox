Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266838AbUI0RUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266838AbUI0RUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 13:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266839AbUI0RUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 13:20:49 -0400
Received: from mail1.kontent.de ([81.88.34.36]:37582 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266838AbUI0RUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 13:20:47 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: suspend/resume support for driver requires an external firmware
Date: Mon, 27 Sep 2004 19:19:16 +0200
User-Agent: KMail/1.6.2
Cc: "Zhu, Yi" <yi.zhu@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3ACA40606221794F80A5670F0AF15F8403BD5791@pdsmsx403> <Pine.LNX.4.50.0409270948570.32506-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0409270948570.32506-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409271919.17173.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 27. September 2004 18:50 schrieb Patrick Mochel:
> 
> On Mon, 27 Sep 2004, Zhu, Yi wrote:
> 
> > Oliver Neukum wrote:
> > > Am Freitag, 24. September 2004 08:16 schrieb Zhu, Yi:
> > >> Choice 3? or I missed something here?
> > >
> > > If the user requests suspension, why can't he transfer the
> > > firmware before he does so? Thus the firmware would be in ram
> > > or part of the image read back from disk.
> >
> > Do you suggest before user echo 4 > /proc/acpi/sleep, [s]he must
> > do something like cat /path/of/firmware > /proc/net/ipw2100/firmware?
> 
> Why not just suspend the device first, then enter the system suspend
> state; then on resume, resume the device after control has transferred
> back to userspace. That way, the driver can load the firmware from the

And thus cause errors in all applications wishing to use the network
until the firmware is reloaded. It is precisely what cannot be done.
The firmware must be present on suspend. The question is, how?

	Regards
		Oliver
