Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTJQCTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 22:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTJQCTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 22:19:53 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:5127 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263277AbTJQCTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 22:19:51 -0400
Date: Thu, 16 Oct 2003 19:19:48 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031017021948.GI29279@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws> <20031017013245.GA6053@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017013245.GA6053@ncsu.edu>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This Outlook installation has been found to be susceptible to misuse.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 09:32:45PM -0400, jlnance@unity.ncsu.edu wrote:
> On Thu, Oct 16, 2003 at 04:04:48PM -0700, jw schultz wrote:
> > 
> > The idea of this sort of block level hashing to allow
> > sharing of identical blocks seems attractive but i wouldn't
> > trust any design that did not accept as given that there
> > would be false positives.
> 
> But at the same time we rely on TCP/IP which uses a hash (checksum)
> to detect back packets.  It seems to work well in practice even
> though the hash is weak and the network corrupts a lot of packets.
> 
> Lots of machines dont have ECC ram and seem to work reasonably well.

That is because most of the errors (which are few) get lost
in the noise of BSODs or are trivial data errors.  Can you
tell whether your application crashed because it had a bug
or because a bit in memory flipped?  Is tiis a typm or did a
bit or two flip on this email message?  There is a big
difference between single bit errors and having an entire
block of a file be wrong.

> It seems like these two are a lot more likely to bit you than hash
> collisions in MD5.  But Ill have to go read the paper to see what
> Im missing.

There is a big difference between the probability of any
random pair of blocks getting a false positive, much less a
given block with some corruption still hashing the same and
a false positive between one block and any of millions of
others.

It is a bit like the difference in odds between you winning
at this weeks lotto and anyone winning this week.  Are you
willing to bet that nobody wins this weeks lotto?  Would you
stake your life savings on it?


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
