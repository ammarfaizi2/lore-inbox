Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVK3Ord@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVK3Ord (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 09:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVK3Ord
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 09:47:33 -0500
Received: from pat.uio.no ([129.240.130.16]:36529 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751234AbVK3Orc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 09:47:32 -0500
Subject: Re: NFS cache consistancy appears to be broken...
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Steve Dickson <SteveD@redhat.com>
Cc: Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <438DB65D.8010306@RedHat.com>
References: <200510281607.j9SG7Tll024133@hera.kernel.org>
	 <438D0E80.2020905@RedHat.com> <1133334608.8010.9.camel@lade.trondhjem.org>
	 <438DB65D.8010306@RedHat.com>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 09:47:14 -0500
Message-Id: <1133362034.8625.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.938, required 12,
	autolearn=disabled, AWL 1.88, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-30 at 09:25 -0500, Steve Dickson wrote:

> It was the simple fact that nfsi->cache_change_attribute was not being 
> initialized to jiffies when the nfs inode was being allocated. This
> meant when nfs_revalidate_mapping() was called with the
> NFS_INO_INVALID_DATA bit was on, nfsi->cache_change_attribute
> was not being changed, it was actually being set!

That makes sense. Thanks!

Cheers,
  Trond

