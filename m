Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbQLEToY>; Tue, 5 Dec 2000 14:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129449AbQLEToP>; Tue, 5 Dec 2000 14:44:15 -0500
Received: from cs.columbia.edu ([128.59.16.20]:36258 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129410AbQLEToA>;
	Tue, 5 Dec 2000 14:44:00 -0500
Date: Tue, 5 Dec 2000 11:13:27 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Andrey Savochkin <saw@saw.sw.com.sg>
cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <20001204211633.A16092@saw.sw.com.sg>
Message-ID: <Pine.LNX.4.21.0012051104510.7727-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2000, Andrey Savochkin wrote:

> > There is nothing relevant in the errata, unfortunately...
> 
> Do you have it?

I have the manual in the office, so I can look at it again in a couple of
days. I've used it to hack on the BSDI driver...

> The sympthomes are that the card triggers Flow Control Pause condition (and
> interrupt) on the last stages of the initialization or right after.
> And it happens with flow control being explicitly turned off.
> High network load considerably increase the chances of the event.
> After that the card stops to behave sane and reports status 0x7048.

Cool, I'll try to go over the driver init sequence by the end of the
weekend and let you know if I see anything wrong.

> It may happen that we don't understand something in the initialization
> sequence, or just a plain hardware bug.

Do you know if only one specific chip revision exhibits this problem? It
would really help track down the problem. If I remember correctly, 82557
doesn't have flow control at all, and 82558/9 have different 
implementations -- one is proprietary (82558) and one is standard (82559).

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
