Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423077AbWAMW7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423077AbWAMW7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423081AbWAMW7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:59:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:60554 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1423077AbWAMW7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:59:15 -0500
Date: Fri, 13 Jan 2006 16:50:35 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Andrew Morton <akpm@osdl.org>
cc: wim@iguana.be, <linux-kernel@vger.kernel.org>, <linuxppc-dev@ozlabs.org>,
       <iinuxppc-embedded@gate.crashing.org>, <dave@cray.org>,
       <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Add support for the MPC83xx watchdog
In-Reply-To: <20060113145259.6d38e296.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0601131649340.26648-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, Andrew Morton wrote:

> Kumar Gala <galak@gate.crashing.org> wrote:
> >
> > Added support for the PowerPC MPC83xx watchdog.  The MPC83xx has a simple
> > watchdog that once enabled it can not be stopped, has some simple timeout
> > range selection, and the ability to either reset the processor or take
> > a machine check.
> > 
> >
> > +static ushort timeout = 0xffff;
> 
> There's no such thing ;)  I'll change this to u16, OK?

There is one in include/linux/types.h, but u16 is fine.

> > +static int mpc83xx_wdt_ioctl(struct inode *inode, struct file *file,
> > +			     unsigned int cmd,
> > +	unsigned long arg)
> 
> Whitespace went nutty in various places.  I'll fix that up.  Please see the
> followup patch.

Odd, no one else has had any issues with patches from me recently.

- kumar

