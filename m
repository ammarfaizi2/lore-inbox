Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTICLPI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 07:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTICLPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 07:15:08 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:54728 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261904AbTICLPF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 07:15:05 -0400
Date: Wed, 3 Sep 2003 04:14:52 -0700
From: Larry McVoy <lm@bitmover.com>
To: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       lm@bitmover.com
Subject: Re: Scaling noise
Message-ID: <20030903111452.GE10257@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
	lm@bitmover.com
References: <200309030710.h837AXnR000500@81-2-122-30.bradfords.org.uk> <20030903073858.GB15765@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903073858.GB15765@matchmail.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 12:38:58AM -0700, Mike Fedyk wrote:
> On Wed, Sep 03, 2003 at 08:10:33AM +0100, John Bradford wrote:
> > boxes, but no Linux image will run on more than $smallnum virtual
> > CPUs.
> 
> Which is exactly what Larry is advocating.  Essencially, instead of having
> one large image covering a large NUMA box, you have several images covering
> each NUMA node (even if they're in the same box).

Right, that is indeed what I believe needs to happen.  Instead of spreading
one kernel out over all the processors, run multiple kernels.  Most of the
scaling problems go away.  Not all if you want to share memory between 
kernels but for what John was talking about that is not even needed.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
