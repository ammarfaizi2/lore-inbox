Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUFYUDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUFYUDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 16:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUFYUDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 16:03:52 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:53983 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263770AbUFYUDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 16:03:51 -0400
Date: Fri, 25 Jun 2004 22:03:42 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Alexander Nyberg <alexn@telia.com>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] A generic_file_sendpage()
Message-ID: <20040625200342.GE8656@wohnheim.fh-wedel.de>
References: <20040608154438.GK18083@dualathlon.random> <20040608193621.GA12780@holomorphy.com> <1086783559.1194.24.camel@boxen> <20040625191924.GA8656@wohnheim.fh-wedel.de> <20040625194611.GQ12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040625194611.GQ12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 June 2004 20:46:11 +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > One of my goals for 2.7 is to get rid of all users of struct file* in
> > the various read-, write- and send-functions.  Currently, there are
> > four of them, you would introduce number five.
> 
> And how, pray tell, are you going to do that on filesystems that keep
> part of context in file->private_data?

Not sure.  NFSv3 appears to be fixable, the only context is the UID,
which happens to be stored in the inode as well.  NFSv4 and cifs could
be worse, I didn't look closely yet.  smbfs accesses the dentry, which
has similar effects, but should be fixable as well.

Do you know of any impossible cases?

Jörn

-- 
My second remark is that our intellectual powers are rather geared to
master static relations and that our powers to visualize processes
evolving in time are relatively poorly developed.
-- Edsger W. Dijkstra
