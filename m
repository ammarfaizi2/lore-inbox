Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265893AbUGIVut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265893AbUGIVut (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUGIVut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:50:49 -0400
Received: from [213.146.154.40] ([213.146.154.40]:54961 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265893AbUGIVur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:50:47 -0400
Date: Fri, 9 Jul 2004 22:50:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modular filesystem using drop_inode would need inode_lock
Message-ID: <20040709215046.GA6681@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F019FB78F@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F019FB78F@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 02:43:32PM -0700, Luck, Tony wrote:
> This is mostly a logical inconsistency at the moment (since the
> only filesystem that has a "drop_inode" function defined in its
> super_operations is hugetlbfs, and it is unlikely to move out of
> the kernel and into a module).  But the ->drop_inode() function
> is called with inode_lock held, and it is expected to drop the
> lock ... which would be impossible for a module as the lock is
> not exported.

->drop_inode is a bad idea anyway.  Please send a pointer to your
filesystem so we can fix it.

