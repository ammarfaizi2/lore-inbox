Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267509AbSLFCIs>; Thu, 5 Dec 2002 21:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267511AbSLFCIs>; Thu, 5 Dec 2002 21:08:48 -0500
Received: from holomorphy.com ([66.224.33.161]:28045 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267509AbSLFCIr>;
	Thu, 5 Dec 2002 21:08:47 -0500
Date: Thu, 5 Dec 2002 18:15:59 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, Norman Gaywood <norm@turing.une.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206021559.GK9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	Norman Gaywood <norm@turing.une.edu.au>,
	linux-kernel@vger.kernel.org
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206014429.GI1567@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 02:44:29AM +0100, Andrea Arcangeli wrote:
> Or it hurts when you can't allocate an inode because such 100M are in
> pagetables on a 64G box and you still have 60G free of highmem.

This is the zone vs. zone watermark stuff that penalizes/fails
allocations made with a given GFP mask from being satisfied by
fallback. This is largely old news wrt. various kinds of inability
to pressure those ZONE_NORMAL (maybe also ZONE_DMA) consumers.

Admission control for fallback is valuable, sure. I suspect the
question akpm raised is about memory utilization. My own issues are
centered around allocations targeted directly at ZONE_NORMAL,
which fallback prevention does not address, so the watermark patch
is not something I'm personally very concerned about.

64GB isn't getting any testing that I know of; I'd hold off until
someone's actually stood up and confessed to attempting to boot
Linux on such a beast. Or until I get some more RAM. =)


Bill
