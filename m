Return-Path: <linux-kernel-owner+w=401wt.eu-S965002AbWL1Ii6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWL1Ii6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWL1Iih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:38:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3822 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964994AbWL1IiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:38:23 -0500
Date: Wed, 27 Dec 2006 18:44:21 +0000
From: Pavel Machek <pavel@ucw.cz>
To: yunfeng zhang <zyf.zeroos@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16.29 1/1] memory: enhance Linux swap subsystem
Message-ID: <20061227184421.GE4088@ucw.cz>
References: <4df04b840612260018u4be268cod9886edefd25c3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4df04b840612260018u4be268cod9886edefd25c3a@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-12-06 16:18:32, yunfeng zhang wrote:
> In the patch, I introduce a new page system -- pps which 
> can improve
> Linux swap subsystem performance, you can find a new 
> document in
> Documentation/vm_pps.txt. In brief, swap subsystem 
> should scan/reclaim
> pages on VMA instead of zone::active list ...

Is it april's fools days?

Read Doc*/SubmittingPatches.
							Pavel

> 
> --- patch-linux/fs/exec.c	2006-12-26 
> 15:20:02.683546016 +0800
> +++ linux-2.6.16.29/fs/exec.c	2006-09-13 
> 02:02:10.000000000 +0800
> @@ -323,0 +324 @@
> +	lru_cache_add_active(page);
> @@ -438 +438,0 @@
> -		enter_pps(mm, mpnt);

						Pavel
-- 
Thanks for all the (sleeping) penguins.
