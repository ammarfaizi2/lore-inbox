Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWIRTGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWIRTGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 15:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWIRTGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 15:06:30 -0400
Received: from chain.digitalkingdom.org ([64.81.49.134]:11913 "EHLO
	chain.digitalkingdom.org") by vger.kernel.org with ESMTP
	id S1751814AbWIRTGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 15:06:30 -0400
Date: Mon, 18 Sep 2006 12:06:28 -0700
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM
Message-ID: <20060918190628.GE4610@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org> <p73bqpd62b2.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73bqpd62b2.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
From: Robin Lee Powell <rlpowell@digitalkingdom.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 09:50:41AM +0200, Andi Kleen wrote:
> Robin Lee Powell <rlpowell@digitalkingdom.org> writes:
> > 
> > This version is rather different, as it ends in:
> > 
> >     HARDWARE ERROR
> >     CPU 0: Machine Check Exception:                7 Bank 3: b40000000000083b
> >     RIP 10:<ffffffff80446e3e> {pci_conf1_read+0xbe/0xf0}
> >     TSC 2e7932dbf8 ADDR fdfc000cfc
> >     This is not a software problem!
> >     Run through mcelog --ascii to decode and contact your hardware vendor
> >     Kernel panic - not syncing: Uncorrected machine check
> 
> Decoded it gives
> 
> ..
>   bus error 'local node origin, request didn't time out
>       data read mem transaction
>       i/o access, level generic'
> ..
> 
> It will probably boot with mce=off acpi=off pci=conf1 

Indeed!  Even on the ones that weren't having an MCE problem.

> You got some buggy device that causes a bus timeout when its
> config space is read. The old kernel most likely didn't touch it
> by luck.
> 
> Please add the following patch and send the whole log. This will
> tell us which device has this problem.

OK.  I'll post results in a bit.

-Robin

-- 
http://www.digitalkingdom.org/~rlpowell/ *** http://www.lojban.org/
Reason #237 To Learn Lojban: "Homonyms: Their Grate!"
Proud Supporter of the Singularity Institute - http://singinst.org/
