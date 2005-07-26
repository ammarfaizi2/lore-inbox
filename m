Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVGZUiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVGZUiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVGZUhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:37:34 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:52451 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261912AbVGZUhR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:37:17 -0400
Subject: Re: Memory pressure handling with iSCSI
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20050726121250.0ba7d744.akpm@osdl.org>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	 <20050726111110.6b9db241.akpm@osdl.org>
	 <1122403152.6433.39.camel@dyn9047017102.beaverton.ibm.com>
	 <20050726114824.136d3dad.akpm@osdl.org>
	 <20050726121250.0ba7d744.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 13:36:56 -0700
Message-Id: <1122410216.6433.41.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 12:12 -0700, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Can you please reduce the number of filesystems, see if that reduces the
> >  dirty levels?
> 
> Also, it's conceivable that ext3 is implicated here, so it might be saner
> to perform initial investigation on ext2.
> 
> (when kjournald writes back a page via its buffers, the page remains
> "dirty" as far as the VFS is concerned.  Later, someone tries to do a
> writepage() on it and we'll discover the buffers' cleanness and the page
> will be cleaned without any I/O being performed.  All the throttling
> _should_ work OK in this case.  But ext2 is more straightforward.)

I will try ext2 next.

- Badari

