Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbTHTFLN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 01:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbTHTFLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 01:11:13 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:52393 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261738AbTHTFLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 01:11:12 -0400
Date: Wed, 20 Aug 2003 01:11:09 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: zaitcev@redhat.com, tmolina@cablespeed.com, linux-kernel@vger.kernel.org
Subject: Re: Console on USB
Message-ID: <20030820011109.A24410@devserv.devel.redhat.com>
References: <mailman.1061346549.9440.linux-kernel2news@redhat.com> <200308200446.h7K4kW211793@devserv.devel.redhat.com> <32801.4.4.25.4.1061355525.squirrel@www.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <32801.4.4.25.4.1061355525.squirrel@www.osdl.org>; from rddunlap@osdl.org on Tue, Aug 19, 2003 at 09:58:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 19 Aug 2003 21:58:45 -0700 (PDT)
> From: "Randy.Dunlap" <rddunlap@osdl.org>

> >> Is there any advice I might be able to use to get this going?
> >
> > You'd have to write it. Grep for register_console for starters.
> 
> usb/serial/console.c:255:         register_console(&usbcons);

Eeek, eating a crow now.

> >>  I really want to be able to catch some oops output.
> >
> > If oops happens with interrupts closed, forget about it.
> > USB needs interrupts to work. This is one of the reasons nobody
> > bothered to implement console over USB serial.
> 
> The call to register_console() also happens very late in the boot
> sequence, so if your oops is early, USB console won't help.

It's true for many consoles, that's why sparc allows
"-p" in SILO options, for instance. I think either wli or willy
did "early VGA printk" patch.

Interrupts are a major problem. Also, the USB stack is pretty
thick.

-- Pete
