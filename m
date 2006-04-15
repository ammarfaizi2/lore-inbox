Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWDODQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWDODQi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 23:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWDODQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 23:16:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:31909 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030214AbWDODQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 23:16:36 -0400
Subject: Re: Connector - how to start?
From: Matt Helsley <matthltc@us.ibm.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Libor Vanek <libor.vanek@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
In-Reply-To: <20060414192634.697cd2e3.rdunlap@xenotime.net>
References: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com>
	 <20060414192634.697cd2e3.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 20:07:17 -0700
Message-Id: <1145070437.28705.73.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-14 at 19:26 -0700, Randy.Dunlap wrote:
> On Sat, 15 Apr 2006 03:09:05 +0200 Libor Vanek wrote:
> 
> > Hi,
> > I'd like to start writing some small module using connector to send
> > messages to/from user-space. Unfortunately I'm absolutely not familiar
> > with netlink/connector API usage and I couldn't find any usefull
> > documentation (yes, I read Documentation/connector/ and tried Google).
> > 
> > So here's things which are not clear to me:
> > - the Documentation/connector containts only kernel-space example -
> > don't anybody have also "user-space client example"?
> > - how do I ACK message sent to/from user-space?
> > - in case of multiple clients listening how do I send message just to
> > (random) one (simple load balancing) or to all of them? (broadcasting)
> > - is there some "easy" way how to send longer messages then
> > CONNECTOR_MAX_MSG_SIZE?
> 
> There was a connector userspace example posted to lkml on
> 2005-SEP-28:
> 
> Subject: [RFC] Process Events Connector (test program)
> From:	Matthew Helsley <matthltc@us.ibm.com>
> 
> 
> It seems like one of the Red Hat guys had some netlink documentation
> and sample programs at people.redhat.com, but I can't find that
> just now.
> 
> ---
> ~Randy

Subject:[ANNOUNCE] Test Program for Filesystem Events Reporter
                              From: 
Yi Yang <yang.y.yi@gmail.com>

might demonstrate what you're looking for as well.

	I don't believe there is an existing way to send messages longer than
CONNECTOR_MAX_MSG_SIZE. Perhaps you could send multiple messages with
the same sequence number but a different "fragment number" in the
message.

	However, if you're sending messages much larger than
CONNECTOR_MAX_MSG_SIZE perhaps the medium of communication is not
appropriate. Have you considered relay files?

Cheers,
	-Matt Helsley

