Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVALPH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVALPH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVALPH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:07:29 -0500
Received: from p508B74BF.dip.t-dialin.net ([80.139.116.191]:852 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261211AbVALPHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:07:22 -0500
Date: Wed, 12 Jan 2005 16:07:13 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Re: flush_cache_page()
Message-ID: <20050112150713.GA21847@linux-mips.org>
References: <20050111223652.D30946@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111223652.D30946@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 10:36:52PM +0000, Russell King wrote:

> Any responses on this?  Didn't get any last time I mailed this out.
> 
> I guess we're now at a point where we can start considering whether
> to merge this or not.
> 
> However, since it's been rather a long time, I will need to go
> back and redo this patch, along with all the other patches which
> get ARMv6 VIPT aliasing caches working, and then confirm that this
> does indeed end up with something which works.
> 
> I just don't want to go chasing my tail on something which essentially
> is unacceptable.

It would help for the MIPS VIPT caches also; the underlying issues are
the same.  As a longstanding bug we're walking pagetables always praying
the caller is holding the lock ...

  Ralf
