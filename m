Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281805AbRLBVWr>; Sun, 2 Dec 2001 16:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281797AbRLBVWi>; Sun, 2 Dec 2001 16:22:38 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:24767 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S279305AbRLBVW0>; Sun, 2 Dec 2001 16:22:26 -0500
Date: Sun, 2 Dec 2001 14:22:26 -0700
Message-Id: <200112022122.fB2LMQp13705@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C09D414.B1811231@wanadoo.fr>
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
	<9u9qas$1eo$1@penguin.transmeta.com>
	<200112010701.fB171N824084@vindaloo.ras.ucalgary.ca>
	<3C0898AD.FED8EF4A@wanadoo.fr>
	<200112011836.fB1IaxY31897@vindaloo.ras.ucalgary.ca>
	<3C093F86.DA02646D@wanadoo.fr>
	<200112012347.fB1NleW03464@vindaloo.ras.ucalgary.ca>
	<3C09D414.B1811231@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet writes:
> The oops comes shortly after booting, loging in, starting devfsd-v1.3.20
> and playing with mc.
> The attached file is the same; it may be easier to read. The last line
> is the last entry of the log before <SysRq U>, <SysRq B>.
> 
> Dec  2 07:39:29 milou kernel: devfs: devfs_unregister(): de->name: "s3"
> de: cf6ddf3c 
> Dec  2 07:39:29 milou kernel: devfs: d_delete(): dentry: cf6c4c8c 
> inode: cf6c1a0c  devfs_entry: c14d0a94 
[...]

This isn't the complete kernel messages! You've edited it. These first
two lines should be related, yet the devfs entries are different. If I
had the complete kernel messages, I could see what devfs_entry
c14d0a94 is supposed to be. And there might be other clues related to
the dentry values. Also, please changed the second printk() in
devfs_d_delete() to this:
    if (devfs_debug & DEBUG_D_DELETE)
	printk ("%s: d_delete(%s): dentry: %p  inode: %p  devfs_entry: %p pp: %p \"%s\"\n",
		DEVFS_NAME, de->name, dentry, inode, de, de->parent, de->parent->name);


Please, edit nothing. If the output is big, just send it to me so you
don't spam the list.

Also, please send me the output of lsmod prior to the Oops.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
