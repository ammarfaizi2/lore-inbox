Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVHCIrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVHCIrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 04:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVHCIrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 04:47:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:54233 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262150AbVHCIrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 04:47:10 -0400
Date: Wed, 3 Aug 2005 10:46:59 +0200
From: Andi Kleen <ak@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org,
       "alan@lxorguk.ukuu.org.uk Siddha, Suresh B" 
	<suresh.b.siddha@intel.com>,
       Andi Kleen <ak@suse.de>
Subject: Re: [04/13] x86_64 memleak from malicious 32bit elf program
Message-ID: <20050803084659.GA10895@wotan.suse.de>
References: <20050803064439.GO7762@shell0.pdx.osdl.net> <20050803065220.GS7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803065220.GS7762@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok for me. Thanks Suresh.

-Andi


On Tue, Aug 02, 2005 at 11:52:20PM -0700, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> 
> malicious 32bit app can have an elf section at 0xffffe000.  During
> exec of this app, we will have a memory leak as insert_vm_struct() is
> not checking for return value in syscall32_setup_pages() and thus not
> freeing the vma allocated for the vsyscall page.
> 
