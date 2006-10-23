Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWJWXEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWJWXEP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 19:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWJWXEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 19:04:15 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:5047 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932361AbWJWXEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 19:04:15 -0400
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061023153257.GC8414@elf.ucw.cz>
References: <1161576857.3466.9.camel@nigel.suspend2.net>
	 <20061023153257.GC8414@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 09:04:10 +1000
Message-Id: <1161644650.7033.23.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2006-10-23 at 17:32 +0200, Pavel Machek wrote:
> Hi!
> 
> > Switch from bitmaps to using extents to record what swap is allocated;
> > they make more efficient use of memory, particularly where the allocated
> > storage is small and the swap space is large.
> 
> > This is also part of the ground work for implementing support for
> > supporting multiple swap devices.
> 
> bitmaps were more efficient and longer than original code... I did not
> _like_ them, but they are in now. I'd hate to change the code again,
> for what, 0.5% gain?

0.5% of what? This is part of what is needed to implement support for
multiple swap devices. You could extend what you already have,
implementing bitmaps that require a bit for every page of swap the user
has swapon'd, but that doesn't seem efficient to me.

> ...and this is still longer than bitmaps.
> 
> And SNAPSHOT_GET_SWAP_PAGE seems to support multiple swap spaces
> already.

It may do, but swap.c certainly doesn't. It supports exactly one device.

Regards,

Nigel

