Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277293AbRJNUGH>; Sun, 14 Oct 2001 16:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277295AbRJNUF6>; Sun, 14 Oct 2001 16:05:58 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:36736 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S277293AbRJNUFn>; Sun, 14 Oct 2001 16:05:43 -0400
Message-ID: <3BC9F029.3897ABE5@welho.com>
Date: Sun, 14 Oct 2001 23:06:01 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: ak@muc.de, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
In-Reply-To: <200110141940.XAA07004@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> > And why (1) is a problem is precisely what I don't understand. Nagle is
> > *supposed* to prevent you from sending multiple remnants.
> 
> It is not supposed to delay between sends for delack timeout.
> Nagle did not know about brain damages which his great idea
> will cause when used together with delaying acks. :-)

Well, I think this "problem" is way overstated. With a low latency path
the delay ack estimator should already take care of this. With a high
latency path you're out of luck in any case.

Besides, as I said, you can always disable Nagle in an interactive
application. I suppose it would be nice to have a socket option to
disable delayack as well, just for completeness.

> > is acked. This can be solved using an idea from Greg Minshall, which I
> > thought was quite cool.
> 
> It is approach used in 2.4. :-)

Cool. :)

> It does help when sender is also linux-2.4. :-)
> 
> Alexey

Regards,

	MikaL
