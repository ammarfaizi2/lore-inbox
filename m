Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316571AbSEPD65>; Wed, 15 May 2002 23:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316572AbSEPD64>; Wed, 15 May 2002 23:58:56 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:17132 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S316571AbSEPD6z>; Wed, 15 May 2002 23:58:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: Roger Luethi <rl@hellgate.ch>
Subject: Re: [PATCH] VIA Rhine stalls: TxAbort handling
Date: Wed, 15 May 2002 15:52:35 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <20020514035318.GA20088@k3.hellgate.ch> <02051317475500.00917@cobra.linux> <20020516004927.GA13388@k3.hellgate.ch>
Cc: Urban Widmark <urban@teststation.com>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02051515523500.01017@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll take that down as "The patch didn't break anything" <g>. Thanks.

:) Some nice day this card will work.
I know it. It's too bad I don't have time to mess with it right now.

> What I have seen: switching from eeprom default (AMD/MBA backoff on my
> card) to something else (as VIA does) slows things down, but the TxAborts
> are gone. Did you try different backoff algorithms?

The slowdown I was talking about was actually with the new abort/underrun 
handling - I had tried it by myself before your patch. That's the what that 
quote was about. I think I handled both Abort and Underrun like that.
I'll try that new patch that you're making to retest.

> Also, you may want to try if the backoff bit in TxConfig makes a difference
> for you (may be different with your chip, after all). It's not a one-liner
> like ConfigD, though, since TxConfig gets overwritten in several places.
> On a side note, I'm not particularly happy about the way we stomp all over
> TxConfig when we set the threshold. IMO we should leave the lower 5 bits
> alone.

No, I haven't messed with those bits, to answer Urban and your question.
I've only tried your patch which forces the backoff algortihm to AMD.
Tests sound like a good idea. I'll try something out when I have time - been 
busy lately.

> The only data sheet I've seen for the VT86C100A agrees with the code, not
> the comment, so apparantly I don't have access to those more recent docs.
> This code is only used if you enable MMIO, though, which may not be a good
> idea if you already have problems with the driver.

On Urban's question,  I test without MMIO so this is not a related issue. I 
was merely curious since I don't feel comfortable trusting something which
A) does not match any of the other Rhine-based cards (2's and 3's)
B) says RESERVED in the docs which I have.

Funny, I was going to send you a link to the newer docs, but I ran into the 
older ones which I had never seen before. Yes, they do agree with the current 
code. Hmm. Perhaps we should ask VIA why it was changed...





