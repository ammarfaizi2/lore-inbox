Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUITXHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUITXHs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 19:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUITXHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 19:07:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4554 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266199AbUITXHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 19:07:40 -0400
Date: Mon, 20 Sep 2004 19:07:21 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Will Dyson <will.dyson@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] xattr consolidation v2 - generic xattr API
In-Reply-To: <8e6f9472040920105013b4e0cd@mail.gmail.com>
Message-ID: <Xine.LNX.4.44.0409201904220.23206-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2004, Will Dyson wrote:

> I don't plan on holding my breath while waiting for "The linux vfs
> layer for dummies" to come out. But a quick comment to explain the
> purpose and use of a block of code can make a world of difference to
> someone trying to come up to speed.

If you want to supply documentation patches, please feel free to do so.

> For example:
> 
> /*
> In order to implement different sets of xattr operations for each
> xattr prefix, a filesystem should create a null-terminated array of
> struct xattr_handler (one for each prefix) and hang a pointer to it
> off of the s_xattr field of the superblock. The generic_fooxattr
> functions will search this list for a xattr_handler with a prefix
> field that matches the prefix of the xattr we are dealing with and
> call the apropriate function pointer from that xattr_handler.
> */

The above is inaccurate.  e.g. not all of the generic functions search for
a matching xattr handler.


- James
-- 
James Morris
<jmorris@redhat.com>

