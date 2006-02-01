Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWBANhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWBANhS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWBANhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:37:18 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:42131 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161019AbWBANhQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:37:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CEQgUE1zers4wuQ+J7i/wQH6tCPIE7YV4hmuDku/rt+pvT8l+zU64UzkAm24inwhE3JBksPE3EvDX++7sTq0h4nOkSAxpVOTZszAa/xjDhB9z2jBSHCRzjIXlXiLba3WC2VgvLJUS8fQXZNkUkdQ5CT6PQjbKzwhepiA82hnfog=
Message-ID: <7d40d7190602010537i3f10b722h@mail.gmail.com>
Date: Wed, 1 Feb 2006 14:37:15 +0100
From: Aritz Bastida <aritzbastida@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060130214118.GB26463@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7d40d7190601261206wdb22ccck@mail.gmail.com>
	 <20060127050109.GA23063@kroah.com>
	 <7d40d7190601270230u850604av@mail.gmail.com>
	 <20060130214118.GB26463@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 3.- Actually the most difficult config I must do is to pass three
> > values from userspace to my module. Specifically two integers and a
> > long (it's an offset to a memory zone I've previously defined)
> >
> > struct meminfo {
> >         unsigned int      id;         /* segment identifier */
> >         unsigned int      size;     /* size of the memory area */
> >         unsigned long   offset;   /* offset to the information */
> > };
> >
> > How would you pass this information in sysfs? Three values in the same
> > file? Note that using three different files wouldn't be atomic, and I
> > need atomicity.
>
> Use configfs.
>

Ummhh, and would it be correct to configure my device via a netlink
socket? Remember that my driver is a kind of network "virtual" device.

There are so many old and new ways to configure a driver that I'm a
bit overwhelmed...

Regards
Aritz
