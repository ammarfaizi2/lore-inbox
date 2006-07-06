Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWGFX5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWGFX5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWGFX5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:57:39 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:16000 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751080AbWGFX5i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:57:38 -0400
Date: Thu, 6 Jul 2006 16:56:25 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       "Scott J. Harmon" <harmon@ksu.edu>, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [stable] Re: Linux 2.6.17.4
Message-ID: <20060706235625.GI11588@sequoia.sous-sol.org>
References: <20060706222704.GB2946@kroah.com> <20060706222841.GD2946@kroah.com> <44AD9229.6010301@ksu.edu> <20060706224614.GA3520@suse.de> <20060706234918.GB2037@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706234918.GB2037@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Willy Tarreau (w@1wt.eu) wrote:
> Interestingly, 2.4 tests (arg2 !=0 && arg2 != 1) so from the code changes
> above, it looks like the value 2 was added on purpose, but for what ? Maybe
> the fix is not really correct yet ?

The old code was changed to support a new feature (suid_dumpable
for debugging).  The sysctl should support 2 (the new value), but the
prctl can be abused and hence reducing the test to one analgous to 2.4.
This is a correct fix.

thanks,
-chris
