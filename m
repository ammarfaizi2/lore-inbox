Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266719AbUBEUA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266720AbUBEUA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:00:27 -0500
Received: from waste.org ([209.173.204.2]:22232 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266719AbUBEUAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:00:20 -0500
Date: Thu, 5 Feb 2004 13:59:24 -0600
From: Matt Mackall <mpm@selenic.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Martin J. Bligh" <mjbligh@us.ibm.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Subject: Re: [RFC/T 0/6] sysfs backing store (with symlink)
Message-ID: <20040205195923.GI31138@waste.org>
References: <20040204113758.GA4234@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204113758.GA4234@in.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 05:07:58PM +0530, Maneesh Soni wrote:
> Hi All,
> 
> Please find following patches for sysfs-backing store. This version has
> support for putting symlinks also on backing store. Earlier it has support
> for text/binary attribute files. 
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107269078726254&w=2
> 
> Apart from a few bug fixes, the main change in this version is for symlinks. 
> sysfs_create_link() now does not create dentry/inode for the link, but 
> allocates a sysfs_dirent and adds it the parent sysfs_dirent's s_children 
> list. dentry/inode for the link is created when the symlink is first looked up. 
> 
> I request Martin and Mackall to _replace_ the old patch set with the 
> new one in their trees.

I finally got around to testing this in tiny, and it works quite well.
I actually got it working in my mem=2m test case, though it was a
little tight.

It's the philosophy of -tiny to make all new features optional, so I'm
currently in the process of making it a config option and am going
back through and adding CONFIG_SYSFS_BACK. Will post a new version
as part of my next -tiny shortly.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
