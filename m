Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264912AbUF1Llg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbUF1Llg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 07:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264914AbUF1Llg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 07:41:36 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:21683 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264912AbUF1Lle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 07:41:34 -0400
Date: Mon, 28 Jun 2004 13:41:03 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alexander Nyberg <alexn@telia.com>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] A generic_file_sendpage()
Message-ID: <20040628114103.GB1010@wohnheim.fh-wedel.de>
References: <20040608154438.GK18083@dualathlon.random> <20040608193621.GA12780@holomorphy.com> <1086783559.1194.24.camel@boxen> <20040625191924.GA8656@wohnheim.fh-wedel.de> <20040625194611.GQ12308@parcelfarce.linux.theplanet.co.uk> <20040625200342.GE8656@wohnheim.fh-wedel.de> <1088211213.9740.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1088211213.9740.16.camel@lade.trondhjem.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 June 2004 20:53:34 -0400, Trond Myklebust wrote:
> På fr , 25/06/2004 klokka 16:03, skreiv Jörn Engel:
> > Not sure.  NFSv3 appears to be fixable, the only context is the UID,
> 
> Huh???? WTF happened to the actual credential?

No idea, I couldn't find it in the source.

> > which happens to be stored in the inode as well.  NFSv4 and cifs could
> > be worse, I didn't look closely yet.  smbfs accesses the dentry, which
> > has similar effects, but should be fixable as well.
> > 
> > Do you know of any impossible cases?
> 
> NFS, CIFS, all other networked filesystems that need private context
> information beyond what is contained in the struct file. Why?

Darn!  I need to copy an inode.  Currently, I'm opening a two files,
copy between them and close them again.  Open and close are completely
pointless and only complicate things.

The fun part is that cifs would actually benifit from the same things
it complicates.  Oh well.

Jörn

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.
