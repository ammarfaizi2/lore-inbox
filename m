Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbTHTEqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 00:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbTHTEqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 00:46:37 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:18337 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261712AbTHTEqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 00:46:34 -0400
Date: Wed, 20 Aug 2003 00:46:32 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200308200446.h7K4kW211793@devserv.devel.redhat.com>
To: Thomas Molina <tmolina@cablespeed.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Console on USB
In-Reply-To: <mailman.1061346549.9440.linux-kernel2news@redhat.com>
References: <mailman.1061346549.9440.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   So I ordered a USB to serial converter, configured a 2.6.0-test3 
> kernel, added a console=/dev/ttyUSB0 to the kernel command line and 
> connected this to my desktop with a null modem adapter.

What made you think this will work?!

> Is there any advice I might be able to use to get this going?

You'd have to write it. Grep for register_console for starters.
But I do not advise it, see below.

>  I really want to be able to catch some oops output.

If oops happens with interrupts closed, forget about it.
USB needs interrupts to work. This is one of the reasons nobody
bothered to implement console over USB serial.

You will have a better chance using Ingo's netconsole, if a patch
for your Ethernet driver exists.

-- Pete
