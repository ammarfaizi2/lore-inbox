Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVDRJTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVDRJTK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 05:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVDRJSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 05:18:00 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:6791 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262012AbVDRJQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 05:16:38 -0400
Date: Mon, 18 Apr 2005 02:16:09 -0700
From: Paul Jackson <pj@sgi.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: ikebe.takashi@lab.ntt.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-Id: <20050418021609.07f6ec16.pj@sgi.com>
In-Reply-To: <20050418075635.GB644@taniwha.stupidest.org>
References: <4263275A.2020405@lab.ntt.co.jp>
	<20050418040718.GA31163@taniwha.stupidest.org>
	<4263356D.9080007@lab.ntt.co.jp>
	<20050418061221.GA32315@taniwha.stupidest.org>
	<42636285.9060405@lab.ntt.co.jp>
	<20050418075635.GB644@taniwha.stupidest.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris wrote:
> Linux doesn't guarantee you'll get scheduled
> (strictly speaking) in n milliseconds usually.

The general case load doesn't apply here.  Those doing call switching
know what they have running, and know that it won't give the scheduler
any opportunities to not run what must be run, in time.  Given a
sufficiently short run queue, the scheduler is quite predictable.

And there is difference between the entire system being down for over
100 milliseconds, and a given call being delayed that long.  Under
sufficient load (busiest hour on Mothers Day, say), the system must
continue to operate, though some switching may be delayed longer than
normal, though still within specified limits.

> > This function is very essential whenever ...
> 
> Those are just marketing words.
> ...
> I'm guessing any suggestion of fixing the applications behavior would
> be lost with some argument along the lines of ...

The call switching folks have been doing live patching at least since I
worked on it, over 25 years ago.  This is not just marketing.

No sense in being disrespectful to Takashi-san.  This patch may or
may not be the best way to provide the functionality they require.
I don't even know if a kernel patch is needed.

But the tone of this thread won't lead anyone to better answers
anytime soon.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
