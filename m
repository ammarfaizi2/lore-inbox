Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbVKBFHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbVKBFHf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbVKBFHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:07:34 -0500
Received: from dvhart.com ([64.146.134.43]:28842 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751500AbVKBFHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:07:34 -0500
Date: Tue, 01 Nov 2005 21:07:39 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andi Kleen <ak@suse.de>, Bob Picco <bob.picco@hp.com>,
       Andy Whitcroft <apw@shadowen.org>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
Message-ID: <222900000.1130908059@[10.10.2.4]>
In-Reply-To: <200510310312.18395.ak@suse.de>
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi> <1130607017.12551.5.camel@localhost> <20051031001727.GC6019@localhost.localdomain> <200510310312.18395.ak@suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Andi Kleen <ak@suse.de> wrote (on Monday, October 31, 2005 03:12:17 +0100):

> On Monday 31 October 2005 01:17, Bob Picco wrote:
> 
>> This is a slightly modified patch I used on x86_64 for EXTREME testing. The
>> original 2.6.13-rc1-mhp1 patch didn't apply cleanly against 2.6.14. It will
>> apply with this untested patch.  The patch needs to have arch_sparse_init
>> which is only active for SPARSEMEM. This patch was just for testing EXTREME
>> on x86_64 NUMA and needs review.
>> 
>> I think the bootmem allocator is being used before initialized.  This
>> wouldn't have happened before SPARSEMEM_EXTREME became the default.
>> 
>> If you feel my analysis is correct, I'll generate a cleaner patch and
>> test on my 4 way.
> 
> Ok the question is - why did nobody submit this patch in time? When
> sparse was merged I assumed folks would actually test and maintain
> it. But that doesn't seem to be the case? Somewhat surprising.
> 
> I personally don't care much about sparsemem right now because it doesn't have 
> any advantage and if it's unmaintained would consider to mark it 
> CONFIG_BROKEN. That's simply because we can't have highly experimental 
> CONFIGs in a production kernel that unsuspecting users can just set and break 
> their configuration.
> 
> Dave, is there someone in charge for sparsemem on x86-64?

Sparsemem is Andy's baby. He is duly cc'ed.

M.



