Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132061AbRAXAJx>; Tue, 23 Jan 2001 19:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132068AbRAXAJn>; Tue, 23 Jan 2001 19:09:43 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:10040 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132061AbRAXAJi>; Tue, 23 Jan 2001 19:09:38 -0500
Date: Wed, 24 Jan 2001 01:09:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Sasi Peter <sape@iq.rulez.org>
Cc: Godfrey Livingstone <godfrey@hattaway-associates.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Ingo's RAID patch for 2.2.18 final?
Message-ID: <20010124010936.A1201@athlon.random>
In-Reply-To: <3A61315C.37318059@hattaway-associates.com> <Pine.LNX.4.30.0101240044040.3522-100000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101240044040.3522-100000@iq.rulez.org>; from sape@iq.rulez.org on Wed, Jan 24, 2001 at 12:52:57AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 12:52:57AM +0100, Sasi Peter wrote:
> On Sun, 14 Jan 2001, Godfrey Livingstone wrote:
> 
> > You MUST apply this patch before the two raid patches. The VM patch stablises
> > the 2.2.18 virtual memory system and if you don't apply my two repackaged
> > patches will fail. The above VM patch has been accepted into 2.2.19pre3 and
> > many people are using it so is not untested.
> 
> 2.2.19preXaaX Virtually disabled I/O cache extention-by-swapout, working
> on previous (semi)stock kernels (raid+ide patched) :(

Can you measure a performance degradation because of that? Previous kernels was
certainly not a good example because they was swapping out stuff even with
`cp /dev/zero .`.

> Thus I wouldn't advise VM global till it gets somewhatbalanced to
> non-swapless configs...

You said me your machine start to swapout when the filesystem cache reaches
100mbytes (on your 384Mbyte box). That seems sane behaviour on a misc load. We
could add some additional bit of page aging to swapout more when it worth
indeed, but current balance looks just quite sane.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
