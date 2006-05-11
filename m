Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbWEKAXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWEKAXr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 20:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbWEKAXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 20:23:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:8384 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965107AbWEKAXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 20:23:46 -0400
Date: Wed, 10 May 2006 17:16:46 -0700
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Hans A Eide <haeide@usit.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block/ub.c: Increase number of partitions for usb storage
Message-ID: <20060511001646.GB27465@kroah.com>
References: <mailman.1146575400.25877.linux-kernel2news@redhat.com> <20060502202412.0d68150f.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502202412.0d68150f.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 08:24:12PM -0700, Pete Zaitcev wrote:
> On Tue, 2 May 2006 14:59:52 +0200, Hans A Eide <haeide@usit.uio.no> wrote:
> 
> > I do backups to external USB storage and hit the 8 partitions limit  
> > of ub.c
> > This could also be a problem for others (HFS+ formatted iPods?)
> 
> It was a bad mistake in retrospect. I limited ub to 8 partitions
> because I wanted to fit 26 devices into 8 bits of minor.
> 
> > Any reason for not increasing the partitions limit to 16?
> 
> Doing so would not be compatible for systems which do not run udevd.
> Linus forbade such changes, and I agree. So, if we strongly needed
> ub to go beyond 1+7 partitions, we would need some kind of a remapping
> scheme. I have to discuss this with Greg or Harald. Making dis-
> contiguous nodes is easy with mknod, but I do not know if udev
> supports it.

udev can handle it just fine, as it just looks at the sysfs "dev" file
to get the major:minor numbers.  It knows nothing about "ranges" :)

thanks,

greg k-h
