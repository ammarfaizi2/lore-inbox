Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbVCJWCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbVCJWCF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVCJWCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:02:05 -0500
Received: from fmr23.intel.com ([143.183.121.15]:51357 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S263249AbVCJVm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:42:28 -0500
Message-Id: <200503102142.j2ALgCg04691@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: RE: Direct io on block device has performance regression on 2.6.x kernel
Date: Thu, 10 Mar 2005 13:42:12 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUlsBu5zKSIru/zRQq5kx1iRP/wfAACXY9A
In-Reply-To: <20050310123043.69e5fd48.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Thursday, March 10, 2005 12:31 PM
> >  > Fine-grained alignment is probably too hard, and it should fall back to
> >  > __blockdev_direct_IO().
> >  >
> >  > Does it do the right thing with a request which is non-page-aligned, but
> >  > 512-byte aligned?
> >  >
> >  > readv and writev?
> >  >
> >
> >  That's why direct_io_worker() is slower.  It does everything and handles
> >  every possible usage scenarios out there.  I hope making the function fatter
> >  is not in the plan.
>
> We just cannot make a change like this if it does not support readv and
> writev well, and if it does not support down-to-512-byte size and
> alignment.  It will break applications.

I must misread your mail.  Yes it does support 512-byte size and alignment.
Let me work on the readv/writev support (unless someone beat me to it).

- Ken


