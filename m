Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLFMyH>; Wed, 6 Dec 2000 07:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131441AbQLFMx6>; Wed, 6 Dec 2000 07:53:58 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:62854 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S129423AbQLFMxp>;
	Wed, 6 Dec 2000 07:53:45 -0500
Message-ID: <20001206202313.A26438@saw.sw.com.sg>
Date: Wed, 6 Dec 2000 20:23:13 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <20001204211633.A16092@saw.sw.com.sg> <Pine.LNX.4.21.0012051104510.7727-100000@age.cs.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.4.21.0012051104510.7727-100000@age.cs.columbia.edu>; from "Ion Badulescu" on Tue, Dec 05, 2000 at 11:13:27AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 05, 2000 at 11:13:27AM -0800, Ion Badulescu wrote:
> On Mon, 4 Dec 2000, Andrey Savochkin wrote:
> 
> > > There is nothing relevant in the errata, unfortunately...
> > 
> > Do you have it?
> 
> I have the manual in the office, so I can look at it again in a couple of
> days. I've used it to hack on the BSDI driver...

Fine!

> > The sympthomes are that the card triggers Flow Control Pause condition (and
> > interrupt) on the last stages of the initialization or right after.
> > And it happens with flow control being explicitly turned off.
> > High network load considerably increase the chances of the event.
> > After that the card stops to behave sane and reports status 0x7048.
> 
> Cool, I'll try to go over the driver init sequence by the end of the
> weekend and let you know if I see anything wrong.

May be, there is a mandatory delay missing somewhere..

> > It may happen that we don't understand something in the initialization
> > sequence, or just a plain hardware bug.
> 
> Do you know if only one specific chip revision exhibits this problem? It
> would really help track down the problem. If I remember correctly, 82557
> doesn't have flow control at all, and 82558/9 have different 
> implementations -- one is proprietary (82558) and one is standard (82559).

I personally have seen it with 82559ER only.
But there have been some reports about 82559, too.

Best regards
		Andrey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
