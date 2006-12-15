Return-Path: <linux-kernel-owner+w=401wt.eu-S1753388AbWLOUM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbWLOUM7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbWLOUM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:12:59 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:41377 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbWLOUM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:12:58 -0500
X-Greylist: delayed 1084 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 15:12:58 EST
Date: Fri, 15 Dec 2006 14:53:41 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "TREVOR S. HIGHLAND" <tshighla@us.ibm.com>
Subject: Re: [PATCH] fsstack: Remove inode copy
Message-ID: <20061215195341.GA31868@filer.fsl.cs.sunysb.edu>
References: <20061215162428.GA3570@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215162428.GA3570@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2006 at 10:24:28AM -0600, Michael Halcrow wrote:
> The addition of copy_inode_size breaks eCryptfs, since eCryptfs needs
> to interpolate the file sizes (eCryptfs has extra space in the lower
> file for the header). The setting of the upper inode size occurs
> elsewhere in eCryptfs, and the new copy_attr_all now undoes what
> eCryptfs was doing right beforehand.
...
> I think the simplest solution, from eCryptfs' perspective, is to just
> remove the inode size copy. Jeff, please let me know if this approach
> will work for you, or let me know if you have another idea.
 
That's alright. fsstack is supposed to be as generic as possible. I think
that removing the inode size copy make it more generic.
 
> Remove inode size copy in general fsstack attr copy code. Stacked
> filesystems may need to interpolate the inode size, since the file
> size in the lower file may be different than the file size in the
> stacked layer.
> 
> Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>
Acked-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Josef "Jeff" Sipek.

-- 
Don't drink and derive. Alcohol and algebra don't mix.
