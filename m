Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVCAVyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVCAVyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVCAVyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:54:52 -0500
Received: from gprs215-167.eurotel.cz ([160.218.215.167]:24287 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262074AbVCAVyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:54:49 -0500
Date: Tue, 1 Mar 2005 22:54:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Hicks <mort@wildopensource.com>, pj@sgi.com,
       linux-kernel@vger.kernel.org, raybry@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-ID: <20050301215436.GC2129@elf.ucw.cz>
References: <20050214154431.GS26705@localhost> <20050214193704.00d47c9f.pj@sgi.com> <20050221192721.GB26705@localhost> <20050221134220.2f5911c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050221134220.2f5911c9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So what it comes down to is
> 
> sys_free_node_memory(long node_id, long pages_to_make_free, long what_to_free)
> 
> where `what_to_free' consists of a bunch of bitflags (unmapped pagecache,
> mapped pagecache, anonymous memory, slab, ...).

Heh, swsusp needs shrink_all_memory() and I'd like to use something
more generic as shrink_all_memory() does not seem to work properly. I
guess that loop over all node_ids should be easy ;-).

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
