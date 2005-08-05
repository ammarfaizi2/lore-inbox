Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbVHEIMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbVHEIMI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 04:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbVHEIMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 04:12:08 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26248 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262910AbVHEIJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 04:09:35 -0400
Date: Fri, 5 Aug 2005 10:10:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: Bugs on your remap_file_pages protections implementations
Message-ID: <20050805081013.GB6409@elte.hu>
References: <200508042124.36786.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508042124.36786.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Blaisorblade <blaisorblade@yahoo.it> wrote:

> Hi Ingo, I'm the young UML hacker you met at OLS and who got your UML 
> patches sent ;-)
> 
> I've been studying your patch (and the whole Linux VM, indeed) in the 
> past days, and I have some remarks, about the version of the code in 
> 2.6.4-rc2-mm1 (which is the same you sent me) - I've now downloaded 
> the version dropped from 2.6.5-mm1, but it doesn't seem to address 
> those problems.
> 
> Btw, I've now seen why that patch was dropped, but not why it wasn't 
> resubmit.

was not resubmitted due to me only having 30 hours available to hack, 
per day ;) Feel free to pick the patch up.

> *) with your patch, remapped pages without MAP_INHERIT are IMHO not 
> safe across swapout; re-swapping them in will pass through the 
> arch-specific fault handler, which will check VMA's protections, and 
> fail if the VMA originally had MAP_NONE. Or am I missing something?

not sure, was a long time ago. I have checked swap-safeness, but only 
once. UML did work though, but i dont think i ever pushed it into 
swapping out its RAM-file.

	Ingo
