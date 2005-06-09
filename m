Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVFINPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVFINPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 09:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVFINJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 09:09:40 -0400
Received: from [85.8.12.41] ([85.8.12.41]:38324 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262004AbVFINJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 09:09:17 -0400
Message-ID: <42A83F59.7090509@drzeus.cx>
Date: Thu, 09 Jun 2005 15:08:41 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: MMC ioctl or sysfs interface?
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MMC cards have the feature to lock down cards using a special password.
When the cards is locked it will not accept any commands except
lock-related ones.

I've been thinking about implementing support for this in Linux but I'm
not sure which interface should be used for it. The functions needed are:

* Lock card with a supplied password.
* Unlock card using a password.
* Clear password.
* Erase lock (clears the card and removes the lock).

Since you want some feedback with the result of the operation an ioctl
seemed appropriate. But mmc cards don't have device nodes so there is
nothing to do ioctls on. So in that perspective a sysfs solution would
be better. But how to you do the interaction with userspace in a good way?

Ideas are very welcome.

Rgds
Pierre
