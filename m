Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbRGTWap>; Fri, 20 Jul 2001 18:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267447AbRGTWag>; Fri, 20 Jul 2001 18:30:36 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:54517 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S267446AbRGTWa3>; Fri, 20 Jul 2001 18:30:29 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Petru Paler" <ppetru@ppetru.net>, <linux-kernel@vger.kernel.org>
Subject: RE: Getting destination address for UDP packets
Date: Fri, 20 Jul 2001 15:30:32 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMOEPACJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010720145544.D1267@ppetru.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> I'm working on a program which binds on all the available
> interfaces (0.0.0.0)
> and listens for/replies with UDP packets.

	You need to bind to each interface *address*.

> The problem is that I need to send back responses from the same
> IP address that
> the query arrived to, and this is not usually happening.

	Right, so bind each port to exactly one IP address.

> Example: supposing I have 1.1.1.2 and 1.1.1.3 aliased on the same
> interface, and
> a query arrives on 1.1.1.3, it's mandatory that the reply packet
> goes out from
> 1.1.1.3.

	Then bind one socket to each IP and send the reply from the same socket
that received it.

> The question is: how do I get (from user space, if possible) the
> destination
> IP address of an UDP packet?

	There are actually ways to do this, but the most portable way (and the way
NTP, bind, and others do it), is to bind to each IP that the program needs
to listen on.

	DS

