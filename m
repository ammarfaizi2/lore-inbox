Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWEHFY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWEHFY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWEHFY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:24:59 -0400
Received: from mail.gmx.de ([213.165.64.20]:24039 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932310AbWEHFY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:24:59 -0400
X-Authenticated: #14349625
Subject: Re: sched_clock() uses are broken
From: Mike Galbraith <efault@gmx.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@suse.de>, Christopher Friesen <cfriesen@nortel.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <445ECD10.1090506@yahoo.com.au>
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
	 <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com>
	 <200605021859.18948.ak@suse.de>  <445791D3.9060306@yahoo.com.au>
	 <1146640155.7526.27.camel@homer>  <445DE925.9010006@yahoo.com.au>
	 <1147023122.13315.16.camel@homer>  <1147061696.8544.12.camel@homer>
	 <1147063063.8809.7.camel@homer>  <445ECD10.1090506@yahoo.com.au>
Content-Type: text/plain
Date: Mon, 08 May 2006 07:24:59 +0200
Message-Id: <1147065899.8809.18.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 14:46 +1000, Nick Piggin wrote:
> It should either get ripped out, or perhaps converted to use jiffies
> until a sane high resolution, low overhead scheme is developed (if
> ever). And that would exclude something that does this accounting in
> fastpaths for the 99.99% of processes that never use it.

The accounting is really light compared to the interactivity part.  That
doesn't need to be in the fast path, and in my tree it isn't.

FWIW (0), yy tree is missing every last shred of the interactivity code,
and not missing it one bit.

[root@Homer]:> diffstat xx
 sched.c |  480
+++++++++++++++++++++++++++++-----------------------------------
 1 files changed, 219 insertions(+), 261 deletions(-)

And that's with full throttling, and absolute starvation proofing.

Ho hum.  Back to work on my never-going-anywhere-but-fun tree :)

	later,

	-Mike (shutting the hell up now;)

