Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314067AbSEMPlm>; Mon, 13 May 2002 11:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSEMPll>; Mon, 13 May 2002 11:41:41 -0400
Received: from c9outbound.ctmail.com ([216.163.188.209]:45327 "EHLO
	C9Mailgw02.amadis.com") by vger.kernel.org with ESMTP
	id <S314067AbSEMPlj>; Mon, 13 May 2002 11:41:39 -0400
Message-ID: <3CDFDEAA.A55E2A8F@starband.net>
Date: Mon, 13 May 2002 11:41:30 -0400
From: Justin Piszcz <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: sg in 2.4.18
In-Reply-To: <20020513101050.A3879@coredump.electro-mechanical.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two Plextor 12/10/32A CDRW's.

IDE 0 - MASTER: HDD
             SLAVE: Plextor
IDE 1 - MASTER: Plextor

I burn two cds at the same time at 12X.

The catch is, the Plextors have burn proof.

When the CD-R drive goes to finalize the disc on IDE 0, the IDE 1 stops
writing for 3-5 seconds, then it continues.

This is because it is on the same chain as the HDD.

So you ask, why not get a Promise controller and do that?
I also have an ATA 100 Promise controller.

Believe it or not, any combination with the promise controller only yields
results worse than the setup I've mentioned above.

I'm not sure why, but any combination you can think of (between the card, and

two IDE busses on the motherboard) I have tried.

Any combination involving the promise makes each drive resort to burnproof
every 5-10 seconds, when I was doing tests, it took about 30-40 minutes to
burn @ 12X (two cds parellel) due to falling back to burnproof every 5
seconds or so.

Also, putting both burners on the same chain currently does not work.
Because when cdrecord sends the command to FIX the cd after it is done
burning the data, the command gets sent to both IDE drives causing cdrecord
to blow up (the burn fails) on the other burner.



William Thompson wrote:

> Is it possible to open sg more than once for multiple devices?
>
> IE, cdrecord 2 cds at once.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

