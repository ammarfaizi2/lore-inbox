Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbUKMAsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbUKMAsk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbUKMAqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 19:46:33 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:51420 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262731AbUKMAoN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 19:44:13 -0500
Date: Fri, 12 Nov 2004 16:44:01 -0800
From: Greg KH <greg@kroah.com>
To: Kenneth Aafl?y <lists@kenneth.aafloy.net>,
       Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
Message-ID: <20041113004401.GA18269@kroah.com>
References: <1100300406618@kroah.com> <11003004062835@kroah.com> <20041113000052.GC346@electric-eye.fr.zoreil.com> <11003004062835@kroah.com> <200411130020.17494.lists@kenneth.aafloy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041113000052.GC346@electric-eye.fr.zoreil.com> <200411130020.17494.lists@kenneth.aafloy.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replied to both of you, and the list, to prevent others from pointing
out the same thing multiple times :)

Oh, it's nice to see that people actually read these patches, I like it.


On Sat, Nov 13, 2004 at 12:20:17AM +0100, Kenneth Aafl?y wrote:
> On Saturday 13 November 2004 00:00, Greg KH wrote:
> > ChangeSet 1.2094, 2004/11/12 11:42:03-08:00, miltonm@bga.com
> >
> > [PATCH] fix sysfs backing store error path confusion
> [snip]
> >   sd = sysfs_new_dirent(parent_sd, element);
> >   if (!sd)
> > -  return 0;
> > +  return -ENOMEMurn -ENOMEM;
> 
> Confusingly strange :)
> 
> Kenneth

On Sat, Nov 13, 2004 at 01:00:52AM +0100, Francois Romieu wrote:
> Greg KH <greg@kroah.com> :
> [...]
> > diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
> > --- a/fs/sysfs/dir.c	2004-11-12 14:53:33 -08:00
> > +++ b/fs/sysfs/dir.c	2004-11-12 14:53:33 -08:00
> [...]
> > @@ -56,7 +56,7 @@
> >  
> >  	sd = sysfs_new_dirent(parent_sd, element);
> >  	if (!sd)
> > -		return 0;
> > +		return -ENOMEMurn -ENOMEM;
> 
> Oops.

Yeah, I don't know what happened with my tools here.  But if you look at
the next patch in the series, I fixed it.

thanks,

greg k-h
