Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUG0O32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUG0O32 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 10:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266293AbUG0O31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 10:29:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13285 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266244AbUG0O3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 10:29:20 -0400
Date: Tue, 27 Jul 2004 15:29:18 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Message-ID: <20040727142918.GE12308@parcelfarce.linux.theplanet.co.uk>
References: <200407271233.04205.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407271233.04205.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 12:33:04PM -0400, Gene Heskett wrote:
> Greetings everybody;
> 
> I have now had 4 crashes while running 2.6.8-rc2, the last one
> requiring a full powerdown before the intel-8x0 could
> re-establish control over the sound.
> 
> All have had an initial Opps located in prune_dcache, and were
> logged as follows:
> Jul 27 07:58:58 coyote kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000

... which means that dentry_unused list got corrupted, which doesn't really
help.  Could you try to narrow it down to 2.6.8-rc1-bk<day>?
