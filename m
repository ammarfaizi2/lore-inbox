Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVGLDYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVGLDYm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 23:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVGLDYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 23:24:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:20659 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262213AbVGLDYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:24:40 -0400
Date: Mon, 11 Jul 2005 20:24:24 -0700
From: Greg KH <greg@kroah.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
Message-ID: <20050712032424.GA1742@kroah.com>
References: <17107.6290.734560.231978@tut.ibm.com> <20050712030555.GA1487@kroah.com> <42D3331F.8020705@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D3331F.8020705@opersys.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 11:03:59PM -0400, Karim Yaghmour wrote:
> 
> Greg KH wrote:
> > What ever happened to exporting the relayfs file ops, and just using
> > debugfs as your controlling fs instead?  As all of the possible users
> > fall under the "debug" type of kernel feature, it makes more sense to
> > confine users to that fs, right?
> 
> Actually, like we discussed the last time this surfaced, there are far
> more users for relayfs than just debugging.

Based on the proposed users of this fs, I don't see any.  What ones are
you saying are not "debug" type operations?  And yes, I consider LTT a
"debug" type operation :)

The best part of this, is it gives distros and users a consistant place
to mount the fs, and to know where this kind of thing shows up in the fs
namespace.

> What we settled on was having relayfs export its file ops so that
> indeed debugfs users could use it to log things in conjunction with
> debugfs.

Last I looked, this was not possible.  Has this changed in the latest
version?

thanks,

greg k-h
