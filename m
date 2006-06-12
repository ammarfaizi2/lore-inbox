Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWFLU4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWFLU4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWFLU4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:56:49 -0400
Received: from rtr.ca ([64.26.128.89]:13024 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750868AbWFLU4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:56:48 -0400
Message-ID: <448DD50F.3060002@rtr.ca>
Date: Mon, 12 Jun 2006 16:56:47 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb,
 error -28
References: <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de>
In-Reply-To: <20060612204918.GA16898@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
..
> It's a flaky thing.

No kidding.  Okay, it is also now failing for me with 2.6.16.18.

BUT.. with exactly that same binary kernel, it worked fine
not long ago --> but I've swapped out userland since then,
upgrading from Breezy to Dapper.  So something userland in Dapper
is triggering this failure, in a way that Breezy never did before.

This device has been quite usable until now (the upgrade to Dapper).

> Known issue for years.  Either plug it directly into the USB 2.0 root
> hub, or disable the ehci driver.

MMm.. yes, that makes some sense.  I have a pl2303 standalone that works fine,
but the one integrated into the 1.1 hub/dock is the one that fails.

If I plug the 1.1 hub/dock into another external hub, no problems.

> Also, look in the -mm tree, there is a fix for this direct error, and
> hopefully some ehci fixes that enable the whole thing to work properly.

Okay, I'll hunt for that.  Do you know of the exact patch?

Thanks
