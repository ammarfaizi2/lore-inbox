Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264429AbRFIBh0>; Fri, 8 Jun 2001 21:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264430AbRFIBhR>; Fri, 8 Jun 2001 21:37:17 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:8452 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S264429AbRFIBg7>; Fri, 8 Jun 2001 21:36:59 -0400
To: Ion Badulescu <ionut@cs.columbia.edu>
Subject: Re: xircom_cb problems
Message-ID: <992050615.3b217db764868@eargle.com>
Date: Fri, 08 Jun 2001 21:36:55 -0400 (EDT)
From: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Tom Sightler <ttsig@tuxyturvy.com>, linux-kernel@vger.kernel.org,
        arjan@fenrus.demon.nl
In-Reply-To: <Pine.LNX.4.33.0106081333090.1029-100000@age.cs.columbia.edu>
In-Reply-To: <Pine.LNX.4.33.0106081333090.1029-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ion Badulescu <ionut@cs.columbia.edu>:

> On Fri, 8 Jun 2001, Tom Sightler wrote:
> 
> > OK, I tried your patch, it did fix the problem where pump wouldn't
> > pull an IP address, but I'm still having the problem where my ping
> > times go nuts.  I've attached an example, it's 100% repeatable on my
> > network at work.  It was so bad I couldn't get any benchmark
> numbers.
> 
> Just one more question: do you see the same bad ping times if you
> completely comment out the call to set_half_duplex?

No, the problem goes away if I do this, although then I hae the performance
problems as before.  I also noticed that even when the call to set_half_duplex
is left in, the switch reports that the link is still in full duplex, 100Mb
mode.  I tried forcing half duplex on the switch but this didn't help.  It
actually looks like half duplex is not really being set correctly.

I plugged in a desktop with an eepro100 based card and forced the duplex to half
with the command line options and the switch properly reported a half-duplex
link had been negotiated, with the xircom card the switch reports full-duplex
with or without the set_half_duplex line, which certainly implies it's not
really working right.

Hope the helps.  I won't be back at the office until Monday so that's the
earliest I'll be able to test again, but I'll be glad to test any combination
that I can.

Later,
Tom

