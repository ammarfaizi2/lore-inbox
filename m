Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTLQTnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 14:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTLQTnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 14:43:47 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:8181 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264535AbTLQTnp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 14:43:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: azarah@gentoo.org
Subject: Re: scsi_id segfault with udev-009
Date: Wed, 17 Dec 2003 11:43:27 -0800
User-Agent: KMail/1.4.1
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, patmans@us.ibm.com
References: <1071682198.5067.17.camel@nosferatu.lan> <200312171017.28358.dsteklof@us.ibm.com> <1071690009.11705.2.camel@nosferatu.lan>
In-Reply-To: <1071690009.11705.2.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200312171143.27226.dsteklof@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 December 2003 11:40 am, Martin Schlemmer wrote:
> On Wed, 2003-12-17 at 20:17, Daniel Stekloff wrote:
> > On Wednesday 17 December 2003 09:29 am, Martin Schlemmer wrote:
> > > Hi
> > >
> > > Getting this with scsi_id and udev-009:
> >
> > Hi,
> >
> > Scsi_id hasn't been changed to use the latest libsysfs changes. The
> > "directory" in the sysfs_class_device is now considered "private" and
> > only should be accessed using functions. Treating the structures as
> > handles lets us only load information when it's needed, reducing caching
> > or stale information and also helping performance.
> >
> > Here's the problem.
> >
> > static inline char *sysfs_get_attr(struct sysfs_class_device *dev,
> >                                     const char *attr)
> > {
> >         return
> > sysfs_get_value_from_attributes(dev->directory->attributes, attr);
> > }
> >
> > Please try this quick fix:
>
> Yep, that fixes it, thanks.  Btw, any reason it wont actually display
> anything ?
>
>
> Thanks,


Sorry, what won't display anything? Do you mean scsi_id or the fix? 

Thanks,

Dan
