Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbULXIgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbULXIgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 03:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbULXIgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 03:36:00 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54971 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261383AbULXIfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 03:35:55 -0500
Date: Thu, 23 Dec 2004 14:17:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: arjanv@redhat.com, "Brown, Len" <len.brown@intel.com>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: the patch of restore-pci-config-space-on-resume break S1 on ASUS2400 NE
Message-ID: <20041223131743.GA2618@openzaurus.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F84069D51E8@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84069D51E8@pdsmsx403>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Since 2.6.7, the Changes for drivers/pci/pci-driver.c@1.37 make my
> ASUS 2400NE hang on S1 resume. 
> 
> Should we by-pass pci_default_suspend(resume) for S1?
> Because, ACPI spec defines : in S1, all system context is preserved 
> with the exception of CPU caches.

I'd rather do the full driver resume, even in S1. Vendors
can't read so S1 does not really preserve *all* state on many
machines, and we need to get it right for S3, anyway.
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

