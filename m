Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130764AbRBAXRZ>; Thu, 1 Feb 2001 18:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130851AbRBAXRP>; Thu, 1 Feb 2001 18:17:15 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61201 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130764AbRBAXRC>; Thu, 1 Feb 2001 18:17:02 -0500
Subject: Re: SO_REUSEADDR redux
To: pausmith@nortelnetworks.com (Paul D. Smith)
Date: Thu, 1 Feb 2001 22:39:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14969.57896.331183.374489@lemming.engeast.baynetworks.com> from "Paul D. Smith" at Feb 01, 2001 05:24:40 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OSOC-0005FD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This application uses SO_REUSEADDR in conjunction with INADDR_ANY.  What
> it does is bind() to INADDR_ANY, then listen().  Then, it proceeds to
> bind (but _not_ listen) various other specific addresses.

That should be ok if its setting SO_REUSEADDR

> not a security problem: what's really the problem is having two
> _listens_.  As long as you're only listening on the one, I don't see how
> connections/packets could be stolen.

UDP.

In fact the classic exploit consisted of binding to port 2049 witha specific
connect address set on UDP and stealing NFS packets..

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
