Return-Path: <linux-kernel-owner+w=401wt.eu-S1425641AbWLHQ6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425641AbWLHQ6R (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425637AbWLHQ6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:58:17 -0500
Received: from [212.33.166.146] ([212.33.166.146]:32984 "EHLO
	localhost.localdomain" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1425644AbWLHQ6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:58:16 -0500
From: Al Boldi <a1426z@gawab.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: additional oom-killer tuneable worth submitting?
Date: Fri, 8 Dec 2006 19:59:04 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200612081658.29338.a1426z@gawab.com> <200612081819.43991.a1426z@gawab.com> <20061208155537.6f19b7e9@localhost.localdomain>
In-Reply-To: <20061208155537.6f19b7e9@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612081959.04515.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> > What I understood from Arjan is that the problem isn't swapspace, but
> > rather that shared-libs are implement via a COW trick, which always
> > overcommits, no matter what.
>
> The zero overcommit layer accounts address space not pages.

So OOM can still occur?

> > Are you saying there is some new no-overcommit functionality in 2.6.19,
> > or has this been there before?
>
> Red Hat Enterprise Linux for a very long time, got merged upstream a long
> long time ago to. Then got various fixes along the way. It's old
> functionality.

That's what I thought, but it's still really easy to OOM even with 
no-overcommit.

Using ulimit -v [total VMsize/runqueue] seems to inhibit this rather 
effectively, but needs to be maintained dynamically per process.

Couldn't this be handled by the kernel?


Thanks!

--
Al

