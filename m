Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbUCOSY0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbUCOSY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:24:26 -0500
Received: from gprs40-162.eurotel.cz ([160.218.40.162]:20181 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262661AbUCOSYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:24:21 -0500
Date: Mon, 15 Mar 2004 19:24:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Cress, Andrew R" <andrew.r.cress@intel.com>
Cc: "Yury V. Umanets" <umka@namesys.com>, "Guo, Min" <min.guo@intel.com>,
       Tvrtko =?utf-8?B?QS4gVXLFoXVsaW4=?= <tvrtko@croadria.com>,
       linux-kernel@vger.kernel.org, cgl_discussion@lists.osdl.org
Subject: Re: [cgl_discussion] Re: About Replaceable OOM Killer
Message-ID: <20040315182406.GA258@elf.ucw.cz>
References: <E5DA6395B8F9614EB7A784D628184B200E34E8@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E5DA6395B8F9614EB7A784D628184B200E34E8@hdsmsx402.hd.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Right, once it is really OOM, you are SOL :-)  Really the only thing you can do at this point in the kernel is to not allocate any more memory, and functions that require more memory just don't work, and the recovery is to reboot..
> 
> IMO, the best answer is to detect a nearly-OOM, or trending-toward-OOM condition before it gets so bad.
> This would allow userland actions, but would require more customization to tune the detection criteria, which would also imply a userland implementation of the monitoring.  We've found that PCP works pretty well for this type of thing.
> See http://oss.sgi.com/projects/pcp/ and http://pcp4cgl.sourceforge.net/.  We did some work with this for CGL 1.0.
> 

Well, I see that as orthogonal.

With right daemon you may prevent OOM in most situations. Kernel still
needs some OOM killer for cases where faileure was just too fast, but
it can now be simpler (and that's good).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
