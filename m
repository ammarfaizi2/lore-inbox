Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269491AbRHCRXC>; Fri, 3 Aug 2001 13:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269505AbRHCRWx>; Fri, 3 Aug 2001 13:22:53 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:57357 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S269482AbRHCRWe>;
	Fri, 3 Aug 2001 13:22:34 -0400
Message-Id: <200108022231.CAA00375@mops.inr.ac.ru>
Subject: Re: [PATCH] Inbound Connection Control mechanism: Prioritized Accept
To: samudrala@us.ibm.com (Sridhar Samudrala)
Date: Fri, 3 Aug 2001 02:31:51 +0400 (MSD)
Cc: kuznet@ms2.inr.ac.ru, thiemo@sics.se, dmfreim@us.ibm.com, hadi@cybeus.ca,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        diffserv-general@lists.sourceforge.net, rusty@rustcorp.com.au
In-Reply-To: <Pine.LNX.4.21.0108020956320.25553-100000@w-sridhar2.des.sequent.com> from "Sridhar Samudrala" at Aug 2, 1 10:17:11 am
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This looks like an elegant way of prioritizing without penalizing low priority
> connections in the absence of high priority ones.
> There may be an issue with sockets in accept queue which have received data.
> Is it OK to move a socket which has already received some data back to SYN-RECV 
> state and expect the data to be resent?

No, if you ACKed it. 500msec is maximum... Not so big number.

But inside 500msec there are no problems with HTTP, where this ACK is
better to maximally delay to piggyback to reply in any case.

Alexey

