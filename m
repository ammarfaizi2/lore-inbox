Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVDERR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVDERR0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVDEROo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:14:44 -0400
Received: from palrel13.hp.com ([156.153.255.238]:6891 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261820AbVDERBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:01:08 -0400
Date: Tue, 5 Apr 2005 10:01:02 -0700
To: Michal Rokos <michal@rokos.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IrDA] Oops with NULL deref in irda_device_set_media_busy
Message-ID: <20050405170102.GD10447@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <200504051102.27533.michal@rokos.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504051102.27533.michal@rokos.info>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.6+20040907i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 11:02:26AM +0200, Michal Rokos wrote:
> Hello,
> 
> I've problems with IrDA - when debug is off, I'm getting oops for obvious 
> reason...
> (I don't have a log, this is just rewrite from screen:
> EIP: irda_device_set_media_busy+0x15/0x40 [irda]
> ali_ircc_sir_receive+0x4a/0x70
> ali_ircc_sir_interrupt+0x66/0x70
> ali_ircc_interrupt+0x5e/0x80
> .....
> )
> When I turn debug on, I get just
> Assertion failed! net/irda/irda_device.c:irda_device_set_media_busy:128 
> self != NULL
> 
> The obvious reason is that I don't have irlap module in that inits 
> dev->atalk_ptr, so I'm getting assertion exception in irda_device.c:489.

	I'm unclear here. The default IrDA stack intitialise properly
dev->atalk_ptr in every case, and is not expected to work if you
don't. I don't understand why dev->atalk_ptr would not be initialised,
is it something you did or something specific to the mr kernel (I only
test mainline kernels).

> A few info that could be handy:
> 
> $ uname -a # It's yesterday bk snapshot
> Linux csas 2.6.12-rc1-mr #14 Mon Apr 4 13:42:14 CEST 2005 i686 GNU/Linux

	Have fun...

	Jean
