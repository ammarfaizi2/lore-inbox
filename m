Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130180AbQLDNrV>; Mon, 4 Dec 2000 08:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130227AbQLDNrM>; Mon, 4 Dec 2000 08:47:12 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:8326 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S130180AbQLDNrD>;
	Mon, 4 Dec 2000 08:47:03 -0500
Message-ID: <20001204211633.A16092@saw.sw.com.sg>
Date: Mon, 4 Dec 2000 21:16:33 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <20001201175109.A4209@saw.sw.com.sg> <200012012145.eB1LjOl03300@moisil.dev.hydraweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <200012012145.eB1LjOl03300@moisil.dev.hydraweb.com>; from "Ion Badulescu" on Fri, Dec 01, 2000 at 01:45:24PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Dec 01, 2000 at 01:45:24PM -0800, Ion Badulescu wrote:
> On Fri, 1 Dec 2000 17:51:09 +0800, Andrey Savochkin <saw@saw.sw.com.sg> wrote:
> 
> > I've been promised that this issue would be looked up in Intel's errata by
> > people who had the access to it, but I haven't got the results yet.
> 
> There is nothing relevant in the errata, unfortunately...

Do you have it?
The sympthomes are that the card triggers Flow Control Pause condition (and
interrupt) on the last stages of the initialization or right after.
And it happens with flow control being explicitly turned off.
High network load considerably increase the chances of the event.
After that the card stops to behave sane and reports status 0x7048.

It may happen that we don't understand something in the initialization
sequence, or just a plain hardware bug.

> > The card itself doesn't report its revision in details.
> > It can be checked by `lspci'.
> > Rev 8 is 82559, if I remember, and rev 9 is 82559ER.
> 
> No, 82559ER has its own PCI id, 0x1209. There is also a newer 82559 chip
> which reports a different PCI device id, 0x1030 (I have one of those).

Yes, you're right.

> For the old chips reporting 0x1229, revisions 1-3 are 82557, revisions
> 4-5 are 82558 and revisions 6-8 are 82559.

Best regards
					Andrey V.
					Savochkin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
