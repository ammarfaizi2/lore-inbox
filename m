Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbTEURZO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 13:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbTEURZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 13:25:14 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:28934 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262211AbTEURZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 13:25:13 -0400
Date: Wed, 21 May 2003 18:38:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ross Biro <rossb@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch FIOFLUSH
Message-ID: <20030521183814.A1291@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ross Biro <rossb@google.com>, linux-kernel@vger.kernel.org
References: <3ECBB723.7070707@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3ECBB723.7070707@google.com>; from rossb@google.com on Wed, May 21, 2003 at 10:28:03AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 10:28:03AM -0700, Ross Biro wrote:
> 
> Here's a patch against 2.4.18 that allows user space to flush a file 
> from both the buffer cache and the page cache.  The reason for flushing 
> a file from the caches is to the read the file again to verify it made 
> it to more permanent storage correctly.  Someone may want to add 
> similiar code to 2.5.

This came up at SGI some time ago and the right solution is _not_ a new
ioctl but fadvise(..., POSIX_FADV_DONTNEED).   I'll submit a clean backport
once 2.4.21 is out (if that will ever happen)

