Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTBSRnb>; Wed, 19 Feb 2003 12:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTBSRnb>; Wed, 19 Feb 2003 12:43:31 -0500
Received: from ns.suse.de ([213.95.15.193]:59918 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263204AbTBSRna>;
	Wed, 19 Feb 2003 12:43:30 -0500
To: "Sowadski, Craig Harold (UMR-Student)" <sowadski@umr.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 amd speculative caching
References: <A5D66E6B6F478B48A3CEF22AA4B9FCA3012E54@umr-mail1.umr.edu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Feb 2003 18:53:33 +0100
In-Reply-To: "Sowadski, Craig Harold's message of "19 Feb 2003 17:39:31 +0100"
Message-ID: <p73u1f0xile.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sowadski, Craig Harold (UMR-Student)" <sowadski@umr.edu> writes:

> I have recently upgraded to an AMD processor that is exhibiting the
> problems with the AMD speculative caching bug. Kernel 2.4.19 seems to

It's actually not an AMD bug, but an Linux bug that assumed undefined x86
behaviour to behave well. 

> fix the problem with the temporary work-around (adv-spec-cache patch). I
> have noticed that the patch has been removed from 2.4.20 and I am
> wondering if there is some other mechanism that is supposed to address
> this issue. Currently I have a  2.4.20 kernel with same configuration as

Yes, there is a new mechanism to address the problem the adv-spec-cache
patch solved. It enforces that there are not conflicting cache attributes
for memory mappings.

> my 2.4.19 and the problem seems to have reappeared.

What problem exactly? And does mem=nopentium help ?

-Andi
