Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752583AbVHGTDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbVHGTDe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 15:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbVHGTDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 15:03:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:23246 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1752576AbVHGTDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 15:03:17 -0400
Date: Sun, 7 Aug 2005 21:00:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pavel@suse.cz, pratap@vmware.com,
       Riley@Williams.Name
Subject: Re: [PATCH 1/1] i386 Encapsulate copying of pgd entries
Message-ID: <20050807190017.GE1024@openzaurus.ucw.cz>
References: <200508060026.j760Q6FT025108@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508060026.j760Q6FT025108@zach-dev.vmware.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This helps complete the encapsulation of updates to page tables (or pages
> about to become page tables) into accessor functions rather than using
> memcpy() to duplicate them.  This is both generally good for consistency
> and also necessary for running in a hypervisor which requires explicit
> updates to page table entries.

Hmm, I'm not sure if this kind of hypervisor can reasonably work with swsusp;
swsusp is just copying memory, it does not know which part of memory are page tables.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

