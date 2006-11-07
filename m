Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753775AbWKGAEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbWKGAEF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 19:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753849AbWKGAEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 19:04:05 -0500
Received: from pop-sarus.atl.sa.earthlink.net ([207.69.195.72]:50664 "EHLO
	pop-sarus.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1753775AbWKGAED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 19:04:03 -0500
Date: Mon, 6 Nov 2006 19:03:59 -0500 (EST)
From: Brent Baccala <cosine@freesoft.org>
X-X-Sender: baccala@debian.freesoft.org
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: async I/O seems to be blocking on 2.6.15
Message-ID: <Pine.LNX.4.64.0611061903220.27775@debian.freesoft.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2006, Chen, Kenneth W wrote:

> I've tried that myself too and see similar result.  One thing to note is
> that I/O being submitted are pretty big at 1MB, so the vector list inside
> bio is going to be pretty long and it will take a while to construct that.
> Drop the size for each I/O to something like 4KB will significantly reduce
> the time.  I haven't done the measurement whether the time to submit I/O
> grows linearly with respect to I/O size.  Most likely it will.  If it is
> not, then we might have a scaling problem (though I don't believe we have
> this problem).
> 
> - Ken
> 
>

I'm basically an end user here (as far as the kernel is concerned), so
let me ask the basic "dumb user" question here:

How should I do my async I/O if I just want to read or write
sequentially through a file, using O_DIRECT, and letting the CPU get
some work done in the meantime?  What about more random access?

I've already concluded that I should try to keep my read and write
files on seperate disks and hopefully on seperate controllers, but I
still seem to be fighting this thing to keep it from blocking.


 					-bwb

 					Brent Baccala
 					cosine@freesoft.org
