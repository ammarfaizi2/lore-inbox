Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752445AbWCPRld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbWCPRld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbWCPRld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:41:33 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:48388 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1752445AbWCPRlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:41:32 -0500
Date: Thu, 16 Mar 2006 18:41:12 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-ID: <20060316174112.GA21003@mars.ravnborg.org>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net> <20060316160129.GB6407@infradead.org> <20060316082951.58592fdc.rdunlap@xenotime.net> <20060316163001.GA7222@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316163001.GA7222@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 04:30:01PM +0000, Christoph Hellwig wrote:
 
> it makes the code longer and harder to read.  there's a reason the core
> code doesn't use it, and the periphal code should do the same.
Let see:
0 is an interger zero. It is not a null pointer.
1 is an interger one
NULL is an null pointer

We agree so far?

And you say:
0 is also false
1 is also true

But others say:
0 is not false, only false is false.
1 is not true, only true is true.
Thats more readable. No magic = 1; assignments or return 1; things.

Then we will have the case where a 1 is transformed to a true, and
likewise a 0 to a false. But thats just normal type conversion.

I assume that when you are not used to see 'bool', 'true' and 'false'
then they hurt the eye, but when used to it it looks natural.

	Sam
