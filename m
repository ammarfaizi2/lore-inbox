Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269196AbUISIc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269196AbUISIc7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 04:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269197AbUISIc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 04:32:58 -0400
Received: from gprs214-222.eurotel.cz ([160.218.214.222]:61061 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269196AbUISIc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 04:32:57 -0400
Date: Sun, 19 Sep 2004 10:32:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Suspend2 Merge: Supress various actions/errors while suspending [0/5]
Message-ID: <20040919083244.GA19005@elf.ucw.cz>
References: <1095378659.5897.96.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095378659.5897.96.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patches suppress various actions and errors while we're
> suspending.
> 
> Patch 1 disables the OOM killer and patch 3 complaining when no memory
> is available for an allocation. These are needed because swsusp and
> suspend2 both reduce the size of an image by allocating all the memory
> they can get, thus inciting the vm to free/swap out memory. This in turn
> can lead to processes being OOM killed and/or errors in the logs about
> not being able to allocate pages.

swsusp1 has some less ugly solution that is able to free memory but
not provoke OOM killer. I guess you should use it and drop this patch.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
