Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264807AbTE1RKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 13:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264809AbTE1RKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 13:10:53 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:5554 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S264807AbTE1RKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 13:10:51 -0400
Date: Wed, 28 May 2003 18:26:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: John M Collins <jmc@xisl.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about memory-mapped files
In-Reply-To: <3ED4E4BB.10806@xisl.com>
Message-ID: <Pine.LNX.4.44.0305281818230.1427-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003, John M Collins wrote:
> 
> If I invoke mmap to map a file to memory, and it succeeds, can I safely 
> close the original file descriptor and rely on the memory still being 
> mapped and the file still updated (possibly with mysnc)?

Yes, that's definitely a part of the specification of mmap,
even if it's not mentioned on the man page.

Note that the file on disk is likely not to be updated until
some time after you unmap it, unless you use msync to force it.

Hugh

