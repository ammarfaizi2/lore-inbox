Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVF0Tq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVF0Tq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVF0Tqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:46:42 -0400
Received: from agminet03.oracle.com ([141.146.126.230]:8231 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S261449AbVF0Tpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:45:38 -0400
Date: Mon, 27 Jun 2005 12:44:02 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050627194402.GK31165@ca-server1.us.oracle.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org> <20050627090640.GA5410@infradead.org> <1119882343.4256.358.camel@tribesman.namesys.com> <20050627192651.GB21932@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627192651.GB21932@infradead.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 08:26:51PM +0100, Christoph Hellwig wrote:
> drop_inode is not going to die, we need it to support filesystems that
> want to call generic_delete_inode even for a non-null i_nlink.  What's
> hopefully going to die is the last instance of it that isn't either
> generic_drop_inode or generic_delete_inode.

	OCFS2 uses drop_inode as well, as it must handle last-close when
another node did the unlink.  It fixes up i_nlink in that case, then
calls generic_drop_inode().
	If there's a more elegant solution, we're all ears.

Joel

-- 

"When choosing between two evils, I always like to try the one
 I've never tried before."
        - Mae West

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
