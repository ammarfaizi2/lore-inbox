Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUI0STO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUI0STO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 14:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUI0STO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 14:19:14 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:27555 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266885AbUI0STJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 14:19:09 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: suspend/resume support for driver requires an external firmware
Date: Mon, 27 Sep 2004 13:19:05 -0500
User-Agent: KMail/1.6.2
Cc: Oliver Neukum <oliver@neukum.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       "Zhu, Yi" <yi.zhu@intel.com>
References: <3ACA40606221794F80A5670F0AF15F8403BD5791@pdsmsx403> <Pine.LNX.4.50.0409270948570.32506-100000@monsoon.he.net> <200409271919.17173.oliver@neukum.org>
In-Reply-To: <200409271919.17173.oliver@neukum.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409271319.05112.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 September 2004 12:19 pm, Oliver Neukum wrote:
> > Why not just suspend the device first, then enter the system suspend
> > state; then on resume, resume the device after control has transferred
> > back to userspace. That way, the driver can load the firmware from the
> 
> And thus cause errors in all applications wishing to use the network
> until the firmware is reloaded. It is precisely what cannot be done.
> The firmware must be present on suspend. The question is, how?

While non-availability might be an issue for other types of hardware I think
it is ok for network cards. In many cases the interface will have to be
reconfigured at resume anyway (you move from office to home and the network
is completely different). Can't resume be handled by virtually removing/
inserting the device so firmware will be re-loaded as it was just a normal
startup?

-- 
Dmitry
