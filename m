Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWHaPIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWHaPIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 11:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWHaPIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 11:08:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12045 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932344AbWHaPIX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 11:08:23 -0400
Date: Tue, 29 Aug 2006 20:39:52 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sreenivas.Bagalkote@lsil.com,
       Sumant.Patro@lsil.com, jeff@garzik.org,
       lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Fedora vs. swsusp (was Re: megaraid_sas suspend ok, resume oops)
Message-ID: <20060829203951.GA5065@ucw.cz>
References: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com> <20060829081518.GD12257@kernel.dk> <b6a2187b0608290522vea22930y54ac39bfce3127f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a2187b0608290522vea22930y54ac39bfce3127f2@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Another point ... on IBM x60s notebook, setting ...
> 
>       High Memory Support (64GB)
>               CONFIG_HIGHMEM64G=y
>               CONFIG_RESOURCES_64BIT=y
>               CONFIG_X86_PAE=y

> 
> will cause resume to "REBOOT" sometimes (may be 6 out of 
> 10).

Okay, I guess that explains 'swsusp br0ken on Fedora' reports I was
seening.

I wonder if swsusp *ever* worked reliably with highmem64...

...wait a moment, higmem64 implies PAE implies we can no longer use
swsusp's trick with copying initial pgdir, and we'll need to use
x86-64-like code, no?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
