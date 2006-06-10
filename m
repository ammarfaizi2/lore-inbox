Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWFJMNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWFJMNU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 08:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWFJMNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 08:13:20 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:10714 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1751498AbWFJMNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 08:13:19 -0400
Date: Sat, 10 Jun 2006 06:13:18 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: How long can an inode structure reside in the inode_cache?
Message-ID: <20060610121318.GQ1651@parisc-linux.org>
References: <4ae3c140606091710k7a320f2ex6390d0e01da4de9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140606091710k7a320f2ex6390d0e01da4de9b@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 08:10:10PM -0400, Xin Zhao wrote:
> I was wondering how Linux decide to free an inode from the
> inode_cache? If a file is open, an inode structure will be created and
> put into the inode_cache, but when will this inode be free and removed
> from the inode_cache? after this file is closed? If so, this seems to
> be inefficient.

how can you possibly release an inode while the file's still open?
look at all the information stored in the inode, like the length of the
file, last accessed time, not to mention which filesystem the inode
belongs to.
