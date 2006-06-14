Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWFNPLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWFNPLp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 11:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWFNPLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 11:11:45 -0400
Received: from mail.humboldt.co.uk ([80.68.93.146]:60938 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S964997AbWFNPLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 11:11:44 -0400
Subject: RE: [PATCH/2.6.17-rc4 8/10]  Add  tsi108 8250 serial support
From: Adrian Cox <adrian@humboldt.co.uk>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Alexandre.Bounine@tundra.com,
       linux-kernel@vger.kernel.org,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org,
       Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673069C3C3D@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673069C3C3D@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 15:25:28 +0100
Message-Id: <1150295128.6552.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 13:39 +0800, Zang Roy-r61911 wrote:

> The reason is that the serial port on tsi108/9 is a bit difference with the 
> standard 8250 serial port. the patch deal with the difference.
> The prefixed ">" is caused by "Fw" the email. Sorry for that. The following 
> is the original patch.

The problem I see is that the code uses a CONFIG option, to change the
behaviour of the generic 8250 driver. What happens if somebody adds a
PCI serial card to a tsi108 based machine?

Perhaps you should define a new value for uart_8250_port.port.iotype,
and add code to serial_in and serial_out to handle the IIR register.

-- 
Adrian Cox <adrian@humboldt.co.uk>

