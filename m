Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbTIPKZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 06:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTIPKZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 06:25:44 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:61963 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261826AbTIPKZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 06:25:43 -0400
Subject: Re: Kernel 2.6.0-test5 Refuses to Boot (ceases after "mice: PS/2
	mouse device common for all mice")
From: Felipe Alfaro Solana <yo@felipe-alfaro.com>
To: M M <mokomull@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030915193657.483fd953.akpm@osdl.org>
References: <20030916011825.98277.qmail@web41806.mail.yahoo.com>
	 <20030915193657.483fd953.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1063707939.1304.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 16 Sep 2003 12:25:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-16 at 04:36, Andrew Morton wrote:
> M M <mokomull@yahoo.com> wrote:
> >
> > I've downloaded, configured (make oldconfig using
> > .config from 2.4.21), and compiled kernel 2.6.0-test5,
> > but it just refuses to boot completely.
> > 
> > It prints:
> > drivers/usb/core/usb.c: registered new driver hid
> > drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> > mice: PS/2 mouse device common for all mice
> > 
> > and just stops booting.
> > 
> > Which configuration option(s) did I miss?
> 
> Please add `initcall_debug' to your kernel boot comand line.  You will see
> a lot of lines of the form "calling initcall 0xNNNNNNNN".  Write down the
> final address, reboot and look it up in System.map.
> 
> Also try disabling ACPI.

Please, take a look at:
http://bugzilla.kernel.org/show_bug.cgi?id=1123

