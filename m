Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVGXXJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVGXXJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 19:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVGXXJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 19:09:26 -0400
Received: from pat.uio.no ([129.240.130.16]:61103 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261295AbVGXXJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 19:09:24 -0400
Subject: Re: [PATCH NFS 3/3] Replace nfs_block_bits() with
	roundup_pow_of_two()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050724143640.GA19941@lsrfire.ath.cx>
References: <20050724143640.GA19941@lsrfire.ath.cx>
Content-Type: text/plain
Date: Sun, 24 Jul 2005 19:09:09 -0400
Message-Id: <1122246549.8322.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.406, required 12,
	autolearn=disabled, AWL 2.41, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

su den 24.07.2005 Klokka 16:36 (+0200) skreiv Rene Scharfe:
> [PATCH NFS 3/3] Replace nfs_block_bits() with roundup_pow_of_two()
> 
> Function nfs_block_bits() an open-coded version of (the non-existing)
> rounddown_pow_of_two().  That means that for non-power-of-two target
> sizes it returns half the size needed for a block to fully contain
> the target.  I guess this is wrong. :-)  The patch uses the built-in
> roundup_pow_of_two() instead.

What non-power-of-two target? Anything _not_ aligned to a power of two
boundary is a BUG!

Cheers,
  Trond

