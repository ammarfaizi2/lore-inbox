Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVDMKiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVDMKiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 06:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVDMKiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 06:38:07 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:35475 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261294AbVDMKiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 06:38:02 -0400
Date: Wed, 13 Apr 2005 12:37:58 +0200
From: Tomas =?iso-8859-1?Q?=D6gren?= <stric@acc.umu.se>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4] "Fix" introduced in 2.4.27pre2 for bluetooth hci_usb race causes kernel hang
Message-ID: <20050413103758.GA12780@shaka.acc.umu.se>
Mail-Followup-To: Tomas =?iso-8859-1?Q?=D6gren?= <stric@acc.umu.se>,
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
References: <20050408195632.GA17621@shaka.acc.umu.se> <1113053955.9783.57.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1113053955.9783.57.camel@pegasus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 April, 2005 - Marcel Holtmann sent me these 1,6K bytes:

> Hi Tomas,
> 
> > I have noticed a problem with a race condition fix introduced in
> > 2.4.27-pre2 that causes the kernel to hang when disconnecting a
> > Bluetooth USB dongle or doing 'hciconfig hci0 down'. No message is
> > printed, the kernel just doesn't respond anymore.
> > 
> > Seen in Changelog:
> > Marcel Holtmann:
> >   o [Bluetooth] Fix race in RX complete routine of the USB drivers
> > 
> > Reversing the following patch to hci_usb_rx_complete() makes 2.4.27-pre2
> > up until 2.4.30 happy and does not hang when removing the dongle
> > anymore. (bfusb.c has the same patch applied)
> > 
> > 2.6.11.7 does not show the same problem, but has similar code to the
> > "fixed" (that hangs) code in 2.4, so the real problem is probably
> > somewhere else.
> 
> does the attached patch makes any difference?

It works just fine with pristine 2.4.30 and this patch. No deadlocks
anymore.

/Tomas
-- 
Tomas Ögren, stric@acc.umu.se, http://www.acc.umu.se/~stric/
|- Student at Computing Science, University of Umeå
`- Sysadmin at {cs,acc}.umu.se
