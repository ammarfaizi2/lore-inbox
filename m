Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbWJDOnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbWJDOnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161146AbWJDOnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:43:43 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:27953 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161145AbWJDOnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:43:42 -0400
Date: Wed, 4 Oct 2006 16:44:13 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/base: error handling fixes
Message-ID: <20061004164413.3352df7d@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061004130554.GA25974@havoc.gtf.org>
References: <20061004130554.GA25974@havoc.gtf.org>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 09:05:54 -0400,
Jeff Garzik <jeff@garzik.org> wrote:

> drivers/base/class:
> - class_device_rename(): function basically shat itself if anything
>   failed, leaving things in an indeterminant state.  If kmalloc() ever
>   failed, it would dereference ERR_PTR(-ENOMEM).  Fix a bunch of bugs,
>   over and above sysfs_create_link() error handling.
> 
> - class_device_add(): add missing sysfs_remove_link() [fix leak] to error path
> - class_device_add(): handle sysfs_create_link() failure
> 
> drivers/base/dmapool:
> - kmalloc() takes a GFP_xxx argument
> - handle device_create_file() failure
> 
> drivers/base/platform:
> - properly handle errors (fix leak-on-err) in platform_bus_init()
> 
> drivers/base/topology:
> - return sysfs error via NOTIFY_BAD

Hm, I already did fixes for some of these which are in -mm / in Greg's
tree. It would perhaps make sense if you rediffed against one of those
trees.

Cornelia
