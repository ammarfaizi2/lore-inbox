Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUGIWGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUGIWGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 18:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265985AbUGIWGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 18:06:47 -0400
Received: from [213.146.154.40] ([213.146.154.40]:64689 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265971AbUGIWGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 18:06:45 -0400
Date: Fri, 9 Jul 2004 23:06:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modular filesystem using drop_inode would need inode_lock
Message-ID: <20040709220644.GA6945@infradead.org>
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

And btw, ->drop_inode usage in hugetlbfs is also a really bad idea,
it's duplicating large parts of fs/inode.c and is already missing
all kinds of updates.

