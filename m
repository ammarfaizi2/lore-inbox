Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130371AbRAKOBR>; Thu, 11 Jan 2001 09:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130388AbRAKOBG>; Thu, 11 Jan 2001 09:01:06 -0500
Received: from hermes.mixx.net ([212.84.196.2]:1038 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130371AbRAKOA5>;
	Thu, 11 Jan 2001 09:00:57 -0500
Message-ID: <3A5DBBE3.E3674A2C@innominate.de>
Date: Thu, 11 Jan 2001 14:57:55 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <3A57DA3E.6AB70887@uow.edu.au> from "Andrew Morton" at Jan 07, 2001 01:53:50 PM <200101110312.UAA06343@toltec.metran.cx> <3A5D994A.1568A4D5@uow.edu.au> <200101110519.VAA02784@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
>          2) It affects only code which can burn a lot of cpu without
>             scheduling.  Compare this to schemes which make the kernel
>             fully pre-emptable, causing _EVERYONE_ to pay the price of
>             low-latency....

Is there necessarily a price?  Kernel preemption can make io-bound code
go faster by allowing a blocked task to start running again immediately
on io completion.  As things are now, the task will have to wait for
whatever might be happening in the kernel to complete.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
