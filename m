Return-Path: <linux-kernel-owner+w=401wt.eu-S1755219AbXABDbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219AbXABDbq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 22:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755230AbXABDbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 22:31:46 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49410
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755219AbXABDbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 22:31:46 -0500
Date: Mon, 01 Jan 2007 19:31:44 -0800 (PST)
Message-Id: <20070101.193144.74746471.davem@davemloft.net>
To: segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       wmb@firmworks.com, hch@infradead.org, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <a54f3f0a00e6e50cfd3ce90995943960@kernel.crashing.org>
References: <385664dfd55cfdfb9f9651fc90bf46b0@kernel.crashing.org>
	<20070101.150831.17863014.davem@davemloft.net>
	<a54f3f0a00e6e50cfd3ce90995943960@kernel.crashing.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 2 Jan 2007 00:52:36 +0100

> There is one big problem: text representation is useless
> (to scripts etc.) unless it can be transformed back to binary;
> i.e., it has to be possible to reliably detect _how_ some
> property is represented into text, something that cannot be
> done with how openpromfs handles it.

Text is text is text for many propertiers, in particular
the ones you actually end up wanting to modify.

The biggest and most used example are the device aliases
and the 'boot-device' and 'boot-file' environment variables.

We even have a special case for that latter case on sparc
via:

	echo 'foo.image' >/proc/sys/kernel/reboot-cmd

In order for a problem to exist, you have to show counter
examples where the problem triggers and something fails.

What in userspace wants to modify a OFW property, which
is not text?

In my experience all such cases are limited to ASCII text
valued properties, such as device aliases, environment
variables, and things like nvramrc.
