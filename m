Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWCSWtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWCSWtk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 17:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWCSWtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 17:49:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:23204 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751163AbWCSWtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 17:49:39 -0500
Date: Mon, 20 Mar 2006 09:49:12 +1100
From: Nathan Scott <nathans@sgi.com>
To: Claudio Martins <ctpm@ist.utl.pt>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6: known regressions (v2)
Message-ID: <20060320094912.F569384@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <20060317143642.GJ3914@stusta.de> <200603182057.10171.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200603182057.10171.ctpm@ist.utl.pt>; from ctpm@ist.utl.pt on Sat, Mar 18, 2006 at 08:57:09PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 08:57:09PM +0000, Claudio Martins wrote:
>   Hi Adrian, Nathan and all,
> 
>  If think I might have hit this one! 

OK - any hints that might lead us toward a test case?

> I managed to get an oops which showed xfs related functions on the backtrace. 
> The process involved was "rm" and the specific stress test was some 32 
> paralell kernel builds (each one with "make -j8") on a quad Opteron box with 
> a 1 TB xfs filesystem. Preemption was disabled.

>  After that the machine was still alive, but an fsck.xfs after a reboot showed 
> corruption that I was able to repair with xfs_repair. This was also with an 

Hmm, fsck.xfs wont report corruption - did you mean xfs_check?

> almost empty filesystem, hence the similarity with the above bug report.

Well, not sure its the same yet - what was your stack trace & did
repair report inodes with nlink==0?

> I didn't record the oops and output from xfs_repair. I'll update my git tree 

Ah, doh.

> tonight, rebuild and retest in hopes to find that oops again.

Great, thanks!

cheers.

-- 
Nathan
