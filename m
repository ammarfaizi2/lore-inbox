Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbTKLQlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 11:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbTKLQlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 11:41:07 -0500
Received: from mail.kroah.org ([65.200.24.183]:11993 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263119AbTKLQlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 11:41:03 -0500
Date: Wed, 12 Nov 2003 08:39:57 -0800
From: Greg KH <greg@kroah.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/5] Backing Store for sysfs (Overhauled)
Message-ID: <20031112163957.GA28951@kroah.com>
References: <20031112122344.GD14580@in.ibm.com> <20031112160015.GA28684@kroah.com> <20031112162740.GA1776@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112162740.GA1776@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 09:57:40PM +0530, Dipankar Sarma wrote:
> On Wed, Nov 12, 2003 at 08:00:15AM -0800, Greg KH wrote:
> > On Wed, Nov 12, 2003 at 05:53:44PM +0530, Maneesh Soni wrote:
> > > 
> > > The concept is still the same that in this prototype also we create dentry and 
> > > inode on the fly when they are first looked up. This is done for both leaf or 
> > > non-leaf dentries. The generic nature of sysfs_dirent makes it easy to do for 
> > > both leaf or non-leaf dentries. 
> > 
> > What happens once a dentry and inode is created?  Is there any way for
> > them to be forced out, or do they stay around in memory forever?
> 
> The idea atleast, is that if no one is using a dentry, it will
> be put in the dentry lru list and eventually returned to the slab.
> inodes too are returned alongwith. Just like how on-disk filesystems work.

Do you all have any numbers backing this up?

thanks,

greg k-h
