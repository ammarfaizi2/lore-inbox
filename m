Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268870AbRG0QNi>; Fri, 27 Jul 2001 12:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268875AbRG0QNS>; Fri, 27 Jul 2001 12:13:18 -0400
Received: from pulsar.zoreil.com ([212.43.230.120]:46722 "EHLO
	pulsar.zoreil.com") by vger.kernel.org with ESMTP
	id <S268870AbRG0QNP>; Fri, 27 Jul 2001 12:13:15 -0400
Date: Fri, 27 Jul 2001 18:11:27 +0200
From: =?iso-8859-1?Q?Fran=E7ois_romieu?= <romieu@zoreil.com>
To: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FarSync T-Series tweak and question
Message-ID: <20010727181127.A5157@zoreil.com>
In-Reply-To: <20010703182803.A13853@xyzzy.clara.co.uk> <20010704161845.A27070@zoreil.com> <20010709161947.B15379@xyzzy.clara.co.uk> <20010726155123.A5815@xyzzy.clara.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010726155123.A5815@xyzzy.clara.co.uk>; from rjd@xyzzy.clara.co.uk on Thu, Jul 26, 2001 at 03:51:23PM +0100
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

The Thu, Jul 26, 2001 at 03:51:23PM +0100, Robert J.Dunlop wrote :
[...]
> > > +        if ( ++port->txpos >= NUM_TX_BUFFER )
> > > +                port->txpos = 0;
[...]
> > I think mine is clearer but then I've always bumped and wrapped pointers and
> > indexs that way. Another alternative would be:
> >     port->txpos = ( port->txpos + 1 ) % NUM_TX_BUFFER;
> 
> Having taken the time that the % operation wouldn't be detrimental on other
> processor architectures and having checked with a small test that the
> alternate form produced tighter code on Intel I applied the change to my 
> driver.  The code that had shrunk in a small test got bigger (and slower?) 
> in the driver :-(

Have you the .o at hand ? I'd be curious to objdump them.
Btw, I don't believe either expression impacts the perfs. During init,
it's not time critical and while processing data, it looks like the driver 
does himself the dma with the adapter.

--
Ueimor
