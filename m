Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275571AbRIZUUW>; Wed, 26 Sep 2001 16:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275578AbRIZUUM>; Wed, 26 Sep 2001 16:20:12 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:264 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S275571AbRIZUUA>;
	Wed, 26 Sep 2001 16:20:00 -0400
Date: Wed, 26 Sep 2001 22:20:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, bcrl@redhat.com,
        marcelo@conectiva.com.br, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
Message-ID: <20010926222021.A2086@suse.cz>
In-Reply-To: <Pine.LNX.4.33.0109261003480.8327-200000@penguin.transmeta.com> <E15mIfQ-0001E5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15mIfQ-0001E5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Sep 26, 2001 at 06:40:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 06:40:15PM +0100, Alan Cox wrote:

> > 	PIII:
> > 		nothing: 32 cycles
> > 		locked add: 50 cycles
> > 		cpuid: 170 cycles
> > 
> > 	P4:
> > 		nothing: 80 cycles
> > 		locked add: 184 cycles
> > 		cpuid: 652 cycles
> 
> 
> Original core Athlon (step 2 and earlier)
> 
> nothing: 11 cycles
> locked add: 22 cycles
> cpuid: 67 cycles
> 
> generic Athlon is
> 
> nothing: 11 cycles
> locked add: 11 cycles
> cpuid: 64 cycles

Interestingly enough, my TBird 1.1G insist on cpuid being somewhat
slower:

nothing: 11 cycles
locked add: 11 cycles
cpuid: 87 cycles

-- 
Vojtech Pavlik
SuSE Labs
