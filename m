Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263025AbVAFUSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbVAFUSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVAFUQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:16:01 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:41408 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263026AbVAFUHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:07:55 -0500
Date: Thu, 6 Jan 2005 12:07:38 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk, greghk@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050106200738.GG1292@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <20050106191355.GA23345@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106191355.GA23345@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 07:13:55PM +0000, Christoph Hellwig wrote:
> On Thu, Jan 06, 2005 at 11:05:38AM -0800, Paul E. McKenney wrote:
> > Hello, Andrew,
> > 
> > Some export-removal work causes breakage for an out-of-tree filesystem.
> > Could you please apply the attached patch to restore the exports for
> > files_lock and set_fs_root?
> 
> What out of tree filesystem, and what the heck is it doing?

MVFS, as was correctly guessed from my diff.  It is providing a view into
a source-code control system, so that a given process can specify the
version it wishes to see.  Yes, different processes then see a different
filesystem tree at the same mount point.

> Without proper explanation it's vetoed.

What additional explanation are you looking for?

> btw, any reason you put half the world in the Cc list?  Al and Andrew I
> see, but do the other people on the Cc list have to do with it?  And you
> forgot the person that killed the export.

I figured that there was no way that you would miss it, so there was no
point in adding to an already overly long CC line.  ;-)

							Thanx, Paul
