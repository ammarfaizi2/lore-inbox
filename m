Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbVKPP7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbVKPP7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbVKPP7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:59:55 -0500
Received: from natfrord.rzone.de ([81.169.145.161]:7303 "EHLO
	natfrord.rzone.de") by vger.kernel.org with ESMTP id S1030378AbVKPP7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:59:55 -0500
From: Stefan Rompf <stefan@loplof.de>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] userland swsusp
Date: Wed, 16 Nov 2005 17:00:27 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511161700.27239.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> This is prototype of userland swsusp. I'd like kernel parts to go in,
> probably for 2.6.16. Now, I'm not sure about the interface, ioctls are
> slightly ugly, OTOH it would be probably overkill to introduce
> syscalls just for this. (I'll need to add an ioctl for freeing memory
> in future).

I'm curious on the restrictions the userspace part would have to accept.
Can /usr/swsusp.c write to a file? Currently, you allow it, but I doubt
whether it would be wise to write to a file after you've snapshotted
kernel's filesystem state. OTOH, I don't want to reserve a partition just
for the image. Can userspace allocate memory after ioctl(SYS_FREEZE)?

I have userspace supported encryption of the image in mind.

Stefan
