Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbTDFEgN (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 23:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTDFEgN (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 23:36:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:46738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262785AbTDFEgM (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 23:36:12 -0500
Message-ID: <33026.4.64.238.61.1049604463.squirrel@webmail.osdl.org>
Date: Sat, 5 Apr 2003 20:47:43 -0800 (PST)
Subject: Re: does video for linux depend on I2C?
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <rpjday@mindspring.com>
In-Reply-To: <Pine.LNX.4.44.0304051436340.20539-100000@dell>
References: <Pine.LNX.4.44.0304051436340.20539-100000@dell>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11 [cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>  the help screen for I2C support claims that you need
> I2C for video for linux support.  however, it's still
> possible to not select I2C and yet select video for
> linux.
>
>   is there a Kconfig dependency missing here?

A grep in drivers/media/*.c finds 44 files that contain I2C or i2c.
At least one of them is only a comment.
And drivers/media/video/Kconfig does include I2C as a dependency in
some cases.

The I2C subsystem seems to be in a great state of flux right now also.

I expect that the statement in drivers/i2c/Kconfig is a bit strong;
I don't think that I2C is needed for _all_ V4L support, just some of them.

~Randy



