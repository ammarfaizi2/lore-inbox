Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268479AbUHYHHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268479AbUHYHHg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 03:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268480AbUHYHHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 03:07:36 -0400
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:19890 "EHLO
	tyo206.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S268479AbUHYHHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 03:07:33 -0400
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][7/7] add xattr support to ramfs
References: <Xine.LNX.4.44.0408231420100.13728-100000@thoron.boston.redhat.com>
	<Xine.LNX.4.44.0408231421200.13728-100000@thoron.boston.redhat.com>
	<20040823212623.A20995@infradead.org>
	<1093292789.27211.279.camel@moss-spartans.epoch.ncsc.mil>
	<20040823205942.GA3370@kroah.com>
	<1093346824.1800.34.camel@moss-spartans.epoch.ncsc.mil>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Wed, 25 Aug 2004 16:03:09 +0900
In-Reply-To: <1093346824.1800.34.camel@moss-spartans.epoch.ncsc.mil> (Stephen
 Smalley's message of "Tue, 24 Aug 2004 07:27:04 -0400")
Message-ID: <buoy8k3pumq.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@epoch.ncsc.mil> writes:
> It makes no difference to me whether we use ramfs or tmpfs (I'd favor
> tmpfs myself)

What's the essential difference between ramfs and tmpfs anyway?

I've gotten the impression that ramfs is simpler and lighter-weight than
tmpfs, but doesn't have some features like resource-limiting.

If that's the case, then for something like /dev -- a small in-core
filesystem that won't have arbitrary user files plunked into it -- ramfs
seems an obvious choice.

Also, tmpfs seems to require an MMU, which not all linux systems have
(though I suppose the lack of an MMU makes many security tweaks a bit
pointless :-).

-Miles
-- 
Occam's razor split hairs so well, I bought the whole argument!
