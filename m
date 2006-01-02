Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWABQXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWABQXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWABQXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:23:33 -0500
Received: from sccrmhc14.comcast.net ([63.240.77.84]:13289 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750806AbWABQXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:23:33 -0500
Date: Mon, 2 Jan 2006 11:26:55 -0500
From: Kurt Wall <kwallinator@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Arjan's noinline Patch
Message-ID: <20060102162655.GJ5213@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060101155710.GA5213@kurtwerks.com> <20060102034350.GD5213@kurtwerks.com> <43B8FA70.2090408@gmail.com> <20060102151429.GH5213@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102151429.GH5213@kurtwerks.com>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15-rc6krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 10:14:29AM -0500, Kurt Wall took 0 lines to write:
> 
> Right, I need to isolate the effects of each variable. Results for gcc 
> 3.4.4 and 4.0.2, built with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled, appear
> below. Pardon the bad methodology.
> 
> $ size vmlinux.*
>    text    data     bss     dec     hex filename
> 2333474  461848  479920 3275242  31f9ea vmlinux.344.inline
> 2327319  462000  479920 3269239  31e277 vmlinux.344.noinline
> 2319085  461608  479984 3260677  31c105 vmlinux.402.inline
> 2313578  461800  479984 3255362  31ac42 vmlinux.402.noinline

Here are the results for gcc 3.4.4 and 4.0.2, built _without_
-Os:

$ size vmlinux*noopt
   text    data     bss     dec     hex filename
2584202  461848  479920 3525970  35cd52 vmlinux.344.inline.noopt
2578246  462000  479920 3520166  35b6a6 vmlinux.344.noinline.noopt
2626475  461856  479984 3568315  3672bb vmlinux.402.inline.noopt
2620807  462016  479984 3562807  365d37 vmlinux.402.noinline.noopt

Kurt
-- 
There are really not many jobs that actually require a penis or a
vagina, and all other occupations should be open to everyone.
		-- Gloria Steinem
