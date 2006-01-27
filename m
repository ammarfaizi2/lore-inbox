Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWA0HEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWA0HEd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 02:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWA0HEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 02:04:33 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:23735 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751386AbWA0HEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 02:04:32 -0500
Date: Fri, 27 Jan 2006 08:04:23 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] debugfs: hard link count wrong
Message-ID: <20060127070423.GB9331@osiris.boeblingen.de.ibm.com>
References: <20060126141142.GA11599@osiris.boeblingen.de.ibm.com> <20060127032513.GA12559@suse.de> <20060127055607.GA9331@osiris.boeblingen.de.ibm.com> <20060127063804.GA4680@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127063804.GA4680@suse.de>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Device: eh/14d  Inode: 15528       Links: 2
> > Links should be 3, I thought? For an empty directory it's 2 and as soon as
> > you create a new directory in there it should be increased by 1. Therefore
> > it should be 3. Or am I missing something?
> 
> Yeah, I think you are correct.  But I don't see where in the debugfs
> code I messed this up...
> 
> In debugfs_mkdir() we increment the parent i_nlink properly if we create
> the new subdirectory, and based on other implementations like this
> (usbfs), that logic seems to be correct.
> 
> Unless something is odd with creating a directory in the root of the fs.
> Does the subdirectory you have created have the proper number of links?

Yes, everything below the debug directory itself seems to be ok.

> > Btw.: my find version: "GNU find version 4.2.20".
> Hm, newer versions of find don't complain about this?

The latest version I could find at http://ftp.gnu.org/pub/gnu/findutils/
is 4.2.27 which still complains. No, idea from where you got the 4.2.30 :)

Thank,
Heiko
