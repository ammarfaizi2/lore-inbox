Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUIXWOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUIXWOf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269001AbUIXWOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:14:35 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:42473 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264246AbUIXWOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:14:33 -0400
Subject: Re: 2.6.9-rc2-mm3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Paul Fulghum <paulkf@microgate.com>, James Morris <jmorris@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040924204345.C11325@flint.arm.linux.org.uk>
References: <Xine.LNX.4.44.0409241210220.8009-100000@thoron.boston.redhat.com>
	 <1096051977.1938.5.camel@deimos.microgate.com>
	 <1096053328.1938.11.camel@deimos.microgate.com>
	 <20040924204345.C11325@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096060310.10800.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 22:11:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-24 at 20:43, Russell King wrote:
> Well, this is not the only place where the termios can be changed.
> Drivers can change it in their set_termios method, and are in fact
> required to do so for POSIX compliance.

The new code calls the driver set_termios method under the termios lock
which should mean it can now safely mangle it when appropriate and
without a race against users.

> Unfortunately the way the tty layer currently goes about setting
> termios settings does not lend itself well to conforming to that.

Anything specific needs changing while I'm doing termios locking ?

