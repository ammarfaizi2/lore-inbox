Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292843AbSCDUgp>; Mon, 4 Mar 2002 15:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292738AbSCDUgf>; Mon, 4 Mar 2002 15:36:35 -0500
Received: from ns.caldera.de ([212.34.180.1]:16329 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S292843AbSCDUg1>;
	Mon, 4 Mar 2002 15:36:27 -0500
Date: Mon, 4 Mar 2002 21:35:22 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Robert Love <rml@tech9.net>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Ed Tomlinson <tomlins@cam.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] radix-tree pagecache for 2.4.19-pre2-ac2
Message-ID: <20020304213522.A318@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Robert Love <rml@tech9.net>, Mike Fedyk <mfedyk@matchmail.com>,
	Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
In-Reply-To: <20020303210346.A8329@caldera.de> <20020304045557.C1010BA9E@oscar.casa.dyndns.org> <20020304051310.GC1459@matchmail.com> <1015273914.15479.127.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1015273914.15479.127.camel@phantasy>; from rml@tech9.net on Mon, Mar 04, 2002 at 03:31:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 03:31:52PM -0500, Robert Love wrote:
> On Mon, 2002-03-04 at 00:13, Mike Fedyk wrote:
> 
> > On Sun, Mar 03, 2002 at 11:55:57PM -0500, Ed Tomlinson wrote:
> >
> > > Got this after a couple of hours with pre2-ac2+preempth+radixtree. 
> > 
> > Can you try again without preempt?
> 
> I've had success with the patch on 2.4.18+preempt and 2.5.5, so I
> suspect preemption is not a problem.  I also did not see any
> preempt_schedules in his backtrace ...

I can repdoduce it locally here.  IT looks like we leak a pgae with
incorrect flags in an error path.  Still investigating it.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
