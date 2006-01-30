Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWA3LXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWA3LXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 06:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWA3LXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 06:23:15 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:42894 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932218AbWA3LXO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 06:23:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fda9CNzUdIlw+rts34Q5aOJWeADJxuLD/cXDxRs5Yl4SCKkjVrNOh1htjsnFybGJ97gMQ2To9dn4L0+qmYhn1vSeqq/RHnFWSKzz7VdeClQeOMHNrss0h1HOe0evcOg/Zwy2St2QthDEDqxO7E8hMVB8dRuf6zUgqtjmRrBVHcs=
Message-ID: <7d40d7190601300323t1aca119ci@mail.gmail.com>
Date: Mon, 30 Jan 2006 12:23:14 +0100
From: Aritz Bastida <aritzbastida@gmail.com>
To: Antonio Vargas <windenntw@gmail.com>
Subject: Re: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <69304d110601270834q5fa8a078m63a7168aa7e288d1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7d40d7190601261206wdb22ccck@mail.gmail.com>
	 <20060127050109.GA23063@kroah.com>
	 <7d40d7190601270230u850604av@mail.gmail.com>
	 <69304d110601270834q5fa8a078m63a7168aa7e288d1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Antonio and Greg
But I still have one question pending:

> >
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
> >

I guess I could pass three values on the same file, like this:
$ echo "5  1000  500" > meminfo

I know that breaks the sysfs golden-rule, but how can I pass those
values _atomically_ then? Having three different files wouldn't be
atomic...

Regards
Aritz
