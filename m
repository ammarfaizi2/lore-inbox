Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUJGOuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUJGOuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUJGOuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:50:39 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:55726 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267186AbUJGOtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:49:42 -0400
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martijn Sipkema <msipkema@sipkema-digital.com>
Cc: Paul Jakma <paul@clubi.ie>, Chris Friesen <cfriesen@nortelnetworks.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       "David S. Miller" <davem@davemloft.net>, joris@eljakim.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <001c01c4ac76$fb9fd190$161b14ac@boromir>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
	 <20041006080104.76f862e6.davem@davemloft.net>
	 <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
	 <20041006082145.7b765385.davem@davemloft.net>
	 <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
	 <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org>
	 <4164EBF1.3000802@nortelnetworks.com>
	 <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org>
	 <001601c4ac72$19932760$161b14ac@boromir>
	 <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org>
	 <001c01c4ac76$fb9fd190$161b14ac@boromir>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097156727.31753.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Oct 2004 14:45:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Read the standard. The behavious of select() on sockets is explicitely
> described.

For a strict posix system, but then if we were a strict posix/sus system
you wouldn't be able to use mmap. Also the kernel doesn't claim to
implement posix behaviour, it avoids those areas were posix is stupid.

> > POSIX_ME_HARDER? ;)
> 
> Would you care to provide any real answers or are you just telling
> me to shut up because whatever Linux does is good, and not appear
> unreasonable by adding a ;) ..?

POSIX_ME_HARDER was an environment variable GNU tools used when users
wanted them to do stupid but posix mandated things instead of sensible
things. It was later changed to POSIXLY_CORRECT, which lost the point
somewhat.

> > You really shouldnt assume select state is guaranteed not to change 
> > by time you get round to doing IO. It's not safe, and not just on 
> > Linux - whatever POSIX says.
> 
> Any sane application would be written for the POSIX API as described
> in the standard, and a sane kernel should IMHO implement that standard
> whenever possible.

I doubt that. Sane applications are written to the BSD socket API not
POSIX 1003.1g draft 6.4 and relatives.

Alan

