Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUHXAyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUHXAyx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUHXAyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 20:54:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36825 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267494AbUHXAyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 20:54:31 -0400
Date: Mon, 23 Aug 2004 20:54:14 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH][2/7] xattr consolidation - LSM hook changes
In-Reply-To: <1093288398.27211.257.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0408232046290.16044-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Stephen Smalley wrote:

> On Mon, 2004-08-23 at 15:03, Christoph Hellwig wrote:

> > Given that the actual methods take a dentry this sounds like a bad design.
> > Can;t you just pass down the dentry through all of the ext2 interfaces?
> 
> Changing the methods to take an inode would be even better, IMHO, as the
> dentry is unnecessary.  That would simplify SELinux as well.

This could work for all in-tree filesystems with xattrs, except CIFS,
which passes the dentry to it's own build_path_from_dentry() function.  

(In this case, they probably want to use d_path() and have a vfsmnt added 
to the methods?).


- James
-- 
James Morris
<jmorris@redhat.com>


