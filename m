Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbVKCQxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbVKCQxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVKCQxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:53:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57748 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030349AbVKCQxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:53:13 -0500
Date: Thu, 3 Nov 2005 16:53:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, Zach Brown <zach.brown@oracle.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, mark.fasheh@oracle.com
Subject: Re: [Patch] add AOP_TRUNCATED_PAGE, prepend AOP_ to WRITEPAGE_ACTIVATE
Message-ID: <20051103165306.GA4923@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Zach Brown <zach.brown@oracle.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mark.fasheh@oracle.com
References: <43667913.4030401@oracle.com> <20051103124536.0191bea6.akpm@osdl.org> <20051103074312.GQ11488@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103074312.GQ11488@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 11:43:12PM -0800, Joel Becker wrote:
> > Looks sane to me.   Can you carry this in the ocfs2 tree?
> 
> 	No problem.  Give us a day or two to merge the changes to our
> main trees.

I think I disagree with Andew here.  Having a core patch separate
from a new drivers/filesystem/etc.. is always a good idea.  It makes
reviewing a lot easier and allows independant handling, e.g. merging it
earlier than the new driver for some reason - as happened for example
with the clear_inode changes we needed earlier for ocfs or the pagevec
exports that came in via the reiser4 patches but were needed in mainline
for cifs now.

