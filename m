Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269127AbUJWDFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269127AbUJWDFT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269291AbUJWDDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 23:03:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35218 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269318AbUJWCui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 22:50:38 -0400
Date: Fri, 22 Oct 2004 19:50:23 -0700
Message-Id: <200410230250.i9N2oNHG012924@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: joe.korty@ccur.com
X-Fcc: ~/Mail/linus
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] posix timers using == instead of & for bitmask tests
In-Reply-To: Joe Korty's message of  Friday, 22 October 2004 22:27:19 -0400 <20041023022719.GA26057@tsunami.ccur.com>
Emacs: because one operating system isn't enough.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Thanks for answering my mistaken impressions.  I saw after I wrote that
> SIGEV_SIGNAL == 0 which makes everything work.  And I was laboring under
> the misconception that SIGEV_SIGNAL and SIGEV_THREAD were mutually exclusive
> which isn't true, one always has SIGEV_SIGNAL if SIGEV_THREAD is set.

In the semantic sense they are mutually exclusive.  They are not so in the
bitwise sense, because the value is really not a bitmask overall, only the
SIGEV_THREAD_ID bit is used that way.


Thanks,
Roland
