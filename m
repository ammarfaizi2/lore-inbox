Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWABPLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWABPLI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 10:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWABPLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 10:11:08 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:58299 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750771AbWABPLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 10:11:06 -0500
Date: Mon, 2 Jan 2006 10:14:29 -0500
From: Kurt Wall <kwallinator@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Matan Peled <chaosite@gmail.com>
Subject: Re: Arjan's noinline Patch
Message-ID: <20060102151429.GH5213@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Matan Peled <chaosite@gmail.com>
References: <20060101155710.GA5213@kurtwerks.com> <20060102034350.GD5213@kurtwerks.com> <43B8FA70.2090408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B8FA70.2090408@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15-rc6krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 12:03:28PM +0200, Matan Peled took 0 lines to write:
> Kurt Wall wrote:
> >the "noinline" cases were built with Arjan's patch and
> >CONFIG_CC_OPTIMIZE_FOR_SIZE; the "inline" kernels were built,
> >obviously, without the patch and without CONFIG_CC_OPTIMIZE_FOR_SIZE.
> 
> Wait, so how do we know if its GCC's -Os that caused the reduction in .text 
> size, or the noinline patch ... ?

Right, I need to isolate the effects of each variable. Results for gcc 
3.4.4 and 4.0.2, built with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled, appear
below. Pardon the bad methodology.

$ size vmlinux.*
   text    data     bss     dec     hex filename
2333474  461848  479920 3275242  31f9ea vmlinux.344.inline
2327319  462000  479920 3269239  31e277 vmlinux.344.noinline
2319085  461608  479984 3260677  31c105 vmlinux.402.inline
2313578  461800  479984 3255362  31ac42 vmlinux.402.noinline

Kurt
-- 
Those who do not understand Unix are condemned to reinvent it, poorly.
		-- Henry Spencer
