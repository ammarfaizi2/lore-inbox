Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVBOTYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVBOTYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVBOTYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:24:09 -0500
Received: from ns.suse.de ([195.135.220.2]:51158 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261829AbVBOTYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:24:07 -0500
Date: Tue, 15 Feb 2005 20:23:41 +0100
From: Andi Kleen <ak@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, paulus@samba.org, anton@samba.org,
       davem@davemloft.net, ralf@linux-mips.org, tony.luck@intel.com,
       ak@suse.de, willy@debian.org, schwidefsky@de.ibm.com
Subject: Re: [PATCH] Consolidate compat_sys_waitid
Message-ID: <20050215192341.GA12050@wotan.suse.de>
References: <20050215140149.0b06c96b.sfr@canb.auug.org.au> <20050215184307.GQ29917@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215184307.GQ29917@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The reason it isn't in Linus' tree yet is that it depends on the
> is_compat_task() predicate which Andi vetoed out of Andrew's tree.
> As a result, I haven't been able to merge any of the compat stuff
> sitting in the PA tree.  A few more voices in favour of reintroducing
> is_compat_task() would help.

Just change PA-RISC to not need is_compat_task?   It's not that
difficult really, you just have to split the parts that need
to know about this into separate functions and files.

-Andi
