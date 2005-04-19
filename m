Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVDSE1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVDSE1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 00:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVDSE1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 00:27:36 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:2180 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261317AbVDSE1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 00:27:33 -0400
X-ORBL: [67.124.119.21]
Date: Mon, 18 Apr 2005 21:27:20 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Rik van Riel <riel@redhat.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050419042720.GA15123@taniwha.stupidest.org>
References: <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org> <42636285.9060405@lab.ntt.co.jp> <20050418075635.GB644@taniwha.stupidest.org> <20050418021609.07f6ec16.pj@sgi.com> <20050418092505.GA2206@taniwha.stupidest.org> <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com> <4263AD94.0@lab.ntt.co.jp> <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com> <42646983.4020908@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42646983.4020908@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 11:14:27AM +0900, Takashi Ikebe wrote:

> this makes software developer crazy....

are you serious?  how is live patching of .text easier than some of
the other suggestions which all are more or less sane and things like
gdb, oprofile, etc. will deal with w/o problems?

patching code in a running process is way complicated and messy,  if
you think this is the easier solution i guess i have little more to
say

> For me, is seems very dangerous to estimate the primary copy is not
> broken through status takeover..

that would also be a problem for live patching too, if you have bad
state, you have bad state --- live patching doesn't change that

> Some process use critical resources such as fixed network listen
> port can not speed up so.

hand the fd off to another process

> More importantly, the only process who prepare to use this mechanism
> only allows to use quick process takeover.

no, i can mmap state or similar, hand fd's off and switch to another
process in a context switch... hot patching i bet is going to be
slower

how about you show up some code that needs this?

> This cause software development difficult.

i honestly doubt in most cases you can hand live patch faster and more
easily than having the application sensibly written and passing it off

please, prove me wrong, show us some code

> The live patching does not require to implement such special
> techniques on applications.

this is like saying live patching is a complicated in-kernel solution
for badly written userspace isn't it?

