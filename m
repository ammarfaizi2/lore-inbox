Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbULURrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbULURrC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 12:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbULURrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 12:47:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:32418 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261818AbULURq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 12:46:59 -0500
Date: Tue, 21 Dec 2004 09:46:48 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add mmap support to struct bin_attribute files
Message-ID: <20041221174648.GA8000@kroah.com>
References: <200412210932.54961.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412210932.54961.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 09:32:54AM -0800, Jesse Barnes wrote:
>   * Copyright (c) 2001,2002 Patrick Mochel
> + * Copyright (c) 2004 Silicon Graphics, Inc.

Minor nit, some copyright lawyers I know say it should be (C) not (c),
for what it's worth...

> +struct vm_area_struct; /* circular dependencies? */

Drop the comment :)

>  struct bin_attribute {
>  	struct attribute	attr;
>  	size_t			size;
> +	void			*private;

Why the private pointer?  Don't you get everything you need in the
kobject itself?

thanks,

greg k-h
