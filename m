Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUJGPc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUJGPc0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUJGPc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:32:26 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:52660 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S266896AbUJGPcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:32:24 -0400
Message-ID: <001f01c4ac8b$35849710$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Paul Jakma" <paul@clubi.ie>,
       "Chris Friesen" <cfriesen@nortelnetworks.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       "David S. Miller" <davem@davemloft.net>, <joris@eljakim.nl>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl> <20041006080104.76f862e6.davem@davemloft.net> <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com> <20041006082145.7b765385.davem@davemloft.net> <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com> <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com> <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir> <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org> <001c01c4ac76$fb9fd190$161b14ac@boromir> <1097156727.31753.44.camel@localhost.localdomain>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Thu, 7 Oct 2004 17:32:15 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> > Read the standard. The behavious of select() on sockets is explicitely
> > described.
> 
> For a strict posix system, but then if we were a strict posix/sus system
> you wouldn't be able to use mmap. Also the kernel doesn't claim to
> implement posix behaviour, it avoids those areas were posix is stupid.

mmap() _is_ in POSIX AFAIK. Also, there are other standards for things
that aren't in POSIX, but these are supersets.

> > > POSIX_ME_HARDER? ;)
> > 
> > Would you care to provide any real answers or are you just telling
> > me to shut up because whatever Linux does is good, and not appear
> > unreasonable by adding a ;) ..?
> 
> POSIX_ME_HARDER was an environment variable GNU tools used when users
> wanted them to do stupid but posix mandated things instead of sensible
> things. It was later changed to POSIXLY_CORRECT, which lost the point
> somewhat.

I actually also don't agree with this behaviour of the GNU tools..

> > > You really shouldnt assume select state is guaranteed not to change 
> > > by time you get round to doing IO. It's not safe, and not just on 
> > > Linux - whatever POSIX says.
> > 
> > Any sane application would be written for the POSIX API as described
> > in the standard, and a sane kernel should IMHO implement that standard
> > whenever possible.
> 
> I doubt that. Sane applications are written to the BSD socket API not
> POSIX 1003.1g draft 6.4 and relatives.

Perhaps... I get the idea that I just seem to value a standard operating
system interface more than you do; it would be a loss IMHO if people
were forced to write for Linux instead of being able to write portable
applications.

The POSIX interface shouldn't become something one reads to get an idea
of how things wil _not_ work on Linux.


--ms


