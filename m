Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269030AbUHXEch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269030AbUHXEch (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 00:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269031AbUHXEcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 00:32:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62402 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269030AbUHXEcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 00:32:24 -0400
Date: Tue, 24 Aug 2004 00:32:13 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][1/7] xattr consolidation - libfs
In-Reply-To: <20040823194936.A20008@infradead.org>
Message-ID: <Xine.LNX.4.44.0408240026460.17851-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Christoph Hellwig wrote:

> Please don't do it this way.  By making the xattr handlers constant for
> a superblock's lifetime you can get rid of all the locking, and the arbitrary
> limit on the number of xattrs.

Then you can't dynamically regsiter an xattr handler (e.g. as a module).  
Is this really desirable?

> Also s/simple_// for most symbols as this stuff isn't simple, in fact it's
> quite complex :)

Removing the prefix would imply that this was the 'proper' way to
implement xattr support.  Really, these are just helper functions for the 
simplest xattr implementations.  I think they should have some prefix, but 
don't care too much what it actually is.  Suggestions?


- James
-- 
James Morris
<jmorris@redhat.com>



