Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265294AbUFYIaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbUFYIaN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 04:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266358AbUFYIaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 04:30:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:64214 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265294AbUFYIaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 04:30:10 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: RFC: Testing for kernel features in external modules
Date: Fri, 25 Jun 2004 10:32:22 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040624203043.GA4557@mars.ravnborg.org> <20040624203516.GV31203@schnapps.adilger.int>
In-Reply-To: <20040624203516.GV31203@schnapps.adilger.int>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200406251032.22797.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 June 2004 22:35, Andreas Dilger wrote:
> Ideally, when people make an incompatible kernel API change like this
> they would just #define HAVE_REMAP_PAGE_RANGE_VMA in the header that
> declares remap_page_range() directly (e.g. KERNEL_AS_O_DIRECT was added
> for this reason) instead of external builds having to figure this out
> themselves.  Adding the check script is no less work than just adding
> the #define to the appropriate header directly.

I disagree. I don't think we want to clutter the code with feature definitions 
that have no known users. That doesn't age/scale very well. It's easy enough 
to test for features in the external module.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG
