Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVBOT2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVBOT2s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVBOT2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:28:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64458 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261832AbVBOT1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:27:41 -0500
Date: Tue, 15 Feb 2005 19:27:39 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Andi Kleen <ak@suse.de>
Cc: Matthew Wilcox <matthew@wil.cx>, Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, paulus@samba.org, anton@samba.org,
       davem@davemloft.net, ralf@linux-mips.org, tony.luck@intel.com,
       willy@debian.org, schwidefsky@de.ibm.com
Subject: Re: [PATCH] Consolidate compat_sys_waitid
Message-ID: <20050215192739.GM8859@parcelfarce.linux.theplanet.co.uk>
References: <20050215140149.0b06c96b.sfr@canb.auug.org.au> <20050215184307.GQ29917@parcelfarce.linux.theplanet.co.uk> <20050215192341.GA12050@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215192341.GA12050@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 08:23:41PM +0100, Andi Kleen wrote:
> > The reason it isn't in Linus' tree yet is that it depends on the
> > is_compat_task() predicate which Andi vetoed out of Andrew's tree.
> > As a result, I haven't been able to merge any of the compat stuff
> > sitting in the PA tree.  A few more voices in favour of reintroducing
> > is_compat_task() would help.
> 
> Just change PA-RISC to not need is_compat_task?   It's not that
> difficult really, you just have to split the parts that need
> to know about this into separate functions and files.

Seconded.  Come on, folks, you *know* that is_compat_task() is an invitation
for massive fuckups by driver-writers...
