Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266763AbUHWUUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266763AbUHWUUG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUHWUTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:19:43 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:9369 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S267428AbUHWTSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:18:02 -0400
Subject: Re: [PATCH][2/7] xattr consolidation - LSM hook changes
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Christoph Hellwig <hch@infradead.org>
Cc: James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>
In-Reply-To: <20040823200353.A20114@infradead.org>
References: <Xine.LNX.4.44.0408231414270.13728-100000@thoron.boston.redhat.com>
	 <Xine.LNX.4.44.0408231415310.13728-100000@thoron.boston.redhat.com>
	 <20040823200353.A20114@infradead.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1093288398.27211.257.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 23 Aug 2004 15:13:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-23 at 15:03, Christoph Hellwig wrote:
> On Mon, Aug 23, 2004 at 02:16:17PM -0400, James Morris wrote:
> > This patch replaces the dentry parameter with an inode in the LSM
> > inode_{set|get|list}security hooks, in keeping with the ext2/ext3 code.
> > dentries are not needed here.
> 
> Given that the actual methods take a dentry this sounds like a bad design.
> Can;t you just pass down the dentry through all of the ext2 interfaces?

Changing the methods to take an inode would be even better, IMHO, as the
dentry is unnecessary.  That would simplify SELinux as well.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

