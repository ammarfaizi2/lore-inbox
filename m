Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277904AbRJISw7>; Tue, 9 Oct 2001 14:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277905AbRJISwu>; Tue, 9 Oct 2001 14:52:50 -0400
Received: from nsd.netnomics.com ([216.71.84.35]:63760 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S277904AbRJISwd>; Tue, 9 Oct 2001 14:52:33 -0400
Date: Tue, 9 Oct 2001 13:52:53 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Rui Sousa <rui.p.m.sousa@clix.pt>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        emu10k1-devel@opensource.creative.com
Subject: Re: [Emu10k1-devel] Re: Emu10k1 driver update
In-Reply-To: <Pine.LNX.4.33.0110092019470.3012-100000@sophia-sousar2.nice.mindspeed.com>
Message-ID: <Pine.LNX.3.96.1011009135124.9171F-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Rui Sousa wrote:
> Actually there is no locking implemented for the ac97 codec mixer.
> It never seemed worth it, even if there are potential races in the code.
> To have two applications accessing the mixer at the same time is a _very_
> rare condition and the worse that can happen is to set a wrong volume
> value. Anyway, I will give it another look and try to come up with a fix.

I have a patch in the wings which adds locking to mixer accesses, for
via82cxxx_audio, because the lack of locking was causing problems.  So,
some people with some apps do indeed notice...

	Jeff



