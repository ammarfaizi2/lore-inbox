Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264164AbUD0PSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbUD0PSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 11:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbUD0PSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 11:18:12 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:18948 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S264164AbUD0PSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 11:18:11 -0400
Date: Tue, 27 Apr 2004 11:18:03 -0400
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/11] nfsacl
Message-ID: <20040427151802.GA1490@fieldses.org>
References: <1082975143.3295.68.camel@winden.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082975143.3295.68.camel@winden.suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 12:28:47PM +0200, Andreas Gruenbacher wrote:
> nfsacl-lazy-alloc
>    Allow to allocate pages in the receive buffers lazily. ACLs may have
>    up to 1024 entries in nfsacl but usually are small, so allocating
>    space for them on demand makes sense.

Is there any reason we couldn't set the maximum smaller than that?  It
looks like the acl entries are pretty compact (12 bytes if I'm reading
the xdr code right?) so if we limited the length of an xdr-encoded acl
to a page that would still allow a few hundred entries.  Are there
really people that need 1000-entry acls?

--Bruce Fields
