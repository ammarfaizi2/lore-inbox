Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbUJ2KAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUJ2KAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbUJ2KAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:00:11 -0400
Received: from gprs214-50.eurotel.cz ([160.218.214.50]:55168 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263191AbUJ2KAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:00:06 -0400
Date: Fri, 29 Oct 2004 11:59:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: "Zhu, Yi" <yi.zhu@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [swsusp] print error message when swapping is disabled
Message-ID: <20041029095952.GB1003@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD305756F342F@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305756F342F@pdsmsx402.ccr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > Another case is PSE disabled. Should notify this to user also.
> >>
> >> Here is a patch to address it.
> >
> >Patch is okay (but I rararely see this kind of failure in
> >wild). Please submit via akpm.
> >
> Enable DEBUG_PAGEALLOC will disable PSE. 
> Possibly a stupid question, why swsusp need PSE? I didn't see any
> relationship between the two.

swsusp relies on fact that kernel 1:1 mapping is self-contained in
top-level pagedir. That is not true without PSE, right?

[Hmm, probably bigger comment explaining this would be nice...]

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
