Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbWKQQUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbWKQQUs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932943AbWKQQUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:20:48 -0500
Received: from pat.uio.no ([129.240.10.15]:24973 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932688AbWKQQUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:20:47 -0500
Subject: Re: NFSROOT with NFS Version 3
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061117164021.03b2cc24.Christoph.Pleger@uni-dortmund.de>
References: <20061117164021.03b2cc24.Christoph.Pleger@uni-dortmund.de>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 11:20:17 -0500
Message-Id: <1163780417.5709.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.305, required 12,
	autolearn=disabled, AWL 1.56, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 16:40 +0100, Christoph Pleger wrote:
> Hello,
> 
> I tried to switch an NFSROOT-Environment from NFS version 2 to NFS
> version 3, but unfortunately my test client machine now hangs every time
> after booting as soon as some bigger file system activity should occur.
> I tried Kernel 2.6.14.7 and Kernel 2.6.16.32.
> 
> The problem did not occur with NFS version 2.
> 
> Does anybody know the problem and/or a solution?

That is almost always due to the difference in r/wsize that the Linux
NFS server advertises for v2 and v3 combined with using UDP. If you have
poor networking, then don't use UDP, and certainly not with 32k r/wsize.

IOW: try either setting the mount options "rsize=8192,wsize=8192", or
the option "proto=tcp"

Cheers
  Trond

