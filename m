Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbTEAOtW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbTEAOtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:49:22 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:58259 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261350AbTEAOtU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:49:20 -0400
Date: Thu, 1 May 2003 08:01:10 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Willy TARREAU <willy@w.ods.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel source tree splitting
Message-ID: <20030501150110.GA13282@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Willy TARREAU <willy@w.ods.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200305010756_MC3-1-36E1-623@compuserve.com> <11850000.1051797996@[10.10.2.4]> <20030501142041.GD308@pcw.home.local> <13900000.1051799746@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13900000.1051799746@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 07:35:48AM -0700, Martin J. Bligh wrote:
> just chmod, and I have a lot of views ... 1689 all linked together ;-)
> 
> -r--r--r--  1689 fletch   fletch      18691 Nov 17 20:29 COPYING

That's a bunch.  Who's fletch?  

And more importantly, how do you keep track of what is in each of those?
I can see having 20, 100, whatever, and keeping it straight in your head
but 1600?  

> Oh, and diff of views takes < 1s (diff understands hardlinks too, it seems).
> Any SCM can kiss my ass ;-)

Kiss, kiss :)

Ted T'so made us support hard links for the revision control files for the
same reasons and it works pretty well.  We haven't extended that to the
checked out files because I'm nervous about tools which don't break the
links.

On the other hand, we could hard link the checked out files if they
were checked out read-only which mimics what you are doing with the
chmod...  That's a thought.

We'll still never be as fast as a pure hardlinked tree, that's balls to
the wall as fast as you can go as far as I can tell.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
