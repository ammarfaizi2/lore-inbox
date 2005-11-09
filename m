Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965285AbVKIIOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965285AbVKIIOQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 03:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965297AbVKIIOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 03:14:16 -0500
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:10633 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S965285AbVKIIOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 03:14:16 -0500
Date: Wed, 9 Nov 2005 08:55:16 +0100 (CET)
From: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: userspace block driver?
In-Reply-To: <4371A4ED.9020800@pobox.com>
Message-ID: <Pine.LNX.4.58.0511090852440.22793@fachschaft.cup.uni-muenchen.de>
References: <4371A4ED.9020800@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Nov 2005, Jeff Garzik wrote:

> 
> Has anybody put any thought towards how a userspace block driver would work?
> 
> Consider a block device implemented via an SSL network connection.  I don't
> want to put SSL in the kernel, which means the only other alternative is to
> pass data to/from a userspace daemon.

I am afraid this is impossible without some heavy infrastructure work.
You will almost inevitably deadlock. Yes, you can mlock() your driver, but 
that still will not tell the kernel that GFP_KERNEL must be replaced with 
GFP_NOIO if it is triggered by syscalls you are doing.

	Regards
		Oliver

