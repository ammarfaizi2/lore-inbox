Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTJGHRo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 03:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTJGHRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 03:17:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:64437 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261863AbTJGHRn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 03:17:43 -0400
Date: Tue, 7 Oct 2003 12:47:16 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <gregkh@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 2/6] sysfs-mount.patch
Message-ID: <20031007071716.GC9036@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031006085915.GE4220@in.ibm.com> <20031006090003.GF4220@in.ibm.com> <20031006090030.GG4220@in.ibm.com> <20031006134320.GP7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006134320.GP7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 02:43:20PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Oct 06, 2003 at 02:30:30PM +0530, Maneesh Soni wrote:
> > @@ -692,6 +693,10 @@ do_kern_mount(const char *fstype, int fl
> >  	mnt->mnt_mountpoint = sb->s_root;
> >  	mnt->mnt_parent = mnt;
> >  	up_write(&sb->s_umount);
> > +
> > +	if (!strcmp(fstype, "sysfs"))
> > +		sysfs_mount = mnt;
> > +
> >  	put_filesystem(type);
> >  	return mnt;
> >  out_sb:
> 
> That's too ugly for words.  Vetoed.  Sorry, but *that* will not fly.

Yeah.. that was not meant to fly.. and I didnot pushed the patches on runway
and to any of the Air Traffic Controllers..(tree maintainers) :-).. 

I will get rid of sysfs_mount.

Maneesh
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
