Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263034AbVAFUSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263034AbVAFUSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbVAFUQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:16:37 -0500
Received: from [213.146.154.40] ([213.146.154.40]:2733 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263025AbVAFUNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:13:08 -0500
Date: Thu, 6 Jan 2005 20:13:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, greghk@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050106201303.GA24321@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk, greghk@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <20050106191355.GA23345@infradead.org> <20050106200738.GG1292@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106200738.GG1292@us.ibm.com>
User-Agent: Mutt/1.4.1i
uCc: akpm@osdl.org, linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 12:07:38PM -0800, Paul E. McKenney wrote:
> > What out of tree filesystem, and what the heck is it doing?
> 
> MVFS, as was correctly guessed from my diff.  It is providing a view into
> a source-code control system, so that a given process can specify the
> version it wishes to see.  Yes, different processes then see a different
> filesystem tree at the same mount point.

We have that in the VFS as namespace and it has no business in a filesystem
driver.  And we have been telling this for more than a year.

> > Without proper explanation it's vetoed.
> 
> What additional explanation are you looking for?

The explanation is so good that we can veto that patch with a reason,
as it should really be obvious to you an anyone involved.

