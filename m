Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966227AbWKTRfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966227AbWKTRfF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966257AbWKTRfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:35:05 -0500
Received: from pat.uio.no ([129.240.10.15]:30187 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S966227AbWKTRfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:35:03 -0500
Subject: Re: NFSROOT with NFS Version 3
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061120173311.154e54a6.Christoph.Pleger@uni-dortmund.de>
References: <20061117164021.03b2cc24.Christoph.Pleger@uni-dortmund.de>
	 <1163780417.5709.34.camel@lade.trondhjem.org>
	 <20061120120750.1b1688e8.Christoph.Pleger@uni-dortmund.de>
	 <20061120135716.GA14122@tsunami.ccur.com>
	 <20061120173311.154e54a6.Christoph.Pleger@uni-dortmund.de>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 12:34:40 -0500
Message-Id: <1164044080.5700.61.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.202, required 12,
	autolearn=disabled, AWL 1.66, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 17:33 +0100, Christoph Pleger wrote:
> Hello,
> 
> On Mon, 20 Nov 2006 08:57:16 -0500
> Joe Korty <joe.korty@ccur.com> wrote:
> 
> > On Mon, Nov 20, 2006 at 12:07:50PM +0100, Christoph Pleger wrote:
> > > Warning: Unable to open an initial console
> > 
> > This usually means /dev/console doesn't exist.  With many of
> > today's distributions, this means you didn't boot with a
> > initrd properly set up to run with your newly built kernel.
> 
> The device /dev/console exists, but init/main.c tries to open it
> read-write. As the nfsroot is mounted read-only, /dev/console cannot be
> opened read-write.

Yes. NFSv3 has an ACCESS rpc call, which allows the client to request
the correct permissions from the server rather than relying on mode
bits.
IOW: this is definitely an intentional feature.

Cheers,
  Trond

