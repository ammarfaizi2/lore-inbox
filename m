Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWJMHaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWJMHaS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 03:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWJMHaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 03:30:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751253AbWJMHaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 03:30:17 -0400
Date: Fri, 13 Oct 2006 08:30:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Casey Dahlin <cjdahlin@ncsu.edu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Readability improvement of open_exec()
Message-ID: <20061013073010.GB13531@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Casey Dahlin <cjdahlin@ncsu.edu>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <1160707333.3230.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160707333.3230.14.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (err)
> +		goto out;
> +
> +	inode = nd.dentry->d_inode;
> +	file = ERR_PTR(-EACCES);
> +	if ((nd.mnt->mnt_flags & MNT_NOEXEC) ||
> +	    !S_ISREG(inode->i_mode))

While you're cleaning up things you can put the whole if statement on
one line, it's less than 80 characters long.

