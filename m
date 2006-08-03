Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWHCGpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWHCGpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 02:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWHCGpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 02:45:23 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:33986 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932302AbWHCGpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 02:45:22 -0400
Date: Thu, 3 Aug 2006 02:44:49 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Chris Wedgewood <cw@foof.org>,
       jsipek@cs.sunysb.edu, Al Viro <viro@ftp.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC] [PATCH] Relative lazy atime
Message-ID: <20060803064449.GE27104@filer.fsl.cs.sunysb.edu>
References: <20060803062944.GA8631@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803062944.GA8631@goober>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 11:29:45PM -0700, Valerie Henson wrote:
> My friend Akkana followed my advice to use noatime on one of her
> machines, but discovered that mutt was unusable because it always
> thought that new messages had arrived since the last time it had
> checked a folder (mbox format).  I thought this was a bummer, so I
> wrote a "relative lazy atime" patch which only updates the atime if
> the old atime was less than the ctime or mtime.  This is not the same
> as the lazy atime patch of yore[1], which maintained a list of inodes
> with dirty atimes and wrote them out on unmount.
 
This also happens to be useful for file systems such as Unionfs and (from
what I hear) ocfs2 where atime updates can be costly at times.

> Patch below.  Current version (plus test program) is at:

Looks fine IMHO.

Josef "Jeff" Sipek.

-- 
I'm somewhere between geek and normal.
		- Linus Torvalds
