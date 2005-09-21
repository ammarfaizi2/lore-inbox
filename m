Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbVIUOrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbVIUOrG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 10:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbVIUOrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 10:47:06 -0400
Received: from agminet03.oracle.com ([141.146.126.230]:6054 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S1750999AbVIUOrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 10:47:04 -0400
Date: Wed, 21 Sep 2005 07:45:38 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       John McCutchan <ttb@tentacle.dhs.org>,
       Linus Torvalds <torvalds@osdl.org>, Ray Lee <ray@madrabbit.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, ocfs2-devel@oss.oracle.com
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050921144538.GI26425@ca-server1.us.oracle.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	John McCutchan <ttb@tentacle.dhs.org>,
	Linus Torvalds <torvalds@osdl.org>, Ray Lee <ray@madrabbit.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Robert Love <rml@novell.com>, ocfs2-devel@oss.oracle.com
References: <Pine.LNX.4.58.0509201108120.2553@g5.osdl.org> <20050920182249.GP7992@ftp.linux.org.uk> <Pine.LNX.4.58.0509201234560.2553@g5.osdl.org> <1127256814.749.5.camel@vertex> <20050921010154.GR7992@ftp.linux.org.uk> <1127266907.3950.5.camel@vertex> <20050921023601.GT7992@ftp.linux.org.uk> <20050921083525.GB27254@infradead.org> <20050921091524.GG26425@ca-server1.us.oracle.com> <20050921091738.GA28289@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921091738.GA28289@infradead.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 10:17:38AM +0100, Christoph Hellwig wrote:
> The real fix would be to put an equivalent of OCFS2_INODE_MAYBE_ORPHANED
> into struct inode.  That way it could be shared by other clustered
> filesystems aswell, and OCFS2 had no need to implement ->drop_inode.

	Or change the VFS patterns to allow lookup and validation of the
inode before choosing the generic_drop/generic_delete path.

Joel

-- 

Life's Little Instruction Book #197

	"Don't forget, a person's greatest emotional need is to 
	 feel appreciated."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
