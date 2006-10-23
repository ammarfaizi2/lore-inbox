Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWJWDSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWJWDSp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 23:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWJWDSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 23:18:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59539 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751308AbWJWDSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 23:18:44 -0400
Message-ID: <453C3488.2050401@redhat.com>
Date: Sun, 22 Oct 2006 22:18:32 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] more helpful WARN_ON and BUG_ON messages
References: <4538F81A.2070007@redhat.com> <45393CBD.8000400@goop.org>
In-Reply-To: <45393CBD.8000400@goop.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:

> This seems like a generally useful idea - certainly more valuable than 
> storing+printing the function name.
> 
> You might want to look at the BUG patches I wrote, which are currently 
> in -mm.  I added general machinery to allow architectures to easily 
> implement BUG() efficiently (ie, with a minimal amount of BUG-related 
> icache pollution).  If you were to store the BUG_ON expression, it would 
> be best to extend struct bug_entry and store it there - doing it in 
> asm-generic BUG_ON() means you still end up with code to set up the 
> printk in the mainline code path, and it also won't honour 
> CONFIG_DEBUG_BUGVERBOSE being disabled.

Thanks, I missed that change... I'll look into it.

-Eric
