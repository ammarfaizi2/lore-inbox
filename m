Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268117AbUI2Aqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268117AbUI2Aqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 20:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268120AbUI2Aql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 20:46:41 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3465 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268117AbUI2Apc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 20:45:32 -0400
Subject: Re: Serial driver hangs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1096412582.6003.8.camel@at2.pipehead.org>
References: <200409281734.38781.roland.cassebohm@visionsystems.de>
	 <1096405831.2513.37.camel@deimos.microgate.com>
	 <20040928221600.D14747@flint.arm.linux.org.uk>
	 <1096412582.6003.8.camel@at2.pipehead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096409562.14082.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Sep 2004 23:12:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 00:03, Paul Fulghum wrote:
> The alternative is to implement a flow control
> mechanism between the flip buffer layer and
> the tty drivers to (at the very least)
> enable/disable receive interrupts.

We have throttle()/unthrottle(). Drivers also know if they can't
push data.

> Since the flip buffer implementation is probably
> going to need rework anyways (eventually) along
> with the other tty locking issues, this may not
> be a trivial task.

TTY_DONT_FLIP has to die. It's already broken for many cases.
Its basically a nasty quickfix someone did ages ago

