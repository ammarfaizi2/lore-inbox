Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268982AbUIXQo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268982AbUIXQo7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268950AbUIXQm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:42:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29643 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268896AbUIXQkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:40:05 -0400
Date: Fri, 24 Sep 2004 12:39:23 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andreas Gruenbacher <agruen@suse.de>
cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] xattr consolidation v3
In-Reply-To: <1095945983.27603.9.camel@winden.suse.de>
Message-ID: <Xine.LNX.4.44.0409241237560.8101-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004, Andreas Gruenbacher wrote:

> There is one minor issue in the ext[23]_xattr_list changes: The xattr
> block gets inserted into the cache even if it later turns out to be
> corrupted. The attached patch reintroduces the sanity check, and has a
> few other cosmetical-only changes.
> 
> Andrew, do you want to add this to -mm?

These 'cosmetical-only' changes break listxattr on ext3 and ext2.  Andrew, 
please drop this patch.

Moving the mb cache insertion point can be done separately.


- James
-- 
James Morris
<jmorris@redhat.com>


