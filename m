Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUG2Hin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUG2Hin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 03:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267223AbUG2Hin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 03:38:43 -0400
Received: from gprs214-173.eurotel.cz ([160.218.214.173]:22656 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264213AbUG2Hij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 03:38:39 -0400
Date: Thu, 29 Jul 2004 09:38:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: ncunningham@linuxmail.org, Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: -mm swsusp: do not default to platform/firmware
Message-ID: <20040729073821.GA828@elf.ucw.cz>
References: <B44D37711ED29844BEA67908EAF36F03712639@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B44D37711ED29844BEA67908EAF36F03712639@pdsmsx401.ccr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >If the thread is needed for writing the image to storage, you should
> >instead set the PF_NOFREEZE process flag when creating the thread.
> >
> You know for sleep into mem (s3) we also use
> 'freeze_processes/refrigerator', and the threads don't write image to
> storage for S3. Should the threads be set the PF_NOFREEZE? Is there any
> side effect for S3 if the threads are running?

Threads that are "NOFREEZE" should be carefull not to do anything bad
to drivers, and if it works as NOFREEZE for swsusp, it will work in
S3, too. No need to do additional work of freezing based on new state.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
