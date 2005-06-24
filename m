Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262998AbVFXPSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbVFXPSF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbVFXPSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:18:05 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:54440 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262998AbVFXPRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:17:06 -0400
Date: Fri, 24 Jun 2005 11:17:02 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
In-Reply-To: <20050624081808.GA26174@kroah.com>
Message-ID: <Pine.LNX.4.58.0506241113460.17615@localhost.localdomain>
References: <20050624081808.GA26174@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Jun 2005, Greg KH wrote:

> Now I just know I'm going to regret this somehow...
>


;)

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ gregkh-2.6/fs/ndevfs/inode.c	2005-06-24 01:06:02.000000000 -0700
> @@ -0,0 +1,249 @@
> +/*
> + *  inode.c - part of ndevfs, a tiny little device file system
> + *
> + *  Copyright (C) 2004,2005 Greg Kroah-Hartman <greg@kroah.com>
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License version
> + *	2 as published by the Free Software Foundation.
> + *
> + * Written for all of the people out there who just hate userspace solutions.
> + *
> + */
> +
> +/* uncomment to get debug messages */
> +#define DEBUG
> +

Don't you mean here "comment to turn off debug messages?" :-)

-- Steve

> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/mount.h>
> +#include <linux/pagemap.h>
> +#include <linux/init.h>
> +#include <linux/namei.h>
