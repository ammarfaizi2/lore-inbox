Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTJFNoJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 09:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTJFNoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 09:44:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56299 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262081AbTJFNnV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 09:43:21 -0400
Date: Mon, 6 Oct 2003 14:43:20 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <gregkh@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 2/6] sysfs-mount.patch
Message-ID: <20031006134320.GP7665@parcelfarce.linux.theplanet.co.uk>
References: <20031006085915.GE4220@in.ibm.com> <20031006090003.GF4220@in.ibm.com> <20031006090030.GG4220@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006090030.GG4220@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 02:30:30PM +0530, Maneesh Soni wrote:
> @@ -692,6 +693,10 @@ do_kern_mount(const char *fstype, int fl
>  	mnt->mnt_mountpoint = sb->s_root;
>  	mnt->mnt_parent = mnt;
>  	up_write(&sb->s_umount);
> +
> +	if (!strcmp(fstype, "sysfs"))
> +		sysfs_mount = mnt;
> +
>  	put_filesystem(type);
>  	return mnt;
>  out_sb:

That's too ugly for words.  Vetoed.  Sorry, but *that* will not fly.
