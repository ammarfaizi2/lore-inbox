Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbUJYP2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbUJYP2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbUJYP2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:28:30 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:61452 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261954AbUJYPZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:25:22 -0400
Date: Mon, 25 Oct 2004 16:25:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Waychison <michael.waychison@sun.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Subject: Re: [PATCH 13/28] VFS: Introduce soft reference counts
Message-ID: <20041025152521.GA1959@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Waychison <michael.waychison@sun.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	raven@themaw.net
References: <10987154731896@sun.com> <10987155032816@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10987155032816@sun.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:45:03AM -0400, Mike Waychison wrote:
> This patch introduces the concept of a 'soft' reference count for a vfsmount.
> This type of reference count allows for references to be held on mountpoints
> that do not affect their busy states for userland unmounting.  Some might
> argue that this is wrong because 'when I unmount a filesystem, I want the
> resources associated with it to go away too', but this way of thinking was
> deprecated with the addition of namespaces and --bind back in the 2.4 series.
> 
> A future addition may see a callback mechanism so that in kernel users can
> use a given mountpoint and have it deregistered some way (quota and
> accounting come to mind).
> 
> These soft reference counts are used by a later patch that adds an interface
> for holding and manipulating mountpoints using filedescriptors.

You haven't explained why you actually need it, though.

