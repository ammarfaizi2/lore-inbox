Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbTIJHhu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 03:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbTIJHhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 03:37:50 -0400
Received: from adsl-155-178-217.bct.bellsouth.net ([68.155.178.217]:24872 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id S264702AbTIJHhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 03:37:48 -0400
Date: Wed, 10 Sep 2003 03:50:41 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb_control/bulk_msg: timeout / NETDEV WATCHDOG: eth0: transmit timed out
Message-ID: <20030910075041.GA9293@lnuxlab.ath.cx>
References: <20030910002720.GA30861@lnuxlab.ath.cx> <20030909173558.3a563022.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909173558.3a563022.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 05:35:58PM -0700, Andrew Morton wrote:
> khromy@lnuxlab.ath.cx (khromy) wrote:
> >
> > Anybody know what's up with this?  Running 2.4.23-pre3 I get the following 
> > while booting up:
> > 
> > usb_control/bulk_msg: timeout
> > usb.c: USB device not accepting new address=3 (error=-110)
> > NETDEV WATCHDOG: eth0: transmit timed out
> > eth0: transmit timed out, tx_status 00 status e601.
> >   diagnostics: net 0cc0 media 88c0 dma 0000003b.
> > eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
> 
> I'd be suspecting ACPI changes broke the IRQ routing to the network card.
> 
> Try disabling ACPI.

Yes, that did it.

-- 
L1:	khromy		;khromy (at) lnuxlab.ath.cx
