Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVDSFxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVDSFxN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 01:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVDSFxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 01:53:13 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:19679 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261330AbVDSFxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 01:53:08 -0400
Date: Mon, 18 Apr 2005 22:52:54 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Rik van Riel <riel@redhat.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050419055254.GA15895@taniwha.stupidest.org>
References: <42636285.9060405@lab.ntt.co.jp> <20050418075635.GB644@taniwha.stupidest.org> <20050418021609.07f6ec16.pj@sgi.com> <20050418092505.GA2206@taniwha.stupidest.org> <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com> <4263AD94.0@lab.ntt.co.jp> <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com> <42646983.4020908@lab.ntt.co.jp> <20050419042720.GA15123@taniwha.stupidest.org> <426494FD.6020307@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426494FD.6020307@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 02:19:57PM +0900, Takashi Ikebe wrote:

> What I want to say is takeover may makes memory unstable, because
> there are extra operations to reserve current (unstable) status to
> memory.

mmap is coherent between processes

> Live patching never force target process to reserve status to memory. Is
> this make sense?

Not really.  I don't see how it makes it any better or easier, just
different.

> I think the point is how long does it takes to hand the fd off to
> another process. (means how long time the network port is
> unavailable??)

Probably under 1 ms.  Not long anyhow.

> Please see and try http://pannus.sourceforge.net

> There includes commands and some samples.

pannus-sample.tgz contains some pretty contrived examples,  nothing
that anyone could really sensibly comment on

> On live patching, you never need to use shared memory, just prepare
> fixed code, and just compile it as shared ibject, that's all. pretty
> easy and fast to replace the functions.

it requires magic like a compiler and knowledge of the original
application.

if the application was written sensibly someone without access to the
application code could change this live taking over the previous
applications state even more easily --- and the code would be more
straightforward.  so i still fail to see why this is needed.
