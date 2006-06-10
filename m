Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWFJKWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWFJKWM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 06:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWFJKWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 06:22:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53445 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751472AbWFJKWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 06:22:12 -0400
Date: Sat, 10 Jun 2006 11:22:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 -mm merge plans
Message-ID: <20060610102211.GE20526@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060604135011.decdc7c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ecryptfs-crypto-functions.patch
> ecryptfs-debug-functions.patch
> ecryptfs-alpha-build-fix.patch
> ecryptfs-convert-assert-to-bug_on.patch
> ecryptfs-remove-unnecessary-null-checks.patch
> ecryptfs-rewrite-ecryptfs_fsync.patch
> ecryptfs-overhaul-file-locking.patch
> 
>  Christoph has half-reviewed this and all the issues arising from that
>  have, I believe, been addressed.  With the exception of the "we should
>  have a generic stacking layer" issue.  Which is true.  Michael's take is
>  "yes, but that's not my job".  Which also is true.

It's far from ready.  There's various things that simply can't be done
properly in a lowlevel fs or abosulutely shouldn't.  And I think a few
uniqueue gems in there.   Most urgent thing of course is that we somehow
need to deal with the idiocy of the nameidata passed into most namespace
methods.

