Return-Path: <linux-kernel-owner+w=401wt.eu-S1425537AbWLHPS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425537AbWLHPS6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425542AbWLHPS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:18:58 -0500
Received: from [212.33.164.29] ([212.33.164.29]:32946 "EHLO
	localhost.localdomain" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1425537AbWLHPS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:18:57 -0500
From: Al Boldi <a1426z@gawab.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: additional oom-killer tuneable worth submitting?
Date: Fri, 8 Dec 2006 18:19:43 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200612081658.29338.a1426z@gawab.com> <20061208145605.1a8b0815@localhost.localdomain>
In-Reply-To: <20061208145605.1a8b0815@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612081819.43991.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> Al Boldi <a1426z@gawab.com> wrote:
> > > That is why we have no-overcommit support.
> >
> > Alan, I think you know that this isn't really true, due to shared-libs.
>
> Shared libraries are correctly handled by no-overcommit and in fact they
> have almost zero impact on out of memory questions because the shared
> parts of the library are file backed and constant. That means they don't
> actually cost swap space.

What I understood from Arjan is that the problem isn't swapspace, but rather 
that shared-libs are implement via a COW trick, which always overcommits, no 
matter what.

> > > Now there is an argument for
> > > a meaningful rlimit-as to go with it, and together I think they do
> > > what you really need.
> >
> > The problem with rlimit is that it works per process.  Tuning this by
> > hand may be awkward and/or wasteful.  What we need is to rlimit on a
> > global basis, by calculating an upperlimit dynamically, such as to avoid
> > overcommit/OOM.
>
> You've just described the existing no overcommit functionality, although
> you've forgotten to allow for pre-reserving of stacks and some other
> detail that has been found to make it work better as it has been refined.

Are you saying there is some new no-overcommit functionality in 2.6.19, or 
has this been there before?


Thanks!

--
Al

