Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWD3ElB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWD3ElB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 00:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWD3ElB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 00:41:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:16852 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750933AbWD3ElA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 00:41:00 -0400
Date: Sat, 29 Apr 2006 14:55:01 -0700
From: Greg KH <greg@kroah.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Michael Holzheu <holzheu@de.ibm.com>, akpm@osdl.org,
       schwidefsky@de.ibm.com, penberg@cs.helsinki.fi, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060429215501.GA9870@kroah.com>
References: <20060428112225.418cadd9.holzheu@de.ibm.com> <20060429075311.GB1886@kroah.com> <8A7D2F4D-5A05-4C93-B514-03268CAA9201@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A7D2F4D-5A05-4C93-B514-03268CAA9201@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2006 at 04:41:05AM -0400, Kyle Moffett wrote:
> On Apr 29, 2006, at 03:53:11, Greg KH wrote:
> >>The update process is triggered when writing 'something' into the  
> >>'update' file at the top level hypfs directory. You can do this  
> >>e.g. with 'echo 1 > update'. During the update the whole directory  
> >>structure is deleted and built up again.
> >
> >This sounds a lot like configfs.  Why not use that instead?
> >
> >Is there a reason that sysfs can't be used for a lot of these  
> >things too?
> >
> >We already have the different cpus in sysfs, why put things in a  
> >different location than that?
> 
> It sounds like a lot of things need some kind of shell-scriptable  
> transaction interface for sysfs files.  You don't want to have more  
> than one value per file, but reading or writing of some values must  
> be done together for consistency reasons.  Is there any way to  
> implement something like this?  This would work for the framebuffer  
> people and solve the needs of a lot of the people who still want  
> ioctls or some other atomic-multivalued transfer that would otherwise  
> be a great sysfs candidate.

relayfs is for that.  You can now put relayfs files in any ram based
file system (procfs, ramfs, sysfs, debugfs, etc.)

thanks,

greg k-h
