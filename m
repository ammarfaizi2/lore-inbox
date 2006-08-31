Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWHaPQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWHaPQV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 11:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWHaPQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 11:16:21 -0400
Received: from ns.suse.de ([195.135.220.2]:3026 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932350AbWHaPQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 11:16:21 -0400
From: Andi Kleen <ak@suse.de>
To: Badari Pulavarty <pbadari@gmail.com>
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Thu, 31 Aug 2006 17:16:08 +0200
User-Agent: KMail/1.9.3
Cc: Jan Beulich <jbeulich@novell.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, petkov@math.uni-muenster.de,
       akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>
References: <20060820013121.GA18401@fieldses.org> <200608310941.40076.ak@suse.de> <1157036578.22667.6.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1157036578.22667.6.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608311716.08786.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 August 2006 17:02, Badari Pulavarty wrote:

> I will verify them when I get a chance to move to latest kernel.

Sorry I just meant the problem has been analyzed, but not fixed
yet (it is a bit tricky). Most of the fixes won't make 2.6.18
anyways because it's too late for that.

> Unfortunately, so called testcases are the *real* problems I am
> trying to track down in 2.6.18-rc4 and I have a setup/config/testcase
> which can reproduce them consistently. I don't want to change
> any kernel/config till I debug these issues. Once I figure out whats
> happening - I will move to latest and verify one more time.

Not needed right now.

> 
> Code: 0f 0b 68 d3 e0 50 80 c2 e7 0a 48 83 7b 38 00 75 0a 0f 0b 68
> RIP  [<ffffffff80282d39>] submit_bh+0x29/0x130
>  RSP <ffff8101bde8dd08>
>  <1>Unable to handle kernel paging request at 0000000146f4eac0 RIP:
>  [<ffffffff802277b8>] task_rq_lock+0x38/0x90
> PGD 1ddc2e067 PUD 0
> Oops: 0000 [2] SMP

Don't know why sorry, but it seems to be indeed before the unwinder. 
Maybe some state got messed up completely.

-Andi


> 
> 
