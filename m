Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbSLKRc4>; Wed, 11 Dec 2002 12:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267243AbSLKRc4>; Wed, 11 Dec 2002 12:32:56 -0500
Received: from havoc.daloft.com ([64.213.145.173]:8936 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267241AbSLKRcz>;
	Wed, 11 Dec 2002 12:32:55 -0500
Date: Wed, 11 Dec 2002 12:40:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, dahinds@users.sourceforge.net,
       davem@vger.kernel.org
Subject: Re: Status new-modules + 802.11b/IrDA
Message-ID: <20021211174036.GA2612@gtf.org>
References: <20021211010512.GA5853@bougret.hpl.hp.com> <20021211093007.B58402C093@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211093007.B58402C093@lists.samba.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 07:34:53PM +1100, Rusty Russell wrote:
> In message <20021211010512.GA5853@bougret.hpl.hp.com> you write:
> > 	o af_irda, irda-usb & irtty-sir are "unsafe". I tracked that
> > down to the use of MOD_INC_USE_COUNT. The header file module.h give
> > hints on how I should convert that to the new world (use
> > try_module_get), however your FAQ seems to say something else (just
> > remove them, they are useless). I'm quite confused, because those
> > MOD_INC_USE_COUNT have a definite purpose... I would appreciate more
> > guidance.
> 
> Looking at these files:
> 
> idra-usb.c: add "netdev->owner = THIS_MODULE;" and get rid of the
> 	MOD_INC_USE_COUNT.

	Incorrect but close:  one uses SET_MODULE_OWNER(netdev) for this.


