Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUFZBbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUFZBbN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 21:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266915AbUFZBbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 21:31:13 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:53661 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266914AbUFZBbM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 21:31:12 -0400
Subject: Re: [PATCH] A generic_file_sendpage()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alexander Nyberg <alexn@telia.com>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20040625200342.GE8656@wohnheim.fh-wedel.de>
References: <20040608154438.GK18083@dualathlon.random>
	 <20040608193621.GA12780@holomorphy.com> <1086783559.1194.24.camel@boxen>
	 <20040625191924.GA8656@wohnheim.fh-wedel.de>
	 <20040625194611.GQ12308@parcelfarce.linux.theplanet.co.uk>
	 <20040625200342.GE8656@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1088211213.9740.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 25 Jun 2004 20:53:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 25/06/2004 klokka 16:03, skreiv Jörn Engel:
> Not sure.  NFSv3 appears to be fixable, the only context is the UID,

Huh???? WTF happened to the actual credential?

> which happens to be stored in the inode as well.  NFSv4 and cifs could
> be worse, I didn't look closely yet.  smbfs accesses the dentry, which
> has similar effects, but should be fixable as well.
> 
> Do you know of any impossible cases?

NFS, CIFS, all other networked filesystems that need private context
information beyond what is contained in the struct file. Why?

Trond
