Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWFOD1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWFOD1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 23:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWFOD1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 23:27:43 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:53180 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1750838AbWFOD1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 23:27:42 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467306A5F987@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Alexandre.Bounine@tundra.com,
       linux-kernel@vger.kernel.org,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org,
       Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
Subject: RE: [PATCH/2.6.17-rc4 8/10]  Add  tsi108 8250 serial support
Date: Thu, 15 Jun 2006 11:27:30 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2006-06-13 at 13:39 +0800, Zang Roy-r61911 wrote:
> 
> > The reason is that the serial port on tsi108/9 is a bit difference 
> > with the standard 8250 serial port. the patch deal with the 
> difference.
> > The prefixed ">" is caused by "Fw" the email. Sorry for that. The 
> > following is the original patch.
> 
> The problem I see is that the code uses a CONFIG option, to 
> change the behaviour of the generic 8250 driver. What happens 
> if somebody adds a PCI serial card to a tsi108 based machine?

I do not like CONFIG option:). It might be a problem in the environment you suggesting.

> 
> Perhaps you should define a new value for 
> uart_8250_port.port.iotype, and add code to serial_in and 
> serial_out to handle the IIR register.
I will consider it.
> 
> --
> Adrian Cox <adrian@humboldt.co.uk>
> 
