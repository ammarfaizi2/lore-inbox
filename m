Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbULEG0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbULEG0s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 01:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbULEG0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 01:26:47 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:36028 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261263AbULEG0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 01:26:42 -0500
Date: Sat, 4 Dec 2004 23:26:19 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Rudolf Usselmann <rudi@asics.ws>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9, 64bit, 4GB memory => panics ...
In-Reply-To: <1102225183.3779.15.camel@cpu0>
Message-ID: <Pine.LNX.4.61.0412042321080.6378@montezuma.fsmlabs.com>
References: <1102072834.31282.1450.camel@cpu0>  <20041203113704.GD2714@holomorphy.com>
 <1102225183.3779.15.camel@cpu0>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rudolf,

On Sun, 5 Dec 2004, Rudolf Usselmann wrote:

> FYI, I tried 2.9.10-rc3 kernel, same problem.
> 
> Can anyone guide me or give me some pointers how I can enable
> login on serial ports - that would hopefully allow me to capture
> more/longer kernal panic screens. Doing an rlogin doesn't help,
> the kernel panic is still going to the root console (24 lines
> visible).
> 
> Any other tips/pointers as to how to capture kernel panics or
> what else I can do to help you guys to help me would be highly
> appreciated. :*)

Make sure that you have the following option in your kernel;

CONFIG_SERIAL_8250_CONSOLE=y

Then boot the kernel with this kernel parameter;

console=ttyS0,38400

Make necessary adjustments for baud rate and serial port. Then you may 
additionally add a getty on the console with something akin to the 
following /etc/inittab entry;

7:35:respawn:/sbin/agetty 38400 ttyS0

Finally all you need is a program on the monitoring system, minicom 
should suffice if you have nothing else.

	Zwane
