Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130480AbRBLFi6>; Mon, 12 Feb 2001 00:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbRBLFiu>; Mon, 12 Feb 2001 00:38:50 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:26519 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S130480AbRBLFie>;
	Mon, 12 Feb 2001 00:38:34 -0500
Message-ID: <20010212133248.A7147@saw.sw.com.sg>
Date: Mon, 12 Feb 2001 13:32:48 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>, vido@ldh.org
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: eepro100.c, kernel 2.4.1
In-Reply-To: <20010208201539.A19229@ldh.org> <200102081126.f18BQpS18016@moisil.dev.hydraweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <200102081126.f18BQpS18016@moisil.dev.hydraweb.com>; from "Ion Badulescu" on Thu, Feb 08, 2001 at 03:26:51AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion,

On Thu, Feb 08, 2001 at 03:26:51AM -0800, Ion Badulescu wrote:
> On Thu, 8 Feb 2001 20:15:39 +0900, Augustin Vidovic <vido@ldh.org> wrote:
> 
> >> eth0: Sending a multicast list set command from a timer routine........."
> >> 
> >> If you find such messages, the work-around really did something. Otherwise,
> >> it's the placebo effect...
> > 
> > Now, I do not get _any_ message in the logs, which means that the network
> > cards activity is closer to normality than before the patch.
> 
> So your patch did not do you any good. Case closed, as far as the work-around
> is concerned.

I've just checked: "Sending a multicast list set command" is printed only on
high debug levels, so Augustin might not see them.

If "Receiver lock-up workaround activated" message is printed, then the
workaround is really activated.
I doubt that the real reason is that RX bug, but periodic multicast list set
commands may certainly affect the behavior.

Augustin, could you send the output of `lspci' and `eepro100-diag -ee', please?
(The latter may be taken from ftp://scyld.com/pub/diag/)

Best regards
		Andrey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
