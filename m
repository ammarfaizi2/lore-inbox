Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317779AbSGPH7j>; Tue, 16 Jul 2002 03:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317781AbSGPH7f>; Tue, 16 Jul 2002 03:59:35 -0400
Received: from mail.eskimo.com ([204.122.16.4]:46353 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S317779AbSGPH7d>;
	Tue, 16 Jul 2002 03:59:33 -0400
Date: Tue, 16 Jul 2002 01:02:19 -0700
To: Hell.Surfers@cwctv.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: wine emulation integration.
Message-ID: <20020716080219.GA26331@eskimo.com>
References: <004540925061072DTVMAIL7@smtp.cwctv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004540925061072DTVMAIL7@smtp.cwctv.net>
User-Agent: Mutt/1.3.28i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wine is collection of application-level libraries and a special runtime
execution system.  Integrating it into the kernel isn't sensible, since
applications do not run in the kernel.

However, it is possible for Linux to support special system calls to aid
the implementation of Wine (chiefly for performance reasons).  This was
proposed at some point in the past, but I'm not sure what ever became of
it.  The basic idea was to provide some special locking primitives for
Win32 applications, as I recall...


What I think you're actually trying to propose is adding an
abstraction/support layer for windows driver binaries in the Linux
kernel.  This is actually an interesting idea in some respects, but it's
not really all that closely related to Wine.  Kernel development is
at a different level.

It's also probably not worth the trouble at all.  Implementing it would
be very difficult, and the number of devices it would enable would be
very small.  It would also be very unstable, since besides the bugs in
the windows drivers themselves, debugging the support layer around them
would be really hard.  Generally speaking, it would almost always be
easier to just write a native Linux driver for the hardware.

-J


On Tue, Jul 16, 2002 at 07:25:25AM +0100, Hell.Surfers@cwctv.net wrote:
> Could the integration of wine into the kernel, be a good idea to take?
> Its adding could be added to create a hybrid system that with extra
> dev could allow modem cards to work under Linux that wouldnt otherwise
> saving time and effort.

