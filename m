Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTLJRou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbTLJRou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:44:50 -0500
Received: from us01smtp2.synopsys.com ([198.182.44.80]:10486 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S263798AbTLJRoq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:44:46 -0500
Message-ID: <3FD75B8A.21FA59D9@synopsys.com>
Date: Wed, 10 Dec 2003 12:44:42 -0500
From: Chris Petersen <Chris.Petersen@synopsys.com>
Reply-To: Chris.Petersen@synopsys.com
Organization: Synopsys, Inc.
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Chris Petersen <Chris.Petersen@synopsys.COM>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: FIXED (was Re: PROBLEM:  Blk Dev Cache causing kswapd thrashing)
References: <Pine.LNX.4.44.0311271649520.21568-100000@logos.cnet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

It appears the block-device-cache/kswapd problem is indeed fixed in
2.4.23 (yay!).

To confuse matters RedHat has released an RPM with 2.4.20-24.7 which
apparently contains later patches that include the fix.  This can be
confusing because their 2.4.21-4EL kernel is busted (WRT this bug).
But, at least this way we can simply tell our RH-based customers to go
grab the RPM.

Thanks,
-chris

Marcelo Tosatti wrote:
> 
> On Tue, 25 Nov 2003, William Lee Irwin III wrote:
> 
> > On Tue, Nov 25, 2003 at 04:03:56PM -0500, Chris Petersen wrote:
> > > The block device cache is causing kswapd thrashing, usually bringing
> > > the system to a halt.
> > > This problem has been reproduced on kernels as recent as 2.4.21.
> > > In our application we deal with large (multi-GB) files on multi-CPU
> > > 4GB platforms.  While handling these files, the block device cache
> > > allocates all remaining available memory (3.5G) up to the 4G
> > > physical limit.
> >
> > Please try 2.4.23-rc5, and if that doesn't fix it, try 2.6.0-test10.
> > AIUI both have page replacement improvements over 2.4.21.
> 
> Chris,
> 
> Did you try 2.4 already?
> 
> If you didnt, please tell me results when you do so.
> 
> Thanks

-- 
-----------------------------------------------------------------
Chris M. Petersen                                cmp@synopsys.com
Sr. R&D Engineer

Synopsys, Inc.                                    o: 919.425.7342
1101 Slater Road, Suite 300                       c: 919.349.6393
Durham, NC  27703                                 f: 919.425.7320
-----------------------------------------------------------------
