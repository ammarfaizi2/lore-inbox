Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269144AbUIRHSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269144AbUIRHSo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 03:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269147AbUIRHSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 03:18:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23480 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269144AbUIRHSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 03:18:40 -0400
Date: Sat, 18 Sep 2004 03:18:19 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] xattr consolidation v2
Message-ID: <Xine.LNX.4.44.0409180252090.10905-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset is a reworking of the xattr consolidation patches I
posted on 23/08.  They have been reworked taking into account feedback
from Christoph Hellwig and others.  Changes since then:

- Attach xattr handlers to the superblock.
- Remove xattr handler locking.
- Renamed consolidated xattr code from simple_ to generic_.
- Move generic code from libfs to xattr.c
- Use generic functions directly as inode op methods.
- Drop support for ramfs.
- Lots of resulting cleanup (e.g. remove handler registration etc.).

There was discussion of passing only inodes to inode op methods, but CIFS 
needs dentries, so that was not done.

This code has been quite well tested.

Please review and apply if ok.


- James
-- 
James Morris
<jmorris@redhat.com>




