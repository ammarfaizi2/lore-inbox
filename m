Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTE2GCV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 02:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbTE2GCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 02:02:21 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:11129 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S261916AbTE2GCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 02:02:21 -0400
Date: Thu, 29 May 2003 07:17:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: John M Collins <jmc@xisl.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about memory-mapped files
In-Reply-To: <3ED50BE3.8090105@xisl.com>
Message-ID: <Pine.LNX.4.44.0305290703060.1317-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003, John M Collins wrote:
>
> Thanks - FYI the file mod time eventually got updated on HP-UX but not 
> on Solaris (2.9) or Linux (2.4.21) - and it doesn't seem to update it 
> even if you don't close the f.d. I think that has to be wrong if the 
> manual page is anything to go by.

I agree with you.  I hate files being modified without mtime changing,
and the mmap(2) man page is so surprisingly specific about those times
that I bet the text comes directly from one of the standards.

It's not something I'm rushing to fix; but I've made a note to
look at it later (days not hours) if nobody else gets there first.
It may turn out to be too difficult to get right - mmap and [amc]time
don't fit well together; but that text you've noticed at least gives
something to aim for - thanks.

Hugh

